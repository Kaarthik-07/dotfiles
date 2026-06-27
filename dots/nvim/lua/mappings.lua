require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- markdown render toggle
map("n", "<leader>m", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toggle Markdown Render" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
