require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set

-- Your existing mappings
map('n', '<A-o>', '<Nop>', { desc = "No operation" })
map('i', '<A-o>', '<Nop>', { desc = "No operation" })
map('v', '<A-o>', '<Nop>', { desc = "No operation" })
map('t', '<A-o>', '<Nop>', { desc = "No operation" })

map('n', '<C-y>', '"+y', { desc = "Yank to system clipboard (normal mode)" })
map('v', '<C-y>', '"+y', { desc = "Yank to system clipboard (visual mode)" })
map('n', '<C-p>', '"+p', { desc = "Paste from system clipboard (normal mode)" })

map('n', '-', "<cmd>Oil<cr>", { desc = "Open parent directory with Oil" })

-- Terminal keybinds
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Window navigation
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the top window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the bottom window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })

-- Compile and run (F5)
map('n', '<F5>', function()
    vim.cmd('write')
    local file = vim.fn.expand('%:r')
    vim.cmd('split term://gcc % -o ' .. file .. '.exe && ' .. file .. '.exe')
end, { noremap = true, silent = true, desc = "Compile and run C/C++" })

-- LSP keybindings
map('n', 'gD', vim.lsp.buf.declaration, { desc = "Go to declaration" })
map('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
map('n', 'K', vim.lsp.buf.hover, { desc = "Show hover documentation" })
map('n', 'gi', vim.lsp.buf.implementation, { desc = "Go to implementation" })
map('n', '<C-k>', vim.lsp.buf.signature_help, { desc = "Show signature help" })
map('n', '<space>D', vim.lsp.buf.type_definition, { desc = "Go to type definition" })
map('n', '<space>rn', vim.lsp.buf.rename, { desc = "Rename symbol" })
map('n', '<space>ca', vim.lsp.buf.code_action, { desc = "Code actions" })
map('n', 'gr', vim.lsp.buf.references, { desc = "Find references" })
map('n', '<space>f', function()
    local conform = require("conform")
    conform.format({
        async = true,
        lsp_fallback = true,
    })
end, { desc = "Format code with conform.nvim" })

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map('n', '<space>e', vim.diagnostic.open_float, { desc = "Show diagnostic details" })
map('n', '<space>q', vim.diagnostic.setloclist, { desc = "Add diagnostics to location list" })

-- Optional: Add clangd-specific keybindings
map('n', '<space>sh', vim.lsp.buf.signature_help, { desc = "Show signature help" })
map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
map('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "List workspace folders" })
