require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "clangd",
        "gopls",
        "pyright",
        "html",
        "cssls",
        "ts_ls",
        "jdtls",
        "rust_analyzer",
        "bashls",
        "jsonls",
        "yamlls",
        "dockerls",
        "tailwindcss",
    },
    automatic_installation = true,
})
