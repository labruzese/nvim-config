require "nvchad.options"
local o = vim.o

-- o.cursorlineopt ='both' -- to enable cursorline!
o.relativenumber = true
o.scrolloff = 10
o.smartindent = true

o.clipboard = ""

-- Explicit 4-space tab configuration
o.tabstop = 4       -- Number of spaces a <Tab> in the file counts for
o.softtabstop = 4   -- Number of spaces a <Tab> counts for while editing
o.shiftwidth = 4    -- Number of spaces to use for each step of (auto)indent
o.expandtab = false -- Use spaces instead of tabs

-- Ensure consistent indentation for different file types
vim.api.nvim_create_autocmd("FileType", {
    desc = "Set consistent tab settings",
    group = vim.api.nvim_create_augroup("consistent-tabs", { clear = true }),
    callback = function()
        vim.bo.tabstop = 4
        vim.bo.softtabstop = 4
        vim.bo.shiftwidth = 4
        vim.bo.expandtab = true
    end,
})

-- Set up K to use man with section 3 for C files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "c",
    callback = function()
        vim.bo.keywordprg = "man 3" -- Use man section 3 specifically for library functions
    end,
})

-- Existing yank highlight autocmd
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.h",
    callback = function()
        vim.bo.filetype = "c"
    end,
    desc = "Treat .h files as C files"
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
    pattern = { "*.hl", "hypr*.conf" },
    callback = function()
        vim.lsp.start {
            name = "hyprlang",
            cmd = { "hyprls" },
            root_dir = vim.fn.getcwd(),
        }
    end
})
