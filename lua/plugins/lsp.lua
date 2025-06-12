return {
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "bash-language-server",
                "clang-format",
                "clangd",
                "css-lsp",
                "css-variables-language-server",
                "hyprls",
                "json-lsp",
                "ktlint",
                "lua-language-server",
                "markdownlint",
                "marksman",
                "shellcheck",
                "taplo",
                "yaml-language-server",
                "yamllint",
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
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },
}
