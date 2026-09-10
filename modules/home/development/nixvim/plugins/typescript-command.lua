return function(fallback)
  local boundaries = { '.git', 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' }
  local sections = { 'dependencies', 'devDependencies', 'optionalDependencies', 'peerDependencies' }
  local function has(directory, names)
    for _, name in ipairs(names) do
      if vim.uv.fs_lstat(vim.fs.joinpath(directory, name)) then
        return true
      end
    end
    return false
  end
  local function declares(directory)
    local path = vim.fs.joinpath(directory, 'package.json')
    if not vim.uv.fs_stat(path) then
      return false
    end
    local ok, package = pcall(function()
      return vim.json.decode(table.concat(vim.fn.readfile(path), '\n'))
    end)
    if not ok or type(package) ~= 'table' then
      return true
    end
    for _, section in ipairs(sections) do
      if type(package[section]) == 'table'
        and (package[section].typescript or package[section]['@typescript/native-preview']) then
        return true
      end
    end
    return false
  end
  local function directories(start)
    local result = {}
    local directory = start
    while directory do
      table.insert(result, directory)
      if has(directory, boundaries) then
        return result, directory
      end
      local parent = vim.fs.dirname(directory)
      directory = parent ~= directory and parent or nil
    end
    return result
  end
  local function root_dir(bufnr, on_dir)
    local name = vim.api.nvim_buf_get_name(bufnr)
    if name == '' then
      return
    end
    local start = vim.fs.dirname(name)
    local search, boundary = directories(start)
    for _, directory in ipairs(search) do
      if has(directory, { 'deno.json', 'deno.jsonc' })
        or (directory ~= boundary and has(directory, { 'deno.lock' })) then
        return
      end
    end
    if not boundary then
      local limit = 1
      for index, directory in ipairs(search) do
        if has(directory, { 'package.json', 'tsconfig.json', 'jsconfig.json' }) then
          limit = index
          break
        end
      end
      search = vim.list_slice(search, 1, limit)
    end
    local tool_root, package_root
    for _, directory in ipairs(search) do
      if not tool_root and (declares(directory)
        or has(directory, { 'node_modules/.bin/tsc', 'node_modules/.bin/tsgo' })) then
        tool_root = directory
      end
      if not package_root and has(directory, { 'package.json', 'tsconfig.json', 'jsconfig.json' }) then
        package_root = directory
      end
    end
    on_dir(tool_root or boundary or package_root or start)
  end
  local function compatible(command)
    if vim.fn.executable(command) ~= 1 then
      return false, 'not executable'
    end
    local ok, result = pcall(function()
      return vim.system({ command, '--version' }, { text = true }):wait(3000)
    end)
    if not ok or result.code ~= 0 then
      return false, 'could not run --version'
    end
    local major = tonumber(result.stdout:match('Version (%d+)%.'))
    if not major or major < 7 then
      return false, 'requires native TypeScript 7+ (TypeScript 5/6 tsc has no LSP mode)'
    end
    return true
  end

  local function cmd(dispatchers, config)
    local root = config.root_dir
    local problems = {}
    local selected
    if root then
      local search, boundary = directories(root)
      -- Without a workspace boundary, the selected root is the entire search scope.
      if not boundary then
        search = { root }
      end
      for _, directory in ipairs(search) do
        for _, name in ipairs({ 'tsc', 'tsgo' }) do
          local command = vim.fs.joinpath(directory, 'node_modules', '.bin', name)
          if vim.uv.fs_lstat(command) then
            local ok, reason = compatible(command)
            if ok then
              selected = command
              break
            end
            table.insert(problems, command .. ': ' .. reason)
          end
        end
        if selected or #problems > 0 then
          break
        end
      end
      if not selected then
        local manifest = vim.fs.joinpath(root, 'package.json')
        if vim.uv.fs_stat(manifest) then
          local ok, package = pcall(function()
            return vim.json.decode(table.concat(vim.fn.readfile(manifest), '\n'))
          end)
          if not ok or type(package) ~= 'table' then
            table.insert(problems, manifest .. ': cannot read package declarations')
          else
            for _, section in ipairs(sections) do
              for _, name in ipairs({ 'typescript', '@typescript/native-preview' }) do
                if type(package[section]) == 'table' and package[section][name] then
                  table.insert(problems, manifest .. ': declares ' .. name .. ' but no usable project native compiler was found')
                end
              end
            end
          end
        end
      end
    end
    if not selected and #problems > 0 then
      error('TypeScript LSP refused project compiler:\n' .. table.concat(problems, '\n')
        .. '\nInstall the project native compiler, or set vim.lsp.config("tsgo", { cmd = {...} }) in trusted .nvim.lua. No global compiler was substituted.')
    end
    if not selected then
      local fallback_path = fallback and vim.uv.fs_realpath(fallback)
      for directory in (vim.env.PATH or ''):gmatch('[^:]+') do
        for _, name in ipairs({ 'tsc', 'tsgo' }) do
          local command = vim.fs.joinpath(directory, name)
          -- The packaged fallback must not outrank an inherited legacy tsgo.
          if (not fallback_path or vim.uv.fs_realpath(command) ~= fallback_path) and compatible(command) then
            selected = command
            break
          end
        end
        if selected then
          break
        end
      end
    end
    if not selected and fallback and compatible(fallback) then
      selected = fallback
    end
    if not selected then
      error('TypeScript LSP: no native TypeScript 7+ compiler found. Install tsc/tsgo or configure tsgo.cmd in trusted .nvim.lua.')
    end
    return vim.lsp.rpc.start({ selected, '--lsp', '--stdio' }, dispatchers, {
      cwd = config.cmd_cwd or root,
      env = config.cmd_env,
      detached = config.detached,
    })
  end
  return { cmd = cmd, root_dir = root_dir }
end
