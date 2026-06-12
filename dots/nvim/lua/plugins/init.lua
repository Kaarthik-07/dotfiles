return {

  -- -----------------------------
  -- Java (SINGLE source of truth)
  -- -----------------------------
  {
    "nvim-java/nvim-java",
    ft = { "java" },
    config = function()
      require("java").setup()
    end,
  },

  -- -----------------------------
  -- Treesitter
  -- -----------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      require("configs.treesitter")
    end,
  },

  -- -----------------------------
  -- LSP Core
  -- -----------------------------
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("configs.lspconfig")
    end,
  },

  -- -----------------------------
  -- Mason
  -- -----------------------------
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = {
      "mason.nvim",
      "nvim-lspconfig",
    },
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
