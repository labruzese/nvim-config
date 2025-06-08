require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set

-- Your existing mappings
map('n', '<A-o>', '<Nop>', { desc = "No operation" })
map('i', '<A-o>', '<Nop>', { desc = "No operation" })
map('v', '<A-o>', '<Nop>', { desc = "No operation" })
map('t', '<A-o>', '<Nop>', { desc = "No operation" })

map('v', 'y', '"+y', { desc = "Yank to system clipboard (visual mode)" })

map('n', '-', "<cmd>Oil<cr>", { desc = "Open parent directory with Oil" })

-- Terminal keybinds
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Window navigation
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the top window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the bottom window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })

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
