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
                        -- Enhanced documentation settings
                        externalSources = {
                            autoConvertToKotlin = true,
                            useKlsScheme = true, -- Enable KLS URI scheme for external documentation
                        },
                        completion = {
                            snippets = { enabled = true },
                            documentation = {
                                enabled = true,
                                full = true,
                                webSample = true,          -- Include web samples in documentation
                                webLinks = true,           -- Show links to online documentation
                                website = "kotlinlang.org" -- Use kotlinlang.org as source for documentation
                            }
                        },
                        hover = {
                            documentation = {
                                enabled = true,
                                full = true,
                                webSample = true,          -- Include web samples in hover
                                webLinks = true,           -- Show links to online documentation
                                website = "kotlinlang.org" -- Use kotlinlang.org as source for documentation
                            },
                            references = { enabled = true }
                        },
                        -- Add KDoc integration
                        kDoc = {
                            enableExternal = true, -- Enable fetching external documentation
                            webLookup = true,      -- Enable web lookup for KDoc
                            referenceProvider = {
                                enabled = true     -- Enable reference provider for KDoc
                            },
                            externalDocumentation = {
                                enabled = true,            -- Enable external documentation
                                website = "kotlinlang.org" -- Use kotlinlang.org as source
                            }
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
                -- Add initialization options for Maven and external sources
                init_options = {
                    storagePath = "/tmp/kotlin-language-server",
                    transport = "stdio",
                    clientInfo = {
                        name = "neovim",
                    },
                    maven = {
                        enabled = true,
                    },
                    externalSources = {
                        enabled = true,
                        autoConvertToKotlin = true
                    },
                    -- Add KDoc lookup configuration
                    docLookup = {
                        enabled = true,
                        webProvider = "kotlinlang.org", -- Use official Kotlin documentation
                        useCache = true,                -- Cache documentation locally
                        maxCacheSize = 100,             -- Maximum number of cached items
                        externalDocumentation = {
                            enabled = true,
                            preferWebsite = true -- Prefer website over local docs
                        }
                    },
                    -- Add web integration
                    webIntegration = {
                        enabled = true,        -- Enable web integration
                        documentationLookup = {
                            kotlinlang = true, -- Enable kotlinlang.org lookups
                            androidDocs = true -- Enable Android documentation
                        }
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
