{ ... }:
{
  programs.git = {
    enable    = true;
    userName  = "Kaarthik-07";
    userEmail = "57kaarthikj@gmail.com";

    extraConfig = {
      init.defaultBranch  = "main";
      pull.rebase         = true;
      push.autoSetupRemote = true;
    };

    ignores = [ ".DS_Store" "*.swp" ".direnv" ".env" ];
  };
}
