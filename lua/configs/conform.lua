local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang_format" },
        kotlin = { "ktlint" },
    },
    formatters = {
        clang_format = {
            prepend_args = {
                "--style={IndentWidth: 4, TabWidth: 4, UseTab: Never, BasedOnStyle: LLVM, SeparateDefinitionBlocks: Always, ColumnLimit: 100, KeepEmptyLinesAtTheStartOfBlocks: false, SpaceBeforeParens: ControlStatements}"
            }
        },
        ktlint = {
            cmd = 'ktlint',
            stdin = true,
            args = { '--format', '--stdin', '--log-level=none' },
        }
    },
    format_on_save = {
        timeout_ms = 15000,
        lsp_fallback = true,
    },
    log_level = vim.log.levels.INFO,
    notify_on_error = true,
}
return options
