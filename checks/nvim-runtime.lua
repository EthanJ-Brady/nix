local tmp = vim.fn.tempname()
local conform = require("conform")
local function write(path, lines)
  vim.fn.mkdir(vim.fs.dirname(path), "p")
  vim.fn.writefile(lines, path)
end
local function open(path, lines)
  write(path, lines)
  vim.cmd.edit(vim.fn.fnameescape(path))
end
local function format(expected)
  local called = false
  conform.format({ timeout_ms = 10000 }, function(err)
    assert(not err, err)
    called = true
  end)
  assert(called)
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  assert(vim.deep_equal(lines, expected), vim.inspect(lines))
  conform.format({ timeout_ms = 10000 })
  assert(vim.deep_equal(vim.api.nvim_buf_get_lines(0, 0, -1, false), expected), "Formatting is not idempotent")
  vim.bo.modified = false
end
local original_start = vim.lsp.rpc.start
local ok, err = xpcall(function()
  assert(type(vim.lsp.config.tsgo.cmd) == "function")
  assert(type(vim.lsp.config.tsgo.root_dir) == "function")
  assert(vim.fn.exepath("rustfmt") == vim.env.PROJECT_TOOL_BIN .. "/rustfmt")
  assert(vim.fn.exepath("rust-analyzer") == vim.env.PROJECT_TOOL_BIN .. "/rust-analyzer")
  vim.lsp.enable("tsgo", false)
  local rust_file = tmp .. "/rust-project/src/lib.rs"
  write(rust_file, { "pub fn answer() {}" })
  local rust_buffer = vim.fn.bufadd(rust_file)
  assert(conform.get_formatter_info("rustfmt", rust_buffer).cwd == tmp .. "/rust-project/src")
  vim.opt.swapfile = false
  vim.opt.undofile = false
  vim.opt.exrc = false
  write(tmp .. "/.oxfmtrc.json", { '{"semi":false,"singleQuote":true}' })
  write(tmp .. "/default/.git", {})
  open(tmp .. "/default/a.js", { "const x='hello'" })
  format({ 'const x = "hello";' })
  write(tmp .. "/default/.oxfmtrc.json", { '{"semi":false,"singleQuote":true}' })
  format({ "const x = 'hello'" })

  write(tmp .. "/prettier/.git", {})
  write(tmp .. "/prettier/.prettierrc.json", { '{"semi":false,"singleQuote":true}' })
  open(tmp .. "/prettier/a.js", { 'const x="hello";' })
  format({ "const x = 'hello'" })
  write(tmp .. "/prettier/.prettierignore", { "dist/" })
  open(tmp .. "/prettier/dist/ignored.js", { 'const x="hello";' })
  format({ 'const x="hello";' })

  write(tmp .. "/biome/.git", {})
  write(tmp .. "/biome/biome.json", {
    '{"javascript":{"formatter":{"quoteStyle":"single","semicolons":"asNeeded"}}}',
  })
  open(tmp .. "/biome/a.js", { 'const x="hello";' })
  format({ "const x = 'hello'" })

  local compiler = tmp .. "/typescript/node_modules/.bin/tsc"
  write(compiler, { "#!" .. vim.fn.exepath("sh"), 'exec "' .. vim.env.NATIVE_TYPESCRIPT .. '" "$@"' })
  vim.fn.setfperm(compiler, "rwxr-xr-x")
  write(tmp .. "/typescript/package.json", { '{"devDependencies":{"typescript":"7.0.2"}}' })
  write(tmp .. "/typescript/tsconfig.json", { '{"compilerOptions":{"strict":true,"noEmit":true}}' })
  local launched
  vim.lsp.rpc.start = function(command, ...)
    launched = command
    return original_start(command, ...)
  end
  vim.lsp.enable("tsgo")
  open(tmp .. "/typescript/index.ts", { 'const x: number = "wrong";' })
  assert(vim.wait(20000, function()
    for _, diagnostic in ipairs(vim.diagnostic.get(0)) do
      if diagnostic.code == 2322 then
        return true
      end
    end
    return false
  end, 100), "Real TypeScript server did not report the type error")
  assert(launched[1] == compiler, vim.inspect(launched))
  assert(#vim.lsp.get_clients({ name = "tsgo", bufnr = 0 }) == 1)
  print("Generated Neovim config, real formatters, and TypeScript LSP checks passed")
end, debug.traceback)
vim.lsp.rpc.start = original_start
for _, client in ipairs(vim.lsp.get_clients()) do
  client:stop(true)
end
vim.fn.delete(tmp, "rf")
if not ok then
  vim.api.nvim_err_writeln(err)
  vim.cmd("cquit 1")
end
