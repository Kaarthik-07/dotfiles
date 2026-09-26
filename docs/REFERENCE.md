# Dotfiles Reference

A file-by-file walkthrough of this repository: what each file is for, what it
enables, and which commands or keybindings it produces.

**Repo type:** Nix Flake + Home Manager
**Targets:** NixOS Linux (i3) · nix-darwin macOS (AeroSpace) · NixOS-WSL

Related docs:
- [`KEYBINDINGS.md`](./KEYBINDINGS.md) — every binding in one place
- [`CHEATSHEET.md`](./CHEATSHEET.md) — printable daily lookup

---

## Layout

```
flake.nix                 entrypoint, defines all 3 machine configs
hosts/                    per-machine wiring
  linux/                  NixOS system + HM user
  macbook/                nix-darwin system + HM user
  wsl/                    NixOS-WSL system + HM user
modules/                  shared, imported by hosts
  darwin/                 macOS-only (system defaults, aerospace)
  linux/                  Linux-only (i3, dunst, wallpaper, dmenu)
  home/                   cross-platform (zsh, git, neovim, wezterm)
dots/                     raw configs, symlinked into ~/.config
  nvim/                   NvChad + lazy.nvim
  wezterm/                terminal + 4 color schemes
docs/                     these docs
```

**How the pieces connect:** `flake.nix` picks a `hosts/*/default.nix` (system
layer) and a `hosts/*/home.nix` (Home Manager layer). `home.nix` imports from
`modules/`. Two modules (`neovim.nix`, `wezterm.nix`) do nothing but symlink
`dots/*` into `~/.config/` — that's why editing anything under `dots/` takes
effect immediately after a `home-manager switch`.

---

## 1. `flake.nix`

Reads 4 inputs (`nixpkgs`, `home-manager`, `nix-darwin`, `nixos-wsl`) and
exposes 3 outputs. The `hmModule` helper turns a plain file into a Home Manager
user module.

| Output | System | Loads |
|---|---|---|
| `darwinConfigurations.macbook` | `aarch64-darwin` | `darwin/system.nix`, `darwin/aerospace.nix` + HM (zsh, git, nvim, wezterm) |
| `nixosConfigurations.linux` | `x86_64-linux` | `hosts/linux/*` + HM (zsh, git, nvim, wezterm, i3) |
| `nixosConfigurations.wsl` | `x86_64-linux` | NixOS-WSL + HM (zsh, git, nvim) |

WSL deliberately omits wezterm — you run the Windows-side wezterm and connect
into WSL.

### Commands
```bash
# preview the Linux system without building anything
nix build .#nixosConfigurations.linux.config.system.build.toplevel --dry-run

# apply the system layer (needs sudo)
sudo nixos-rebuild switch --flake .#linux

# apply only your user layer
home-manager switch --flake .#linux

# macOS
darwin-rebuild switch --flake .#macbook

# update all inputs (this is what rewrites flake.lock)
nix flake update
```

---

## 2. `hosts/linux/default.nix` — Linux system layer

| Setting | Value | Why |
|---|---|---|
| bootloader | GRUB, `useOSProbor = true` | `useOSProbor` is what makes Windows show up in the boot menu |
| kernel | `linuxPackages_latest` | rolling kernel |
| network | NetworkManager | + `nm-applet` tray |
| display | LightDM + i3 | — |
| audio | PipeWire + ALSA + Pulse | Pulse shim so old apps still work |
| bluetooth | `hardware.bluetooth` + Blueman | — |
| `programs.nix-ld` | enabled | lets non-Nix binaries (Electron apps) find `libGL`/`libglvnd` |
| timezone | `Asia/Kolkata` | — |
| locale | `en_US.UTF-8`, all `LC_*` → `en_IN` | Indian English formatting |

**System packages:** `git curl wget nixd`
**i3 extraPackages:** `i3status i3lock dmenu feh picom xclip maim brightnessctl
dunst xautolock libnotify`

**User `mikey`:** shell `zsh`, groups `wheel networkmanager audio video bluetooth`.

> ⚠️ `initialPassword = "changeme"` is a placeholder that only applies when the
> account is first created. Run `passwd mikey` after first boot, then replace
> this line with a `hashedPassword` so no plaintext secret lives in git.

---

## 3. `hosts/linux/hardware-configuration.nix` — generated

