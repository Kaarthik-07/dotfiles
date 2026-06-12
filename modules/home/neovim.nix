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
    lua-language-server
    stylua
    prettier
    jdt-language-server
  ];
}
