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
    },
    automatic_installation = true,
})
