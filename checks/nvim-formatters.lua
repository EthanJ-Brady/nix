local root = vim.fn.getcwd()
if vim.env.CONFORM_RUNTIME then
  vim.opt.runtimepath:append(vim.env.CONFORM_RUNTIME)
end
local policy = dofile(vim.env.PROJECT_FORMATTERS_HELPER
  or root .. "/modules/home/development/nixvim/plugins/project-formatters.lua")
local conform = require("conform")
local lsp = require("conform.lsp_format")
lsp.get_format_clients = function()
  return { {} }
end
lsp.format = function()
  error("Project formatting must not fall through to LSP")
end
local tmp = vim.fn.tempname()
local old_path = vim.env.PATH
local shell = vim.fn.exepath("sh")
local function write(path, lines)
  vim.fn.mkdir(vim.fs.dirname(path), "p")
  vim.fn.writefile(lines or {}, path)
end
local function executable(path)
  write(path, { "#!" .. shell, "while IFS= read -r line; do :; done", "printf 'formatted\\n'" })
  vim.fn.setfperm(path, "rwxr-xr-x")
end
local function buffer(path)
  write(path, { "unformatted" })
  local buf = vim.fn.bufadd(path)
  vim.fn.bufload(buf)
  vim.bo[buf].filetype = "javascript"
  return buf
end
local function equal(actual, expected)
  assert(vim.deep_equal(actual, expected), vim.inspect(actual) .. " ~= " .. vim.inspect(expected))
end
local function selected(buf, name, command)
  local result, err = policy.select(buf)
  assert(result, err)
  equal(result.name, name)
  if command then
    equal(conform.get_formatter_info(name, buf).command, command)
  end
end
local function blocked(buf, pattern)
  equal(policy.formatters(buf)[1], "project_formatter_error")
  local called = false
  conform.format({ bufnr = buf }, function(format_err)
    assert(format_err and format_err:match(pattern), tostring(format_err))
    called = true
  end)
  assert(called, "missing error callback")
  equal(vim.api.nvim_buf_get_lines(buf, 0, -1, false), { "unformatted" })
end

