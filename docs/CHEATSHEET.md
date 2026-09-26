# Cheatsheet

One page, everything you need daily. Full detail in
[`KEYBINDINGS.md`](./KEYBINDINGS.md) and [`REFERENCE.md`](./REFERENCE.md).

`Mod` = **Super** (i3/Linux) · `Spc` = **Space** (Neovim leader)

---

## i3 — the 15 that matter

| Key | Does |
|---|---|
| `Mod+Return` | new terminal |
| `Mod+d` | app launcher |
| **`Mod+l`** | **lock screen** |
| `Mod+q` | close window |
| `Mod+h/j/k` `Mod+Right` | focus left/down/up/right |
| `Mod+Shift+h/j/k/l` | move window |
| `Mod+b` / `Mod+v` | split horizontal / vertical |
| `Mod+f` | fullscreen |
| `Mod+Shift+space` | float window |
| `Mod+1..5` | workspace 1–5 |
| `Mod+Shift+1..5` | send window to workspace |
| `Mod+r` | resize mode (`h`/`j`/`k`/`l`, `Esc` to exit) |
| `Mod+Shift+v` | clipboard history |
| `Mod+Shift+c` | reload config |
| `Mod+Shift+e` | quit i3 |

**Volume / brightness** work on the multimedia keys. Auto-lock fires after
**5 min idle**.

**Screenshots:** `Print` full · `Shift+Print` area · `Ctrl+Print` save — all
copy to clipboard.

> `Mod+l` locks the screen, so focus-right moved to `Mod+Right`.

---

## AeroSpace (macOS) — `Mod` = `alt`

| Key | Does |
|---|---|
| `alt-h/j/k/l` | focus |
| `alt-shift-h/j/k/l` | move |
| `alt-1..5` | workspace |
| `alt-shift-1..5` | send to workspace |
| `alt-f` | fullscreen |
| `alt-shift-space` | float |
| `alt-minus` / `alt-equal` | shrink / grow |
| `alt-q` | close |
| `alt-shift-;` | service mode → `Esc` reload, `r` flatten tree |

---

## Neovim — the 20 that matter

| Key | Does |
|---|---|
| `Spc ff` / `Spc fa` | find files / find **all** files |
| `Spc fw` | live grep |
| `Spc fb` | switch buffer |
| `<Tab>` / `<S-Tab>` | next / prev buffer |
| `gd` / `gr` / `K` | definition / references / hover |
| `Spc ua` / `Spc ur` | code action / rename |
| `Spc fm` | format buffer (also on save) |
| `Spc /` | toggle comment |
| `<C-n>` / `Spc e` | file tree toggle / focus |
| `<C-h/j/k/l>` | move between windows |
| `Spc h` / `Spc v` / `<Alt-v>` | new h-term / new v-term / toggle v-term |
| `Spc wK` | WhichKey — all keymaps |
| `Spc ch` | NvCheatsheet |
| `;` | `:` command mode |
| `jk` | `Esc` (insert mode) |

**In Neovim:** `:Mason` installs and manages **language servers** only (the
mason 2.0 split). Linters and formatters come from Nix — if one is missing, add
it to `modules/home/neovim.nix`, not Mason. Other useful commands: `:Lazy sync` ·
`:ConformInfo` shows the active formatter.

---

## Shell aliases

| Alias | Runs | | Alias | Runs |
|---|---|---|---|---|
| `v` | `nvim` | | `ll` | `ls -alF` |
| `c` | `clear` | | `la` | `ls -A` |
| `t` | `tmux` | | `l` | `ls -CF` |
| `x` | `exit` | | `ls` | `eza` |
| `doc` | `docker` | | `gac` | `git add . && git commit -m` |
| `sz` | `source ~/.zshrc` | | `please` | `sudo` |
| `py` | `python3` | | `pbcopy` | `xclip -sel clip` |

Prompt shows: directory · git branch · git status · python/node/rust/go/java
versions, and the `❯` turns **red on a failed command**.

---

## WezTerm

`Ctrl+Shift+P` → **Cycle terminal color scheme** · **Select terminal color
scheme** · **Toggle terminal transparency**

---

## CLI tools you have

| Instead of | Use | Why |
|---|---|---|
| `grep` | `rg` | ripgrep — much faster, respects `.gitignore` |
| `find` | `fd` | simpler syntax, ignores by default |
| `ls` | `eza` | git-aware, icons, tree view |
| `cat` | `bat` | syntax highlighting, line numbers |
| — | `fzf` | fuzzy finder (used by dmenu and friends) |
| — | `jq` | JSON |
| — | `direnv` | auto-loads env per directory |

---

## Nix commands

```bash
# apply everything
sudo nixos-rebuild switch --flake .#linux

# just the user layer
home-manager switch --flake .#linux

# see what would change, build nothing
nix build .#nixosConfigurations.linux.config.system.build.toplevel --dry-run

# update dependencies (rewrites flake.lock)
nix flake update

# clean old store paths
nix-collect-garbage -d
```

---

## When something breaks

| Symptom | Try |
|---|---|
| i3 change ignored | `Mod+Shift+c` |
| formatting does nothing on save | `:Mason` → install the missing binary |
| nvim plugin gone | `:Lazy sync` |
| a formatter/linter is missing | it's a Nix package — add it to `modules/home/neovim.nix` and rebuild, then `:Lazy sync` if the plugin itself is missing |
| Mason can't find a package | Mason 2.0 only handles language servers; linters/formatters are Nix packages |
| dmenu shows blank icons | confirm the `dmenu-run` wrapper is intact in `modules/linux/i3.nix` |
| `nix` permission denied on the lock | `sudo chown $USER flake.lock` |
| want to see every keymap | `Spc wK` in Neovim, `Spc ch` for the NvChad sheet |
