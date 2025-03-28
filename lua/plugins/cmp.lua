return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",         -- Add cmp-path
        "hrsh7th/cmp-buffer",       -- For buffer completions
        "L3MON4D3/LuaSnip",         -- Snippet engine
        "saadparwaiz1/cmp_luasnip", -- LuaSnip completion source
    },
}
