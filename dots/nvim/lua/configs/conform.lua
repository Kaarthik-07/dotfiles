local options = {
    formatters_by_ft = {
        lua        = { "stylua" },
        c          = { "clang_format" },
        cpp        = { "clang_format" },
        go         = { "gofumpt", "goimports" },
        python     = { "isort", "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        html       = { "prettier" },
        css        = { "prettier" },
        json       = { "prettier" },
        yaml       = { "prettier" },
        markdown   = { "prettier" },
        graphql    = { "prettier" },
        rust       = { "rustfmt" },
        sh         = { "shfmt" },
        bash       = { "shfmt" },
        nix        = { "nixfmt" },
    },

    formatters = {
        black = {
            prepend_args = { "--fast", "--line-length", "88" },
        },
        isort = {
            prepend_args = { "--profile", "black" },
        },
        prettier = {
            prepend_args = { "--tab-width", "2", "--single-quote" },
        },
        shfmt = {
            prepend_args = { "-i", "2" },
        },
    },

    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
}

require("conform").setup(options)
