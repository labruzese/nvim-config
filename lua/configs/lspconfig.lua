require("nvchad.configs.lspconfig").defaults()
local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"
local util = require "lspconfig.util"

-- Detect operating system
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
local is_linux = vim.loop.os_uname().sysname == "Linux"

require("mason-lspconfig").setup_handlers {
    function(server_name)
        if server_name == "clangd" then
            local query_driver = {}
            local fallback_flags = {}

            if is_windows then
                query_driver = { "C:/msys64/ucrt64/bin/gcc.exe" }
                fallback_flags = {
                    "-Wall",
                    "-std=c17",
                    "--target=x86_64-w64-mingw32",
                    "-IC:/msys64/ucrt64/include",
                    "-IC:/msys64/ucrt64/x86_64-w64-mingw32/include",
                    "-IC:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/14.2.0/include",
                    "-IC:/msys64/usr/include"
                }
            elseif is_linux then
                -- Arch Linux gcc path
                query_driver = { "/usr/bin/gcc" }
                fallback_flags = {
                    "-Wall",
                    "-std=c17",
                    "--target=x86_64-pc-linux-gnu",
                    "-I/usr/include",
                    "-I/usr/local/include"
                }
            end

            lspconfig[server_name].setup {
                on_attach = nvlsp.on_attach,
                on_init = nvlsp.on_init,
                capabilities = nvlsp.capabilities,
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--completion-style=detailed",
                    "--header-insertion=iwyu",
                    "--suggest-missing-includes",
                    "--query-driver=" .. table.concat(query_driver, ","),
                    "--all-scopes-completion",
                    "--cross-file-rename",
                    "--offset-encoding=utf-16",
                },
                init_options = {
                    compilationDatabasePath = "",
                    fallbackFlags = fallback_flags
                }
            }
        elseif server_name == "kotlin_language_server" then
            -- Kotlin Language Server configuration
            lspconfig[server_name].setup {
                on_attach = nvlsp.on_attach,
                on_init = nvlsp.on_init,
                capabilities = nvlsp.capabilities,
                root_dir = util.root_pattern("pom.xml", "*.kt", ".git"),
                settings = {
                    kotlin = {
                        compiler = {
                            jvm = {
                                target = "21"
                            }
                        },
                        -- Add Maven configuration
                        externalSources = {
                            autoConvertToKotlin = true,
                        },
                        completion = {
                            snippets = { enabled = true },
                            documentation = { enabled = true, full = true }
                        },
                        hover = {
                            documentation = { enabled = true },
                            references = { enabled = true }
                        }
                    }
                },
                handlers = {
                    ["textDocument/hover"] = vim.lsp.with(
                        vim.lsp.handlers.hover, {
                            -- Increase border width for more content
                            border = "rounded",
                            -- Increase max width and height
                            max_width = 80,
                            max_height = 40
                        }
                    )
                },
                -- Add initialization options for Maven
                init_options = {
                    storagePath = "/tmp/kotlin-language-server",
                    transport = "stdio",
                    clientInfo = {
                        name = "neovim",
                    },
                    maven = {
                        enabled = true,
                    }
                }
            }
        else
            -- Default configuration for other language servers
            lspconfig[server_name].setup {
                on_attach = nvlsp.on_attach,
                on_init = nvlsp.on_init,
                capabilities = nvlsp.capabilities,
            }
        end
    end
}
