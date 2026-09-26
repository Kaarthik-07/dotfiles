{ pkgs, ... }:
{
  programs.neovim = {
    enable        = true;
    defaultEditor = true;
    withRuby      = false;
    withPython3   = false;
  };

  # NvChad config lives in dots/nvim — symlinked to ~/.config/nvim
  xdg.configFile."nvim" = {
    source    = ../../dots/nvim;
    recursive = true;
  };

  home.packages = with pkgs; [
    # -- language servers Mason installs on demand -------------------------
    lua-language-server
    jdt-language-server

    # -- formatters + linters ------------------------------------------------
    # These come from Nix rather than Mason: the standalone mason-conform and
    # mason-nvim-lint plugins were deleted upstream with Mason 2.0, and Nix is
    # reproducible and works with no network. conform.nvim and nvim-lint just
    # pick them up from PATH.
    #
    # Heavier entries (rustfmt, and the python set) pull in large closures. Drop
    # any you do not use to keep the closure small -- conform.nvim and
    # nvim-lint degrade gracefully when a formatter is missing.
    stylua           # lua formatter
    shfmt            # bash/sh formatter
    shellcheck       # bash/sh linter
    nixfmt             # nix formatter (== nixfmt-rfc-style)
    clang-tools      # provides clang-format for c/cpp
    prettier         # web + markdown formatter
    gofumpt          # go formatter

    (luaPackages.luacheck)  # lua linter
    eslint_d                 # js/ts linter

    (python3Packages.black)    # python formatter
    (python3Packages.isort)    # python import sorting
    (python3Packages.flake8)   # python linter

    rustfmt          # rust formatter
  ];
}