local ok, err = xpcall(function()
  vim.fn.mkdir(tmp, "p")
  write(tmp .. "/oxfmt-default.json", { "{}" })
  vim.opt.runtimepath:prepend(tmp)
  vim.env.PATH = tmp .. "/fallback"
  executable(tmp .. "/fallback/oxfmt")
  executable(tmp .. "/fallback/prettier")
  executable(tmp .. "/fallback/biome")
  conform.setup({
    default_format_opts = { lsp_format = "fallback", timeout_ms = 2000 },
    notify_on_error = false,
    formatters_by_ft = { javascript = policy.formatters },
    formatters = {
      oxfmt = policy.override("oxfmt"), prettier = policy.override("prettier"),
      biome = policy.override("biome"), project_formatter_error = policy.blocked,
    },
  })
  write(tmp .. "/.prettierrc", { "{}" })
  write(tmp .. "/repo/.git")
  local buf = buffer(tmp .. "/repo/packages/app/src/a.js")
  vim.cmd.cd("/")
  selected(buf, "oxfmt", tmp .. "/fallback/oxfmt")
  write(tmp .. "/repo/package.json", { '{"dependencies":{"prettier":"*"}}' })
  selected(buf, "oxfmt")
  write(tmp .. "/repo/biome.json", { "{}" })
  selected(buf, "biome")
  write(tmp .. "/repo/packages/app/package.json", { '{"prettier":{}}' })
  selected(buf, "prettier")
  executable(tmp .. "/repo/node_modules/.bin/prettier")
  selected(buf, "prettier", tmp .. "/repo/node_modules/.bin/prettier")
  executable(tmp .. "/repo/packages/app/node_modules/.bin/prettier")
  selected(buf, "prettier", tmp .. "/repo/packages/app/node_modules/.bin/prettier")
  local called = false
  conform.format({ bufnr = buf }, function(format_err)
    assert(not format_err, format_err)
    called = true
  end)
  assert(called)
  equal(vim.api.nvim_buf_get_lines(buf, 0, -1, false), { "formatted" })
  conform.format({ bufnr = buf })
  equal(vim.api.nvim_buf_get_lines(buf, 0, -1, false), { "formatted" })
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "unformatted" })
  write(tmp .. "/repo/packages/app/.oxfmtrc.json", { "{}" })
  blocked(buf, "Conflicting formatter configs")
  conform.formatters_by_ft.javascript = { "prettier", lsp_format = "never" }
  conform.format({ bufnr = buf })
  equal(vim.api.nvim_buf_get_lines(buf, 0, -1, false), { "formatted" })
  conform.formatters_by_ft.javascript = policy.formatters
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "unformatted" })
  vim.fn.delete(tmp .. "/repo/packages/app/.oxfmtrc.json")
  vim.fn.delete(tmp .. "/repo/packages/app/node_modules", "rf")
  vim.fn.delete(tmp .. "/repo/node_modules", "rf")
  vim.fn.delete(tmp .. "/fallback/prettier")
  blocked(buf, "Formatter prettier: Command")
  executable(tmp .. "/custom-prettier")
  local default_command = conform.formatters.prettier.command
  conform.formatters.prettier.command = tmp .. "/custom-prettier"
  conform.format({ bufnr = buf })
  equal(vim.api.nvim_buf_get_lines(buf, 0, -1, false), { "formatted" })
  conform.formatters.prettier.command = default_command
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "unformatted" })
  executable(tmp .. "/node_modules/.bin/prettier")
  blocked(buf, "Formatter prettier: Command")
  executable(tmp .. "/repo/node_modules/.bin/prettier")
  vim.fn.setfperm(tmp .. "/repo/node_modules/.bin/prettier", "rw-r--r--")
  blocked(buf, "not found")
  vim.fn.delete(tmp .. "/repo/node_modules/.bin/prettier")
  assert(vim.uv.fs_symlink(tmp .. "/missing-prettier", tmp .. "/repo/node_modules/.bin/prettier"))
  blocked(buf, "not found")
  vim.fn.delete(tmp .. "/repo/node_modules", "rf")
  write(tmp .. "/repo/packages/app/package.json", { '{"workspaces":["packages/*"]}' })
  selected(buf, "oxfmt")
  vim.fn.delete(tmp .. "/repo/packages/app/package.json")
  write(tmp .. "/repo/packages/app/pnpm-workspace.yaml", { "packages: []" })
  selected(buf, "oxfmt")
  vim.fn.delete(tmp .. "/repo/packages/app/pnpm-workspace.yaml")
  for _, lock in ipairs({ "bun.lock", "bun.lockb", "package-lock.json", "pnpm-lock.yaml", "yarn.lock" }) do
    write(tmp .. "/repo/packages/app/" .. lock, { "{}" })
    selected(buf, "oxfmt")
    vim.fn.delete(tmp .. "/repo/packages/app/" .. lock)
  end
  write(tmp .. "/repo/packages/app/.git", { "gitdir: elsewhere" })
  selected(buf, "oxfmt")
  write(tmp .. "/repo/packages/app/vite.config.ts", { "export default {}" })
  write(tmp .. "/repo/packages/app/.prettierignore", { "dist" })
  selected(buf, "oxfmt")
  write(tmp .. "/repo/packages/app/prettier.config.mts", { "export default {}" })
  blocked(buf, "Formatter prettier: Command")
  write(tmp .. "/repo/packages/app/package.json", { "invalid" })
  blocked(buf, "Cannot read package manifest")
  print("project formatter checks passed")
end, debug.traceback)
vim.env.PATH = old_path
vim.fn.chdir(root)
vim.fn.delete(tmp, "rf")
if not ok then
  error(err)
end
