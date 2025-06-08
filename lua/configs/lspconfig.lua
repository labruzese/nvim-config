vim.lsp.config('clangd', {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--header-insertion=iwyu",
        "--suggest-missing-includes",
        "--all-scopes-completion",
        "--cross-file-rename",
    },
    init_options = {
        fallbackFlags = {
            "-Wall",
            "-std=c17",
            "-xc",
            "-I/usr/include",
            "I/usr/local/include",
            "-I" .. vim.fn.getcwd() .. "/include",
        }
    }
})

require("mason-lspconfig").setup()