Root on `/dev/disk/by-uuid/05f9…` (ext4), `/boot` vfat, swap on `ad6a…`.
Loads `kvm-amd` (AMD SVM — required by the Android emulator and Hyper-V),
`nvme`/`xhci_pci`/`usb_storage`/`sd_mod` in the initrd, and enables AMD
microcode updates. **Do not edit** — `nixos-generate-config` overwrites it.

---

## 4. `hosts/linux/home.nix` — Linux user layer

The CLI toolbox available on `$PATH`:

```
ripgrep fd fzf bat eza jq        # search / fuzzy find / pretty ls
tmux direnv                       # terminal multiplexer, env loader
nodejs_22 go                      # runtimes
xclip feh xsetroot                # X helpers (clipboard, wallpaper, root pixmap)
wezterm                          # terminal
nerd-fonts.jetbrains-mono        # patched font for the icons
networkmanagerapplet brave       # tray + browser
pamixer copyq dmenu              # volume, clipboard history, launcher
thunar thunar-volman thunar-archive-plugin
gvfs
```

`programs.home-manager.enable = true` is what actually activates the `home.nix`
imports.

---

## 5. `modules/home/zsh.nix` — shell

### Starship prompt
```
$directory$git_branch$git_status$python$nodejs$rust$golang$java
$character
```
Catppuccin Mocha colours. Directory is truncated to the last 3 path components
and shortened to the repo root when you're inside a git repo. The prompt char
`❯` is blue on success and **red when the last command exited non-zero**.

### Aliases

| Alias | Expands to | Purpose |
|---|---|---|
| `v` | `nvim` | editor |
| `c` | `clear` | clear screen |
| `t` | `tmux` | multiplexer |
| `x` | `exit` | close the shell |
| `doc` | `docker` | docker |
| `sz` | `source ~/.zshrc` | reload zsh |
| `ll` | `ls -alF` | long listing |
| `la` | `ls -A` | include hidden, no `.`/`..` |
| `l` | `ls -CF` | column view |
| `ls` | `eza` | pretty ls |
| `gac` | `git add . && git commit -m` | stage + commit |
| `please` | `sudo` | polite sudo |
| `py` | `python3` | python |
| `pbcopy` | `xclip -sel clip` | macOS→Linux clipboard shim (Linux only) |

### Plugins
`zsh-autosuggestions` (inline ghost text from history), `zsh-syntax-highlighting`,
`zsh-history-substring-search` (type a prefix, press ↑). History is 10 000
entries, deduplicated, and **shared between concurrent shells**.

### Environment setup (`initContent`)
- Adds `~/.local/bin` and `~/.claude/local` to `PATH`
- Starts `ssh-agent` only if `$SSH_AUTH_SOCK` is unset *and* the key exists
- Per-OS: `brew shellenv`, `JAVA_HOME` (17 mac / 21 Linux), `ANDROID_HOME` +
  `platform-tools` — each guarded by a `-d`/`-x` test so a missing SDK never
  prints an error
- Loads `nvm.sh` if present
- `direnv hook zsh`

---

## 6. `modules/linux/i3.nix` — the biggest module

Writes 3 config files and defines 4 helper shell scripts.

### Helper scripts
| Script | What it does |
|---|---|
| `vol-up` / `vol-down` | `pamixer ±5` then a dunst OSD showing the new level |
| `vol-mute` | toggles mute, OSD shows "Muted" or the level |
| `bri-up` / `bri-down` | `brightnessctl ±10%` then an OSD |
| `ss-full` | `maim` → clipboard, OSD "Copied to clipboard" |
| `ss-area` | 0.2s delay, then `maim -s` (area select) → clipboard |
| `ss-save` | saves to `~/Pictures/ss_YYYYmmdd_HHMMSS.png` **and** clipboard |
| `dmenu-run` | wraps `dmenu_run` with `XDG_DATA_DIRS`/`XDG_DATA_HOME` set and a Nerd Font, so app icons actually render |
| `wallpaper` | picks the first existing wallpaper from `~/Pictures/wallpaper.png`, `~/Downloads/dino.jpg`, `~/Pictures/dino.jpg` |

### Config files written
| Path | Purpose |
|---|---|
| `~/.config/i3/config` | keybindings, colours, gaps, autostart |
| `~/.config/i3status/config` | top bar contents |
| `~/.config/dunst/dunstrc` | notification daemon styling |

### Look and feel
Gaps: inner 8, outer 4. Bar on top, `i3status` as `status_command`.
Catppuccin Mocha palette:

