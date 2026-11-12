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
    # macOS ships captures to ~/Desktop; send every Cmd+Shift+3/4/5 capture
    # to the same folder the Linux box uses. The folder itself is created by
    # home.file in hosts/macbook/home.nix -- screencapture will not mkdir.
    screencapture = {
      location = "/Users/mikey/Pictures/Screenshots";
      type     = "png";
    };
  };
}
