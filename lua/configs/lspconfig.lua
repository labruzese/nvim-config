require("nvchad.configs.lspconfig").defaults()
require("mason")

local lspconfig = require "lspconfig"
local mason_lspconfig = require("mason-lspconfig")
local nvlsp = require "nvchad.configs.lspconfig"

-- Detect operating system
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
local is_linux = vim.loop.os_uname().sysname == "Linux"

-- Then set up the handlers
mason_lspconfig.setup {
    function(server_name)
        if server_name == "clangd" then
            local query_driver = {}
            local fallback_flags = {}

            if is_windows then
                query_driver = { "C:/msys64/ucrt64/bin/gcc.exe" }
                fallback_flags = {
                    "-Wall",
                    "-std=c17",
                    "-xc",
                    "--target=x86_64-w64-mingw32",
                    "-IC:/msys64/ucrt64/include",
                    "-IC:/msys64/ucrt64/x86_64-w64-mingw32/include",
                    "-IC:/msys64/ucrt64/lib/gcc/x86_64-w64-mingw32/14.2.0/include",
                    "-IC:/msys64/usr/include",
                    "-I" .. vim.fn.getcwd() .. "/include"
                }
            elseif is_linux then
                -- Arch Linux gcc path
                query_driver = { "/usr/bin/gcc" }
                fallback_flags = {
                    "-Wall",
                    "-std=c17",
                    "-xc",
                    "--target=x86_64-pc-linux-gnu",
                    "-I/usr/include",
                    "-I/usr/local/include",
                    "-I" .. vim.fn.getcwd() .. "/include"
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