| Token | Hex | Used for |
|---|---|---|
| `$base` | `#1e1e2e` | background |
| `$text` | `#cdd6f4` | text |
| `$blue` | `#89b4fa` | focused border, active workspace |
| `$red` | `#f38ba8` | urgent |
| `$muted` | `#585b70` | unfocused / separators |
| `$surface` | `#313244` | unfocused background |

### Autostart (runs on i3 launch)
| Command | Why |
|---|---|
| `wallpaper` | sets the desktop background via `feh` |
| `picom --daemon --backend glx --blur-method dual_kawase --blur-strength 8 --shadow --shadow-radius 12 --corner-radius 8` | translucency, blur, drop shadows, rounded corners |
| `nm-applet` | NetworkManager tray |
| `blueman-applet` | Bluetooth tray |
| `dunst` | notification daemon |
| `copyq --start-server` | clipboard history daemon |
| `xautolock -time 5 -locker "i3lock -c 1e1e2e"` | **auto-lock after 5 min idle** |

### i3status (top bar)
Order: `wireless _first_` → `battery all` → `cpu_usage` → `memory` → `tztime local`.
5 second refresh. Renders as: `ESSID  battery%  cpu%  mem-used  date  time`.
Battery turns yellow under 20%.

### dunst (notifications)
Top-right, 320×300, Catppuccin Mocha, 8px rounded corners, max 5 on screen,
history 20, JetBrainsMono Nerd Font 10. Timeouts: 3s low, 5s normal, **0
(never) for critical**. Left-click closes one, middle-click runs its action,
right-click closes all.

Full keybinding tables: [`KEYBINDINGS.md`](./KEYBINDINGS.md).

---

## 7. `modules/home/git.nix`

```ini
user.name  = Kaarthik-07
user.email = 57kaarthikj@gmail.com
init.defaultBranch  = main
pull.rebase         = true      # pull = rebase, so no accidental merge commits
push.autoSetupRemote = true     # plain `git push` works on a fresh branch
```

Global gitignore: `.DS_Store`, `*.swp`, `.direnv`, `.env`

> These live under `programs.git.settings` — the older `userName`/`userEmail`/
> `extraConfig` option names are deprecated in current Home Manager.

---

## 8. `modules/home/neovim.nix`

Sets `programs.neovim.defaultEditor = true` — sets `EDITOR`/`VISUAL` to nvim, so
git commit messages, `sudoedit` and crontab all open in nvim. Symlinks
`dots/nvim` → `~/.config/nvim`.

Also installs the toolchain nvim shells out to:

| Binary | Used by |
|---|---|
| `lua-language-server`, `jdt-language-server` | LSP (Mason handles the rest on demand) |
| `stylua`, `shfmt`, `nixfmt`, `prettier`, `gofumpt` | `conform.nvim` formatters |
| `clang-tools` | provides `clang-format` for C/C++ |
| `rustfmt` | Rust formatter |
| `black`, `isort` | Python formatters |
| `luacheck`, `flake8`, `shellcheck`, `eslint_d` | `nvim-lint` linters |

`rustfmt` and the Python set pull in large closures. Drop any you don't use —
`conform.nvim` and `nvim-lint` degrade gracefully when a binary is absent.


## 9. `modules/home/wezterm.nix`

Symlinks `dots/wezterm` → `~/.config/wezterm`. Nothing else.

---

## 10. `dots/wezterm/` — terminal

### `wezterm.lua`
Font 13px, line-height 1.2, JetBrainsMono Nerd Font Medium with Symbols Nerd
Font Mono as the glyph fallback. Bold and italic are mapped to real font faces
rather than synthetic styles.

`Catppuccin Mocha` scheme, `window_background_opacity = 0.88`, and an HSB boost
of `(1.0, 1.2, 1.5)` for a slightly "CRT" look. If
`assets/bg-blurred-darker.png` exists it is loaded at 0.9 opacity with
brightness 0.4.

Blinking bar cursor at 600ms, tab bar hidden when there's only one tab, 120 FPS,
EGL rendering.

### `constants.lua`
Exports `bg_image` (currently `bg-blurred-darker.png`) plus the two raw asset
paths. `wezterm.config_dir` is used so paths work regardless of install prefix.

### Command palette
Open with `Ctrl+Shift+P`, or right-click → Command Palette.

