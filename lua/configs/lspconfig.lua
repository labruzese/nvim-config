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
            -- Kotlin Language Server configuration with enhanced KDoc support
            lspconfig[server_name].setup {
                on_attach = function(client, bufnr)
                    -- Standard on_attach function
                    nvlsp.on_attach(client, bufnr)

                    -- Enhanced hover handler
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>',
                        { noremap = true, silent = true, desc = "Enhanced hover with KDoc support" })
                end,
                on_init = nvlsp.on_init,
                capabilities = nvlsp.capabilities,
                root_dir = util.root_pattern("pom.xml", "build.gradle", "build.gradle.kts", "settings.gradle", "settings.gradle.kts", "*.kt", ".git"),
                -- Using default cmd without unsupported parameters
                -- cmd = {
                --     "kotlin-language-server"
                -- },
                settings = {
                    kotlin = {
                        -- Compiler settings
                        compiler = {
                            jvm = {
                                target = "21"
                            }
                        },
                        -- External sources configuration
                        externalSources = {
                            autoConvertToKotlin = true,
                            useKlsScheme = true,
                            includeStdLib = true,
                            includeKotlinApi = true,
                            downloadStdLib = true,
                            downloadJavadoc = true,
                            downloadSources = true
                        },
                        -- Completion settings with documentation
                        completion = {
                            snippets = { enabled = true },
                            smartCompletion = true,
                            documentation = {
                                enabled = true,
                                full = true,
                                webSample = true,
                                webLinks = true,
                                website = "kotlinlang.org",
                                includeStandardLibrary = true,
                                renderMarkdown = true,
                                colors = {
                                    enabled = true,
                                    background = "#0d1117",
                                    foreground = "#f0f6fc",
                                    codeBlocks = true,
                                    headers = true,
                                    links = "#58a6ff"
                                }
                            }
                        },
                        -- Hover documentation settings
                        hover = {
                            enabled = true,
                            documentation = {
                                enabled = true,
                                full = true,
                                webSample = true,
                                webLinks = true,
                                website = "kotlinlang.org",
                                includeStandardLibrary = true,
                                renderMarkdown = true,
                                enhancedRendering = true,
                                colors = {
                                    enabled = true,
                                    background = "#0d1117",
                                    foreground = "#f0f6fc",
                                    kdoc = {
                                        tagNameColor = "#ff7b72",
                                        tagDescriptionColor = "#c9d1d9",
                                        linkColor = "#58a6ff",
                                        codeBackgroundColor = "#161b22",
                                        codeColor = "#f0f6fc"
                                    }
                                }
                            },
                            references = { enabled = true },
                            semanticTokens = { enabled = true }
                        },
                        -- KDoc specific settings
                        kDoc = {
                            enabled = true,
                            enableExternal = true,
                            enableStandardLibrary = true,
                            loadStandardLibraryKDoc = true,
                            webLookup = true,
                            preferSourceCodeWithJavadoc = true,
                            applyColorScheme = true,
                            styling = {
                                enabled = true,
                                useMarkdownRendering = true,
                                colorize = true,
                                useSyntaxHighlighting = true
                            },
                            colors = {
                                enabled = true,
                                tagNameColor = "#ff7b72",
                                tagDescriptionColor = "#c9d1d9",
                                linkColor = "#58a6ff",
                                headerColor = "#d2a8ff",
                                codeBlockColor = "#79c0ff"
                            },
                            referenceProvider = {
                                enabled = true,
                                includeStandardLibrary = true
                            },
                            externalDocumentation = {
                                enabled = true,
                                website = "kotlinlang.org",
                                standardLibrary = true,
                                includeJava = true,
                                useCache = true
                            }
                        },
                        -- Semantic highlighting settings
                        semanticHighlighting = {
                            enabled = true
                        },
                        -- Formatting settings
                        formatting = {
                            enabled = true
                        }
                    }
                },
                handlers = {
                    ["textDocument/hover"] = vim.lsp.with(
                        vim.lsp.handlers.hover, {
                            border = "rounded",
                            max_width = 100,
                            max_height = 50,
                            stylize_markdown = true,
                        }
                    )
                },
                -- Enhanced init options
                init_options = {
                    storagePath = "/tmp/kotlin-language-server",
                    transport = "stdio",
                    clientInfo = {
                        name = "neovim",
                        version = "0.9.0"
                    },
                    -- Classpath and compiler options
                    compilerOptions = {
                        jvm = {
                            target = "21"
                        },
                        api = {
                            version = "1.9"
                        },
                        javaSourceCompatibility = "21"
                    },
                    -- Maven integration
                    maven = {
                        enabled = true,
                        downloadSources = true,
                        downloadJavadoc = true
                    },
                    -- Gradle integration
                    gradle = {
                        enabled = true,
                        downloadSources = true,
                        downloadJavadoc = true
                    },
                    -- External sources configuration
                    externalSources = {
                        enabled = true,
                        autoConvertToKotlin = true,
                        includeStdLib = true,
                        includeJdk = true,
                        downloadIfMissing = true,
                        preferLocalSources = false
                    },
                    -- Enhanced KDoc lookup configuration
                    docLookup = {
                        enabled = true,
                        webProvider = "kotlinlang.org",
                        useCache = true,
                        maxCacheSize = 500,
                        renderFormatting = true,
                        standardLibrary = {
                            enabled = true,
                            downloadIfMissing = true,
                            jdkSourcesEnabled = true,
                            forceDownload = true,
                            preferWebLookup = false
                        },
                        externalDocumentation = {
                            enabled = true,
                            preferWebsite = true,
                            cacheEnabled = true
                        }
                    },
                    -- Web integration for documentation
                    webIntegration = {
                        enabled = true,
                        documentationLookup = {
                            kotlinlang = true,
                            androidDocs = true,
                            standardLibrary = true,
                            jdk = true
                        }
                    },
                    -- Hover documentation rendering options
                    hover = {
                        enabled = true,
                        enhancedRendering = true
                    },
                    -- Styling for KDoc and documentation rendering
                    renderOptions = {
                        colors = true,
                        codeBlocks = true,
                        useTheme = true,
                        supportMarkdown = true,
                        enhancedHover = true,
                        applyHighlighting = true,
                        syntaxHighlighting = true,
                        theme = "dark"
                    },
                    -- Standard library specific configuration
                    standardLibrary = {
                        enabled = true,
                        downloadSources = true,
                        downloadJavadoc = true,
                        includeInCompletion = true,
                        includeInHover = true,
                        enhancedDocumentation = true,
                        colorizeDocumentation = true
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
