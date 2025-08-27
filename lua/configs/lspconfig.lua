_G.virtual_text_enabled = true

vim.diagnostic.config({
    virtual_text = {
        enabled = false,
        source = "if_many",
        prefix = "▎",
        spacing = 4,
        virt_text_pos = "right_align",
        severity_sort = true,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
        scope = 'cursor',
    }
})


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

vim.lsp.config('kotlin_lsp', {
    cmd = { "kotlin-lsp", "--stdio" },
    single_file_support = true,
    filetypes = { "kotlin" },
    root_markers = { "build.gradle", "build.gradle.kts", "pom.xml" },
})

-- This is a local install so we have to enable it manually (mason-lspconfig won't do it for us)
vim.lsp.enable('kotlin_lsp')

require("mason-lspconfig").setup()
