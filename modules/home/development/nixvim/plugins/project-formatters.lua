local M = {}

local configs = {
  oxfmt = { ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts" },
  prettier = {
    ".prettierrc", ".prettierrc.json", ".prettierrc.yml", ".prettierrc.yaml",
    ".prettierrc.json5", ".prettierrc.toml", ".prettierrc.js", ".prettierrc.cjs",
    ".prettierrc.mjs", ".prettierrc.ts", ".prettierrc.cts", ".prettierrc.mts",
    "prettier.config.js", "prettier.config.cjs", "prettier.config.mjs",
    "prettier.config.ts", "prettier.config.cts", "prettier.config.mts",
  },
  biome = { "biome.json", "biome.jsonc", ".biome.json", ".biome.jsonc" },
}

local function exists(path)
  return vim.uv.fs_stat(path) ~= nil
end

local function directories(bufnr)
  local filename = vim.api.nvim_buf_get_name(bufnr)
  if filename == "" then
    return {}, "Save the buffer to a project path before formatting"
  end
  local dirs = {}
  local dir = vim.fs.dirname(filename)
  while dir do
    local package = {}
    local manifest = dir .. "/package.json"
    if exists(manifest) then
      local ok, value = pcall(function()
        return vim.json.decode(table.concat(vim.fn.readfile(manifest), "\n"))
      end)
      if not ok or type(value) ~= "table" then
        return {}, "Cannot read package manifest: " .. manifest
      end
      package = value
    end
    dirs[#dirs + 1] = { path = dir, package = package }
    local boundary = exists(dir .. "/.git") or exists(dir .. "/pnpm-workspace.yaml")
      or package.workspaces ~= nil or dir == vim.uv.os_homedir()
    for _, lock in ipairs({ "bun.lock", "bun.lockb", "package-lock.json", "pnpm-lock.yaml", "yarn.lock" }) do
      boundary = boundary or exists(dir .. "/" .. lock)
    end
    if boundary then
      break
    end
    local parent = vim.fs.dirname(dir)
    if parent == dir then
      break
    end
    dir = parent
  end
  return dirs
end

local function executable(dirs, tool)
  for _, dir in ipairs(dirs) do
    local candidate = dir.path .. "/node_modules/.bin/" .. tool
    if vim.uv.fs_lstat(candidate) then
      return candidate
    end
  end
  local command = vim.fn.exepath(tool)
  return command ~= "" and command or tool
end

function M.select(bufnr, requested)
  local dirs, err = directories(bufnr)
  if err then
    return nil, err
  end
  for _, dir in ipairs(dirs) do
    local found = {}
    for _, name in ipairs(requested and { requested } or { "oxfmt", "prettier", "biome" }) do
      local file = name == "prettier" and dir.package.prettier ~= nil and "package.json" or nil
      for _, candidate in ipairs(configs[name]) do
        if not file and exists(dir.path .. "/" .. candidate) then
          file = candidate
        end
      end
      if file then
        found[#found + 1] = { name = name, cwd = dir.path, config = dir.path .. "/" .. file }
      end
    end
    if #found > 1 then
      return nil, "Conflicting formatter configs in " .. dir.path .. ". Keep one or override Conform in .nvim.lua"
    elseif #found == 1 then
      return found[1]
    end
  end
  return { name = requested or "oxfmt", cwd = dirs[#dirs].path }
end

local function selection(bufnr)
  local selected, err = M.select(bufnr)
  if not selected then
    return nil, err
  end
  local info = require("conform").get_formatter_info(selected.name, bufnr)
  if not info.available then
    return nil, "Formatter " .. selected.name .. ": " .. info.available_msg
      .. ". Install it in the project or override its Conform command in .nvim.lua"
  end
  return selected
end

function M.formatters(bufnr)
  local selected = selection(bufnr)
  return { selected and selected.name or "project_formatter_error", lsp_format = "never" }
end

M.blocked = {
  format = function(_, ctx, _, callback)
    local _, err = selection(ctx.buf)
    callback(err or "Formatter selection changed; retry formatting")
  end,
}

function M.override(name)
  return {
    command = function(_, ctx)
      return executable(directories(ctx.buf), name)
    end,
    cwd = function(_, ctx)
      local selected = M.select(ctx.buf, name)
      return selected and selected.cwd or vim.fs.dirname(ctx.filename)
    end,
    append_args = function(_, ctx)
      local selected, err = M.select(ctx.buf, name)
      assert(selected, err)
      if name == "oxfmt" then
        local file = selected.config or assert(vim.api.nvim_get_runtime_file("oxfmt-default.json", false)[1])
        return { "--config", file, "--disable-nested-config" }
      elseif name == "prettier" then
        return selected.config and { "--config", selected.config } or { "--no-config" }
      end
      return { "--config-path", selected.config or selected.cwd }
    end,
  }
end

return M
