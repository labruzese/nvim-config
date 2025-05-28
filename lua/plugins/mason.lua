return {
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "clangd",
                "lua-language-server",
                "stylua",
            }
        }
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = { "clangd", "lua_ls" },
            automatic_installation = true,
        }
    }
}
