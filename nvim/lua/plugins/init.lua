return {

    -- -----------------------------
    -- Java (SINGLE source of truth)
    -- -----------------------------
    {
        "nvim-java/nvim-java",
        ft = { "java" },
        config = function()
            -- REMOVE EVERYTHING HERE
        end,
    },
    -- -----------------------------
    -- Treesitter
    -- -----------------------------
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.treesitter")
        end,
    },

    -- -----------------------------
    -- LSP (NON-Java servers only)
    -- -----------------------------
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require("configs.lspconfig") -- MUST NOT setup jdtls
        end,
    },

    -- -----------------------------
    -- Mason LSP installer
    -- -----------------------------
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lspconfig" },
        config = function()
            require("configs.mason-lspconfig")
        end,
    },

    -- -----------------------------
    -- Linting
    -- -----------------------------
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.lint")
        end,
    },

    -- -----------------------------
    -- Formatting
    -- -----------------------------
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require("configs.conform")
        end,
    },
}
