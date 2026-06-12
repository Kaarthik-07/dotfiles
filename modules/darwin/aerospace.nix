{ ... }:
{
  xdg.configFile."aerospace/aerospace.toml".text = ''
    # aerospace — minimal tiling config
    # mod = alt

    after-login-command  = []
    after-startup-command = []

    start-at-login           = true
    enable-normalization-flatten-containers = true
    enable-normalization-opposite-orientation-for-nested-containers = true

    default-root-container-layout      = "tiles"
    default-root-container-orientation = "auto"

    key-mapping.preset = "qwerty"

    [gaps]
    inner.horizontal = 8
    inner.vertical   = 8
    outer.left       = 8
    outer.bottom     = 8
    outer.top        = 8
    outer.right      = 8

    [mode.main.binding]
    # focus
    alt-h = "focus left"
    alt-j = "focus down"
    alt-k = "focus up"
    alt-l = "focus right"

    # move
    alt-shift-h = "move left"
    alt-shift-j = "move down"
    alt-shift-k = "move up"
    alt-shift-l = "move right"

    # resize
    alt-minus = "resize smart -50"
    alt-equal = "resize smart +50"

    # layout
    alt-slash = "layout tiles horizontal vertical"
    alt-comma = "layout accordion horizontal vertical"

    # fullscreen
    alt-f = "fullscreen"

    # float / unfloat
    alt-shift-space = "layout floating tiling"

    # workspaces 1-5
    alt-1 = "workspace 1"
    alt-2 = "workspace 2"
    alt-3 = "workspace 3"
    alt-4 = "workspace 4"
    alt-5 = "workspace 5"

    alt-shift-1 = "move-node-to-workspace 1"
    alt-shift-2 = "move-node-to-workspace 2"
    alt-shift-3 = "move-node-to-workspace 3"
    alt-shift-4 = "move-node-to-workspace 4"
    alt-shift-5 = "move-node-to-workspace 5"

    # close
    alt-q = "close"

    # service mode
    alt-shift-semicolon = "mode service"

    [mode.service.binding]
    esc = ["reload-config", "mode main"]
    r   = ["flatten-workspace-tree", "mode main"]
  '';
}
