return {
  defaults = { lazy = true },
  install = { colorscheme = { "nvchad" } },

  -- This config dir is managed by Home Manager, so individual files inside it
  -- are symlinks into /nix/store. Keep lazy.nvim's lockfile somewhere that is
  -- always writable, otherwise it can never be persisted.
  -- To version-control it: cp "$(nvim --headless -c 'lua io.write(vim.fn.stdpath("data"))' -c qa 2>&1)/lazy-lock.json" dots/nvim/lazy-lock.json
  lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",

  ui = {
    icons = {
      ft = "",
      lazy = "󰂠 ",
      loaded = "",
      not_loaded = "",
    },
  },

  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
}