| Entry | What it does |
|---|---|
| **Cycle terminal color scheme** | Mocha → NightWolf → CyberDream → CyberDream Light → Mocha, with a toast confirming the new name |
| **Select terminal color scheme** | a picker list to jump straight to one |
| **Toggle terminal transparency** | flips opacity between `1.0` (opaque, background image removed) and `0.8` (translucent, background image restored) |

### Color schemes
| File | Scheme |
|---|---|
| `cyberdream.lua` | CyberDream — black background, saturated accents |
| `cyberdream-light.lua` | CyberDream Light — inverted, white background |
| `nightwolf.lua` | NightWolf — pure black, muted greys, from `NightWolfTheme` |

WezTerm auto-loads `<config_dir>/<name>.lua`, so these work by name with no
registration step. `Catppuccin Mocha` and `Catppuccin Latte` ship with WezTerm
itself.

### `stylua.toml`
80 columns, 2-space indent, single quotes, no call parentheses. Run `stylua .`
inside `dots/wezterm/` to format.

---

## 11. `dots/nvim/` — Neovim

### `init.lua`
Clones `lazy.nvim` on first run, sets `mapleader = <Space>`, configures
diagnostics (virtual text with a `●` prefix, underline, sorted by severity, not
updated while inserting), loads NvChad v2.5 plus the `plugins` spec, then
`dofile`s the base46 `defaults` and `statusline` files and loads
`nvchad.autocmds`.

### `lua/options.lua`
Line numbers **and** relative numbers, 4-space indentation
(`shiftwidth`/`tabstop`/`softtabstop`), and `clipboard=unnamedplus` so yanks go
to the system clipboard.

### `lua/chadrc.lua`
Theme `bearded-arc` with transparency on. Java is intentionally absent — nvim-java
owns the Java LSP so there's a single source of truth.

### `lua/configs/lazy.lua`
`install.colorscheme = "nvchad"` means `:Lazy install` also applies the NvChad
colourscheme. `performance.rtp.disabled_plugins` strips 27 bundled runtime
plugins (`netrw`, `gzip`, `zip`, `tar`, `matchit`, `tutor`, …) that you never
use, which measurably speeds up startup.

### `lua/plugins/init.lua` — 9 plugins
| Plugin | Loads on | Job |
|---|---|---|
| `nvim-java/nvim-java` | `ft=java` | Java + Spring Boot: LSP, install, test runner, debugger |
| `nvim-treesitter` | opts merge | 34 parsers auto-installed, plus highlight + indent |
| `nvim-lspconfig` | `BufReadPre`/`BufNewFile` | 14 language servers |
| `mason-org/mason.nvim` | `:Mason` | package manager UI (**language servers only** — see below) |
| `mason-org/mason-lspconfig.nvim` | `VeryLazy` | installs + auto-enables the LSP binaries in `ensure_installed` |
| `nvim-lint` | `BufReadPre`/`BufNewFile` | runs linters |
| `conform.nvim` | `BufWritePre` | format on save |
| `render-markdown.nvim` | `ft=markdown` | renders markdown with icons |

> **Mason 2.0 changed things.** The `mason-nvim-lint` and `mason-conform`
> plugins were **deleted upstream**, and mason-lspconfig v2 removed the
> `automatic_installation` option. So Mason now handles *only* language
> servers. Linter and formatter **binaries come from Nix** (see
> `modules/home/neovim.nix`) — reproducible, offline-capable, and picked up
> from `PATH` by `nvim-lint` and `conform.nvim` without any plugin glue.
> The plugin repos are also `mason-org/*` now, not `williamboman/*`.


**Treesitter parsers:** bash, c, cmake, cpp, fish, go, lua, luadoc, markdown,
markdown_inline, python, rust, toml, vim, vimdoc, yaml, typescript, tsx,
javascript, jsdoc, dockerfile, css, html, json, json5, java, graphql,
properties, xml, nix, prisma, proto, sql, regex.

### Language servers
`lua_ls` `pyright` `gopls` `clangd` `html` `cssls` `ts_ls` `rust_analyzer`
`bashls` `jsonls` `yamlls` `dockerls` `tailwindcss` `nixd`

`lua_ls` gets extras: `vim` registered as a diagnostic global, the whole runtime
path as a workspace library, and third-party checking off.

