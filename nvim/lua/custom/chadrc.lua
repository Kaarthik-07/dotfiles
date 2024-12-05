local M = {}
M.ui = {
  theme = "flow", -- Fallback theme (any base46 theme)
  nvdash = {
    load_on_startup = true,
  },
}

M.mappings = require "custom.mappings"
M.plugins = "custom.plugins"

return M
