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
  -- Treesitter (extend NvChad's built-in spec via opts merge)
  -- -----------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash", "c", "cmake", "cpp", "fish", "go",
        "lua", "luadoc", "markdown", "markdown_inline",
        "python", "rust", "toml", "vim", "vimdoc",
        "yaml", "typescript", "tsx", "javascript", "jsdoc",
        "dockerfile", "css", "html", "json", "json5",
        "java", "graphql", "properties", "xml",
        "nix", "prisma", "proto", "sql", "regex",
      },
      highlight = { enable = true, use_languagetree = true },
      indent    = { enable = true },
    },
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

  -- -----------------------------
  -- Markdown renderer
  -- -----------------------------
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
    opts = {
      enabled = true,
      heading = {
        enabled = true,
        icons   = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        backgrounds = {
          "RenderMarkdownH1Bg",
          "RenderMarkdownH2Bg",
          "RenderMarkdownH3Bg",
          "RenderMarkdownH4Bg",
          "RenderMarkdownH5Bg",
          "RenderMarkdownH6Bg",
        },
      },
      code = {
        enabled = true,
        style   = "full",
        border  = "thin",
      },
      bullet = {
        enabled = true,
        icons   = { "●", "○", "◆", "◇" },
      },
      checkbox = { enabled = true },
      quote    = { enabled = true },
      table    = { enabled = true },
      link     = { enabled = true },
    },
  },
}
