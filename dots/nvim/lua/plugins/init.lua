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
  -- Mason (package manager)
  -- -----------------------------
  -- NOTE: these live under the mason-org GitHub org now. The old
  -- williamboman/* paths only still work via a 301 redirect.
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = {
      "mason-org/mason.nvim",
      "nvim-lspconfig",
    },
    config = function()
      require("configs.mason-lspconfig")
    end,
  },

  -- -----------------------------
  -- Linting
  -- -----------------------------
  -- The linter and formatter BINARIES are installed by Nix, not Mason -- see
  -- modules/home/neovim.nix. The standalone mason-nvim-lint and
  -- mason-conform plugins were deleted upstream when Mason 2.0 landed, so
  -- there is nothing left to install here.
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

  -- -----------------------------
  -- Inline images (PNG/JPG/...) rendered in the buffer
  -- Uses the kitty graphics protocol -- WezTerm implements it natively.
  -- Needs ImageMagick on PATH (see modules/home/neovim.nix extraPackages).
  -- Opening an image file directly (`:e foo.png`) renders it full-buffer;
  -- inside markdown, ![](img.png) renders inline too.
  -- -----------------------------
  {
    "3rd/image.nvim",
    build = false, -- magick_cli processor: no luarocks/rock build needed
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      backend   = "kitty",
      processor = "magick_cli",
      integrations = {
        markdown = { enabled = true },
      },
    },
  },
}
