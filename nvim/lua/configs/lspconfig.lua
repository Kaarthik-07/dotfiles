-- Neovim 0.11+ NvChad LSP configuration
-- Java / Spring Boot ready

local base = require("nvchad.configs.lspconfig")
local on_attach = base.on_attach
local on_init = base.on_init
local capabilities = base.capabilities

--------------------------------------------------
-- STANDARD SERVERS (non-Java)
--------------------------------------------------
local servers = {
    "lua_ls",
    "pyright",
    "gopls",
    "clangd",
    "html",
    "cssls",
    "ts_ls",
}

for _, server in ipairs(servers) do
    vim.lsp.config(server, {
        on_attach = on_attach,
        capabilities = capabilities,
    })
end
--------------------------------------------------
-- LUA (Neovim specific fixes)
--------------------------------------------------
vim.lsp.config("lua_ls", {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
        },
    },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
        require("configs.jdtls").start()
    end,
})
