-- Async, non-blocking jdtls setup (stable)

local M = {}

function M.start()
    local root_dir = vim.fs.root(0, {
        ".git",
        "mvnw",
        "gradlew",
        "pom.xml",
        "build.gradle",
    })

    if not root_dir then
        return
    end

    local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
    local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name

    local cmd = {
        "jdtls",
        "-data",
        workspace_dir,
        "-Xms512m",
        "-Xmx2g",
    }

    vim.schedule(function()
        vim.lsp.start({
            name = "jdtls",
            cmd = cmd,
            root_dir = root_dir,
        })
    end)
end

return M
