{ ... }:
{
  programs.git = {
    enable    = true;
    # `userName` / `userEmail` / `extraConfig` were renamed to `settings` in
    # home-manager; the old names now emit deprecation warnings.
    settings = {
      user.name  = "Kaarthik-07";
      user.email = "57kaarthikj@gmail.com";

      init.defaultBranch  = "main";
      pull.rebase         = true;
      push.autoSetupRemote = true;
    };

    ignores = [ ".DS_Store" "*.swp" ".direnv" ".env" ];
  };
}