**Java is special-cased.** A `FileType java` autocmd calls
`configs.jdtls.start()`, which finds the project root from `.git`, `mvnw`,
`gradlew`, `pom.xml` or `build.gradle`, gives each project its own workspace
under `stdpath("cache")/jdtls/<project>`, and launches
`jdtls -data <ws> -Xms512m -Xmx2g` on `vim.schedule` so startup never blocks.

### Format on save
`conform.nvim` with `timeout_ms = 500` and `lsp_format = "fallback"` — the LSP
formatter is tried first, and the tool below is only used as a fallback. Every
binary listed here is installed by Nix in `modules/home/neovim.nix`.

| Filetype | Formatters (in order) |
|---|---|
| `lua` | stylua |
| `c`, `cpp` | clang_format |
| `go` | gofumpt |
| `python` | isort, black |
| `js` `ts` `jsx` `tsx` `html` `css` `json` `yaml` `md` `graphql` | prettier |
| `rust` | rustfmt |
| `sh` `bash` | shfmt (`-i 2`) |
| `nix` | nixfmt |

Flags: black `--fast --line-length 88` · isort `--profile black` ·
prettier `--tab-width 2 --single-quote`

`goimports` was dropped — nixpkgs no longer packages it. `gopls` is already an
LSP server here, so it handles Go import fixing, and `lsp_format = "fallback"`
means it formats first regardless.


### Linting
Runs on `BufEnter`, `BufWritePost` and `InsertLeave`:

| Filetype | Linter |
|---|---|
| `lua` | luacheck (globals `love` + `vim`, plain formatter, codes + ranges) |
| `python` | flake8 |
| `js` `ts` `jsx` `tsx` | eslint_d |
| `sh` `bash` | shellcheck |

Full keybinding tables: [`KEYBINDINGS.md`](./KEYBINDINGS.md).

---

## 12. `hosts/macbook/` + `modules/darwin/`

### `system.nix` — macOS `defaults write` equivalents
- **Dock:** autohide on, hide recent apps, minimize into app icon
- **Finder:** show all filename extensions, column view, path bar on
- **Global:** `ApplePressAndHoldEnabled = false` (this is what makes Emacs
  keys like `Ctrl+A`/`Ctrl+E` work in the terminal), fast key repeat
  (`KeyRepeat 2` / `InitialKeyRepeat 15`), forced Dark appearance
- **Trackpad:** tap to click, three-finger drag

### `aerospace.nix` — macOS tiling window manager
Writes `~/.config/aerospace/aerospace.toml` with 8px gaps everywhere, `tiles`
as the default layout, and `alt` as the modifier. Bindings mirror your i3 setup
so the muscle memory transfers — see [`KEYBINDINGS.md`](./KEYBINDINGS.md).

There is a **service mode** bound to `alt+shift+;`:
- `Esc` → reload config and return to main mode
- `r` → flatten the workspace tree (undo accidental splits) and return to main

### `macbook/default.nix`
Homebrew with `onActivation.cleanup = "zap"` (removes unused formulae on
`brew cleanup`), casks `aerospace` + `wezterm`.

---

## 13. `hosts/wsl/`

`wsl.enable`, `defaultUser = "mikey"`, `startMenuLaunchers = true` (so `.exe`
files show up in the Start menu). System packages: `git curl wget wslu`. The
HM user imports zsh, git and neovim only — **no wezterm**, because you run the
Windows-side wezterm and SSH/connect into WSL.

---

## 14. `.gitignore`

Deliberately **does not** ignore `flake.lock` or `lazy-lock.json`. Committing
both is what makes `nixos-rebuild` reproducible across machines. Regenerate
them deliberately rather than letting them drift:

```bash
nix flake update                                    # bumps flake.lock
cd dots/nvim && nvim --headless -c 'Lazy update' -c qa   # bumps lazy-lock.json
```

Ignored: `result`, `.direnv`, `.claude`, `.env`, `*.bak`, `*~`.

---

## Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| nvim format-on-save does nothing | formatter binary missing | `:Mason` → install, or run `:Lazy install` |
| dmenu shows no app icons | `XDG_DATA_DIRS` unset | the `dmenu-run` wrapper handles this; confirm it's not been overridden |
| i3 changes not applied | config not reloaded | `Mod+Shift+c` |
| `nix flake update` fails with permission denied | `flake.lock` owned by root | `sudo chown $USER flake.lock` |
| WezTerm theme toggle does nothing | old version called a missing script | current version cycles bundled schemes in-process |
