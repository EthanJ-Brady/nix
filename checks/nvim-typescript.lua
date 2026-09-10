local helper = assert(loadfile(vim.env.TYPESCRIPT_COMMAND_HELPER
  or 'modules/home/development/nixvim/plugins/typescript-command.lua'))()
local temp = vim.fn.tempname()
local original_path = vim.env.PATH
local original_start = vim.lsp.rpc.start
local shell = vim.fn.exepath('sh')
local function write(path, lines)
  vim.fn.mkdir(vim.fs.dirname(path), 'p')
  vim.fn.writefile(lines, path)
end
local function compiler(path, version)
  write(path, { '#!' .. shell, '[ "$1" = "--version" ] || exit 42', "printf '%s\\n' 'Version " .. version .. "'" })
  assert(vim.fn.setfperm(path, 'rwxr-xr-x') == 1)
  return path
end
local function run()
  local fallback = compiler(temp .. '/nix/tsc', '7.0.2')
  local environment = compiler(temp .. '/env/tsc', '7.1.0')
  local project = temp .. '/project'
  local other = temp .. '/other'
  vim.fn.mkdir(project, 'p')
  vim.fn.mkdir(other, 'p')
  local configured = helper(fallback)
  local command = configured.cmd
  local started
  vim.lsp.rpc.start = function(argv, _, options)
    started = { argv = argv, options = options }
    return started
  end
  local function select(root, expected)
    started = nil
    command({}, { root_dir = root })
    assert(started and started.argv[1] == expected, vim.inspect(started))
    assert(vim.deep_equal(started.argv, { expected, '--lsp', '--stdio' }))
    assert(started.options.cwd == root)
  end
  local function refused(root, message)
    started = nil
    local ok, err = pcall(command, {}, { root_dir = root })
    assert(not ok and tostring(err):find(message, 1, true), tostring(err))
    assert(not started, 'unsupported compiler must not receive --lsp')
  end
  vim.env.PATH = temp .. '/env:' .. temp .. '/nix'
  select(project, environment)
  local local_tsc = compiler(project .. '/node_modules/.bin/tsc', '7.2.0')
  select(project, local_tsc)
  select(other, environment)
  compiler(local_tsc, '5.9.3')
  refused(project, 'TypeScript 5/6 tsc has no LSP mode')
  local legacy = compiler(project .. '/node_modules/.bin/tsgo', '7.0.0-dev.20250801')
  select(project, legacy)
  vim.fn.delete(legacy)
  vim.fn.delete(local_tsc)
  write(project .. '/package.json', { '{"devDependencies":{"typescript":"^7.0.0"}}' })
  refused(project, 'declares typescript')
  write(local_tsc, { '#!' .. shell, 'exit 1' })
  vim.fn.setfperm(local_tsc, 'rwxr-xr-x')
  refused(project, 'could not run --version')
  vim.fn.delete(local_tsc)
  write(project .. '/package.json', { '{"dependencies":{"@typescript/native-preview":"latest"}}' })
  refused(project, 'declares @typescript/native-preview')
  vim.fn.delete(project .. '/package.json')
  compiler(temp .. '/node_modules/.bin/tsc', '7.9.0')
  select(project, environment) -- Do not search ancestors outside the selected workspace.
  compiler(environment, '5.9.3')
  local env_legacy = compiler(temp .. '/legacy/tsgo', '7.0.0-dev.20250801')
  vim.env.PATH = temp .. '/env:' .. temp .. '/nix:' .. temp .. '/legacy'
  select(project, env_legacy)
  vim.env.PATH = temp .. '/env'
  select(project, fallback)
  vim.env.PATH = ''
  select(project, fallback)
  local ok, err = pcall(helper(nil).cmd, {}, { root_dir = project })
  assert(not ok and tostring(err):find('no native TypeScript 7+', 1, true))

  -- A trusted exrc replaces cmd using Neovim's ordinary configuration interface.
  vim.lsp.config('tsgo', configured)
  write(project .. '/.nvim.lua', { 'vim.lsp.config("tsgo", { cmd = { "explicit-project-server", "--stdio" }, root_dir = function(_, on_dir) on_dir("/explicit-root") end })' })
  dofile(project .. '/.nvim.lua')
  assert(vim.deep_equal(vim.lsp.config.tsgo.cmd, { 'explicit-project-server', '--stdio' }))
  local explicit_root
  vim.lsp.config.tsgo.root_dir(0, function(root) explicit_root = root end)
  assert(explicit_root == '/explicit-root')
  local upstream = assert(loadfile(vim.env.TYPESCRIPT_LSP_CONFIG
    or assert(vim.api.nvim_get_runtime_file('lsp/tsgo.lua', false)[1], 'nvim-lspconfig is required')))()
  local effective = vim.tbl_extend('force', upstream, configured)
  assert(vim.deep_equal(effective.filetypes, upstream.filetypes))
  local function root_for(path)
    write(path, { 'export {}' })
    local buffer = vim.fn.bufadd(path)
    local root
    effective.root_dir(buffer, function(value)
      root = value
    end)
    return root
  end
  write(project .. '/package-lock.json', { '{}' })
  write(other .. '/bun.lock', { '' })
  assert(root_for(project .. '/src/index.ts') == project)
  assert(root_for(other .. '/src/index.ts') == other)
  write(project .. '/deno/deno.json', { '{}' })
  assert(root_for(project .. '/deno/index.ts') == nil)
  write(other .. '/deno/deno.lock', { '{}' })
  assert(root_for(other .. '/deno/index.ts') == nil)
  local nested = project .. '/independent'
  write(nested .. '/.git', { 'gitdir: /unused/worktree' })
  write(nested .. '/package.json', { '{"devDependencies":{"typescript":"^5.9.0"}}' })
  compiler(project .. '/node_modules/.bin/tsc', '7.3.0')
  assert(root_for(nested .. '/src/index.ts') == nested)
  refused(root_for(nested .. '/src/index.ts'), 'declares typescript')
  compiler(nested .. '/node_modules/.bin/tsc', '5.9.3')
  refused(root_for(nested .. '/src/index.ts'), 'TypeScript 5/6')

  local workspace_package = project .. '/packages/local'
  write(workspace_package .. '/package.json', { '{"devDependencies":{"typescript":"^7.0.0"}}' })
  assert(root_for(workspace_package .. '/src/index.ts') == workspace_package)
  select(root_for(workspace_package .. '/src/index.ts'), project .. '/node_modules/.bin/tsc')
  local package_tsc = compiler(workspace_package .. '/node_modules/.bin/tsc', '7.4.0')
  select(root_for(workspace_package .. '/src/index.ts'), package_tsc)
  compiler(package_tsc, '5.9.3')
  refused(root_for(workspace_package .. '/src/index.ts'), 'TypeScript 5/6')
  vim.fn.delete(workspace_package .. '/package.json')
  assert(root_for(workspace_package .. '/src/index.ts') == workspace_package)
  vim.fn.delete(package_tsc)
  write(workspace_package .. '/package.json', { '{}' })
  assert(root_for(workspace_package .. '/src/index.ts') == project)
  select(root_for(workspace_package .. '/src/index.ts'), project .. '/node_modules/.bin/tsc')
  write(workspace_package .. '/bun.lock', { '' })
  assert(root_for(workspace_package .. '/src/index.ts') == workspace_package)
  select(root_for(workspace_package .. '/src/index.ts'), fallback)
  write(workspace_package .. '/deno.jsonc', { '{}' })
  assert(root_for(workspace_package .. '/src/index.ts') == nil)

  local markerless = temp .. '/markerless/src/index.ts'
  assert(root_for(markerless) == vim.fs.dirname(markerless))
  write(temp .. '/markerless/package.json', { '{}' })
  assert(root_for(markerless) == temp .. '/markerless')
  write(temp .. '/markerless/deno.json', { '{}' })
  write(temp .. '/markerless/src/package.json', { '{}' })
  assert(root_for(markerless) == nil)
  write(project .. '/deno.json', { '{}' })
  assert(root_for(nested .. '/src/index.ts') == nested)
  print('TypeScript command checks passed')
end
local ok, err = xpcall(run, debug.traceback)
vim.env.PATH = original_path
vim.lsp.rpc.start = original_start
vim.fn.delete(temp, 'rf')
if not ok then
  error(err)
end
