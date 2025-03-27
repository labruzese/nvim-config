local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        -- css = { "prettier" },
        -- html = { "prettier" },
        c = { "clang_format" },
    },
    formatters = {
        clang_format = {
            prepend_args = {
                "--style={IndentWidth: 4, TabWidth: 4, UseTab: Never, BasedOnStyle: LLVM, SeparateDefinitionBlocks: Always, ColumnLimit: 100, KeepEmptyLinesAtTheStartOfBlocks: false, SpaceBeforeParens: ControlStatements}"
            }
        }
    },
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
    },
}
return options
