{ ... }:
{
  system.defaults = {
    dock = {
      autohide                  = true;
      show-recents              = false;
      minimize-to-application   = true;
    };
    finder = {
      AppleShowAllExtensions    = true;
      FXPreferredViewStyle      = "clmv";
      ShowPathbar               = true;
    };
    NSGlobalDomain = {
      ApplePressAndHoldEnabled  = false;
      KeyRepeat                 = 2;
      InitialKeyRepeat          = 15;
      AppleInterfaceStyle       = "Dark";
    };
    trackpad = {
      Clicking                  = true;
      TrackpadThreeFingerDrag   = true;
    };
  };
}
