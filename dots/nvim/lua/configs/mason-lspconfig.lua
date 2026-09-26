-- Mason only handles LANGUAGE SERVERS here. Linters and formatters are
-- installed by Nix (see modules/home/neovim.nix), which is reproducible and
-- works offline, so there is no mason-nvim-lint / mason-conform plugin --
-- both of those were deleted upstream with Mason 2.0.
--
-- `automatic_installation` was removed in mason-lspconfig v2. `ensure_installed`
-- still installs on its own (see features/ensure_installed.lua), so it is all
-- that is needed here.
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "clangd",
        "gopls",
        "pyright",
        "html",
        "cssls",
        "ts_ls",
        -- jdtls omitted: nvim-java manages its own jdtls installation
        "rust_analyzer",
        "bashls",
        "jsonls",
        "yamlls",
        "dockerls",
        "tailwindcss",
        -- nixd omitted: already in environment.systemPackages via Nix
    },
})
