{
  neovim,
  initFile,
  extraFiles,
  pkgs,
}:
pkgs.runCommand "neovim-project-tools" {
  nativeBuildInputs = [neovim pkgs.bash];
  TYPESCRIPT_COMMAND_HELPER = ../modules/home/development/nixvim/plugins/typescript-command.lua;
  PROJECT_FORMATTERS_HELPER = ../modules/home/development/nixvim/plugins/project-formatters.lua;
  NATIVE_TYPESCRIPT = pkgs.lib.getExe pkgs.typescript;
} ''
  export HOME="$TMPDIR/home"
  export XDG_STATE_HOME="$TMPDIR/state"
  export XDG_CACHE_HOME="$TMPDIR/cache"
  mkdir -p "$HOME"
  nvim --headless -u NONE -i NONE -l ${./nvim-typescript.lua}
  nvim --headless -u NONE -i NONE -l ${./nvim-formatters.lua}
  export PROJECT_TOOL_BIN="$TMPDIR/project-bin"
  mkdir -p "$PROJECT_TOOL_BIN"
  ln -s ${pkgs.coreutils}/bin/true "$PROJECT_TOOL_BIN/rustfmt"
  ln -s ${pkgs.coreutils}/bin/true "$PROJECT_TOOL_BIN/rust-analyzer"
  export PATH="$PROJECT_TOOL_BIN:$PATH"
  nvim --headless -i NONE --cmd 'set runtimepath^=${extraFiles}' -u ${initFile} \
    -c 'luafile ${./nvim-runtime.lua}' -c 'qa!'
  touch "$out"
''
