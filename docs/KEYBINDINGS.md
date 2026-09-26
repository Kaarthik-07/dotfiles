# Keybindings Reference

Every binding in this dotfiles setup, in one place.

- [`CHEATSHEET.md`](./CHEATSHEET.md) — condensed one-page version
- [`REFERENCE.md`](./REFERENCE.md) — what each config file does

**Legend:** `Mod` = `Mod4` = **Super** on i3, **Alt** (⌥) on AeroSpace/macOS.
`Spc` = `Space` (the Neovim leader).

---

## i3 (Linux)

Config: `modules/linux/i3.nix` → `~/.config/i3/config`

### Launch and close
| Key | Action |
|---|---|
| `Mod+Return` | new WezTerm window |
| `Mod+d` | dmenu app launcher (Nerd Font, fuzzy, case-insensitive) |
| `Mod+n` | Thunar file manager |
| `Mod+q` | kill focused window |

### Focus
| Key | Direction |
|---|---|
| `Mod+h` | left |
| `Mod+j` | down |
| `Mod+k` | up |
| `Mod+Right` | right |
| `Mod+Left` / `Mod+Down` / `Mod+Up` | left / down / up (arrow aliases) |

> `Mod+l` is **not** in this block — it locks the screen. See
> [System](#system) below.

### Move focused window
| Key | Direction |
|---|---|
| `Mod+Shift+h` | left |
| `Mod+Shift+j` | down |
| `Mod+Shift+k` | up |
| `Mod+Shift+l` | right |

### Splits and layouts
| Key | Action |
|---|---|
| `Mod+b` | split horizontally |
| `Mod+v` | split vertically |
| `Mod+e` | toggle split orientation |
| `Mod+s` | stacking layout |
| `Mod+w` | tabbed layout |
| `Mod+f` | fullscreen toggle |
| `Mod+Shift+space` | float / unfloat the focused window |
| `Mod+space` | toggle focus mode (focus follows click through tiled windows) |

### Resize mode
`Mod+r` enters resize mode, then:

| Key | Action |
|---|---|
| `h` / `l` | shrink / grow **width** by 20px |
| `k` / `j` | shrink / grow **height** by 20px |
| `Return` or `Esc` | back to normal mode |

### Workspaces
| Key | Action |
|---|---|
| `Mod+1` … `Mod+5` | jump to workspace 1–5 |
| `Mod+Shift+1` … `Mod+Shift+5` | move focused container to workspace 1–5 |

### System
| Key | Action |
|---|---|
| **`Mod+l`** | **lock the screen (`i3lock`)** |
| `Mod+Shift+x` | lock the screen (alias, kept for muscle memory) |
| `Mod+Shift+c` | reload the i3 config |
| `Mod+Shift+r` | restart i3 |
| `Mod+Shift+e` | "Exit i3?" confirmation dialog |

The screen also **auto-locks after 5 minutes of idle** via `xautolock`.

### Volume and brightness
These are your keyboard's multimedia keys, so they work globally.

| Key | Action |
|---|---|
| `XF86AudioRaiseVolume` | volume +5 with OSD |
| `XF86AudioLowerVolume` | volume −5 with OSD |
| `XF86AudioMute` | toggle mute (OSD shows "Muted" or the level) |
| `XF86AudioMicMute` | toggle **microphone** mute |
| `XF86MonBrightnessUp` | brightness +10% with OSD |
| `XF86MonBrightnessDown` | brightness −10% with OSD |

### Screenshots
All three copy a PNG to the clipboard and show a notification.

| Key | Action |
|---|---|
| `Print` | whole screen → clipboard |
| `Shift+Print` | **drag-select an area** → clipboard |
| `Ctrl+Print` | whole screen → saved to `~/Pictures/ss_<timestamp>.png` **and** clipboard |

### Clipboard
| Key | Action |
|---|---|
| `Mod+Shift+v` | toggle the CopyQ history window (auto-floated, 520×380) |

---

## AeroSpace (macOS)

Config: `modules/darwin/aerospace.nix` → `~/.config/aerospace/aerospace.toml`
`Mod` = `alt` (⌥). Mirrors the i3 layout on purpose.

### Launch and close
| Key | Action |
|---|---|
| `alt-h/j/k/l` | focus left / down / up / right |
| `alt-shift-h/j/k/l` | move window left / down / up / right |
| `alt-q` | close the focused window |

> On macOS `alt-l` is still focus-right, since there is no `i3lock`.

### Layout
| Key | Action |
|---|---|
| `alt-minus` | resize smart −50 |
| `alt-equal` | resize smart +50 |
| `alt-slash` | cycle tiles → horizontal → vertical |
| `alt-comma` | cycle accordion → horizontal → vertical |
| `alt-f` | fullscreen |
| `alt-shift-space` | toggle floating / tiling |

### Workspaces
| Key | Action |
|---|---|
| `alt-1` … `alt-5` | switch to workspace 1–5 |
| `alt-shift-1` … `alt-shift-5` | move window to workspace 1–5 |

### Service mode
`alt-shift-;` enters service mode:

| Key | Action |
|---|---|
| `Esc` | reload the config, return to main mode |
| `r` | flatten the workspace tree (undo accidental nesting), return to main mode |

---

## Neovim

Config: `dots/nvim/` → `~/.config/nvim`
`Spc` = `Space` is the leader. `<leader>ch` opens the **NvCheatsheet**, which
lists every NvChad keymap in Neovim itself.

### Your own mappings
Defined in `lua/mappings.lua`.

| Mode | Key | Action |
|---|---|---|
| normal | `;` | `:` — enter command mode without holding Shift |
| insert | `jk` | `<Esc>` — vim-brain muscle memory |
| normal | `Spc m` | toggle the RenderMarkdown preview (markdown files only) |

### General
| Key | Action |
|---|---|
| `Spc n` | toggle absolute line numbers |
| `Spc rn` | toggle relative line numbers |
| `Spc ch` | NvCheatsheet |
| `Spc fm` | format the current buffer |
| `Esc` | clear search/visual highlights (`noh`) |
| `<C-s>` | save |
| `<C-c>` | copy the whole file |

### Insert-mode motion
| Key | Action |
|---|---|
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | left / down / up / right |
| `<C-b>` | start of line |
| `<C-e>` | end of line |

### Comments
| Mode | Key | Action |
|---|---|---|
| normal | `Spc /` | toggle line comment |
| visual | `Spc /` | toggle comment on the selection |

### Windows
| Key | Action |
|---|---|
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | focus window left / down / up / right |
| `<C-n>` | toggle NvimTree file browser |
| `Spc e` | focus the NvimTree window |

### Telescope
| Key | Searches |
|---|---|
| `Spc ff` | files in the project |
| `Spc fa` | **all** files, including hidden and gitignored |
| `Spc fb` | open buffers |
| `Spc fz` | fuzzy find inside the current buffer |
| `Spc fw` | live grep across the project |
| `Spc fo` | recently opened files |
| `Spc fh` | help pages |
| `Spc ma` | jump to a mark |
| `Spc gt` | git status |
| `Spc cm` | git commits |
| `Spc pt` | pick a hidden terminal |
| `Spc th` | NvChad themes |

### LSP
| Key | Action |
|---|---|
| `gd` | go to definition |
| `gr` | go to references |
| `K` | hover documentation |
| `Spc ua` | code action |
| `Spc ur` | rename symbol |
| `Spc uj` / `Spc uk` | next / previous diagnostic |
| `Spc ds` | send diagnostics to the quickfix list |

### Buffers and tabs
| Key | Action |
|---|---|
| `<Tab>` | next buffer |
| `<S-Tab>` | previous buffer |
| `Spc b` | new empty buffer |
| `Spc x` | close the current buffer |

### Terminals
| Key | Action |
|---|---|
| `Spc h` | new horizontal terminal |
| `Spc v` | new vertical terminal |
| `<Alt-h>` | toggle horizontal terminal |
| `<Alt-v>` | toggle vertical terminal |
| `<Alt-i>` | toggle floating terminal |
| `<C-x>` | in terminal mode, jump back to normal mode |

### Diagnostics and help
| Key | Action |
|---|---|
| `[d` / `]d` | previous / next diagnostic |
| `Spc wK` | WhichKey — show every keymap |
| `Spc wk` | WhichKey — fuzzy search keymaps |

---

## WezTerm

Config: `dots/wezterm/` → `~/.config/wezterm`

| Key | Action |
|---|---|
| `Ctrl+Shift+P` | open the command palette |
| right-click | context menu → Command Palette |

Three custom palette entries:

| Entry | Action |
|---|---|
| **Cycle terminal color scheme** | Mocha → NightWolf → CyberDream → CyberDream Light → Mocha |
| **Select terminal color scheme** | picker to jump straight to one |
| **Toggle terminal transparency** | opacity `1.0` ⇄ `0.8`, also swapping the background image |

All WezTerm's own default keybindings (`Ctrl+Shift+C/V` copy/paste,
`Ctrl+Shift+Alt+W` close pane, `Shift+Alt+Plus/Minus` font size, and so on) are
still active — this config doesn't override them.

---

## Shell aliases

From `modules/home/zsh.nix`. See
[`CHEATSHEET.md`](./CHEATSHEET.md) for the full table.

| Alias | Runs |
|---|---|
| `v` | `nvim` |
| `c` | `clear` |
| `t` | `tmux` |
| `x` | `exit` |
| `doc` | `docker` |
| `sz` | `source ~/.zshrc` |
| `ll` `la` `l` `ls` | `ls -alF` / `ls -A` / `ls -CF` / `eza` |
| `gac` | `git add . && git commit -m` |
| `please` | `sudo` |
| `py` | `python3` |
