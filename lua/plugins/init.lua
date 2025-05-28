return {
    {
        "stevearc/conform.nvim",
        event = 'BufWritePre',
        opts = require "configs.conform",
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "vim", "lua", "vimdoc",
                "html", "css", "kotlin", "c", "commonlisp", "bash", "yaml", "json", "latex", "haskell", "rust"
            },
        },
    },
}
