local lint = require("lint")

lint.linters_by_ft = {
    lua        = { "luacheck" },
    python     = { "flake8" },
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    sh         = { "shellcheck" },
    bash       = { "shellcheck" },
}

lint.linters.luacheck.args = {
    "--globals", "love", "vim",
    "--formatter", "plain",
    "--codes", "--ranges", "-",
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    callback = function()
        lint.try_lint()
    end,
})
