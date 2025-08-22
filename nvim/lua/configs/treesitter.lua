local options = {
    ensure_installed = {
        "bash",
        "c",
        "cmake",
        "cpp",
        "fish",
        "go",
        "lua",
        "luadoc",
        "markdown",
        "printf",
        "python",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
        "typescript",
        "javascript",
        "dockerfile",
        "css",
        "html",
        "json",
        "nix",
        "prisma",
        "proto",
        "sql",
    },

    highlight = {
        enable = true,
        use_languagetree = true,
    },

    indent = { enable = true },
}

require("nvim-treesitter.configs").setup(options)
