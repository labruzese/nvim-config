return {
    "stevearc/oil.nvim",
    lazy = false,
    opts = require "configs.oil",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "-", "<CMD>Oil<CR>", desc = "Open parent directory with Oil" },
    },
}
