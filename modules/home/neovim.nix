{ pkgs, ... }:
{
  programs.neovim = {
    enable        = true;
    defaultEditor = true;
  };

  # NvChad config lives in dots/nvim — symlinked to ~/.config/nvim
  xdg.configFile."nvim" = {
    source    = ../../dots/nvim;
    recursive = true;
  };

  home.packages = with pkgs; [
    lua-language-server
    stylua
    nodePackages.prettier
    jdt-language-server
  ];
}
