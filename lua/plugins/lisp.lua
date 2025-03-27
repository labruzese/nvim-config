-- ~/.config/nvim/lua/plugins/lisp.lua
-- Common Lisp (ABCL) development configuration for Neovim

return {
    -- VLIME: Modern Common Lisp development environment
    -- {
    --     "vlime/vlime",
    --     event = { "BufReadPre", "BufNewFile" },
    --     ft = { "lisp" },
    --     build = function()
    --         -- The correct way to build VLIME - run make in the lisp directory
    --         vim.fn.system("cd $LAZY_PLUGINS_DIR/vlime/lisp && make")
    --     end,
    --     config = function()
    --         -- ABCL Configuration
    --         vim.g.vlime_cl_impl = "abcl"
    --
    --         -- You may need to set the path to your ABCL executable
    --         -- vim.g.vlime_cl_use_terminal = true
    --         -- vim.g.vlime_cl_cmd_args = {"--load", "~/.abclrc"} -- Optional ABCL-specific args
    --
    --         -- UI preferences
    --         vim.g.vlime_contribs = { 'SWANK-ASDF', 'SWANK-PACKAGE-FU', 'SWANK-PRESENTATIONS', 'SWANK-FANCY-INSPECTOR' }
    --         vim.g.vlime_window_settings = {
    --             repl = { pos = "botright", size = 10 },
    --             inspector = { pos = "botright vertical", size = 80 },
    --             preview = { pos = "topleft", size = 40 },
    --             arglist = { pos = "botright", size = 5 },
    --             server = { pos = "topleft", size = 30 },
    --         }
    --
    --         -- REPL Configuration
    --         vim.g.vlime_compiler_policy = { ["DEBUG"] = 3, ["SPEED"] = 0, ["SAFETY"] = 3 }
    --
    --         -- Create custom keymappings (only applied to Lisp files)
    --         vim.api.nvim_create_autocmd("FileType", {
    --             pattern = "lisp",
    --             callback = function()
    --                 -- Local keybindings for Lisp files
    --                 -- local opts = { noremap = true, silent = true, buffer = true }
    --                 --
    --                 -- -- Connection management
    --                 -- vim.keymap.set("n", "<localleader>c", ":call vlime#plugin#ConnectREPL()<CR>", opts)
    --                 -- vim.keymap.set("n", "<localleader>C", ":call vlime#plugin#DisconnectREPL()<CR>", opts)
    --                 --
    --                 -- -- Evaluation
    --                 -- vim.keymap.set("n", "<localleader>ee", ":call vlime#plugin#Eval(vlime#ui#CurExprOrAtom())<CR>", opts)
    --                 -- vim.keymap.set("n", "<localleader>ei", ":call vlime#plugin#InteractiveEval()<CR>", opts)
    --                 -- vim.keymap.set("n", "<localleader>eb", ":call vlime#plugin#EvalBuffer()<CR>", opts)
    --                 -- vim.keymap.set("v", "<localleader>e", ":<C-u>call vlime#plugin#Eval(vlime#ui#CurSelection())<CR>", opts)
    --                 --
    --                 -- -- Compilation
    --                 -- vim.keymap.set("n", "<localleader>cc", ":call vlime#plugin#Compile(vlime#ui#CurExpr())<CR>", opts)
    --                 -- vim.keymap.set("n", "<localleader>cf", ":call vlime#plugin#CompileFile(expand('%:p'))<CR>", opts)
    --                 --
    --                 -- -- Documentation
    --                 -- vim.keymap.set("n", "K", ":call vlime#plugin#DescribeSymbol(vlime#ui#CurAtom())<CR>", opts)
    --                 -- vim.keymap.set("n", "<localleader>dd", ":call vlime#plugin#Documentation(vlime#ui#CurAtom())<CR>", opts)
    --                 -- vim.keymap.set("n", "<localleader>da", ":call vlime#plugin#AproposList()<CR>", opts)
    --                 --
    --                 -- -- Navigation
    --                 -- vim.keymap.set("n", "<localleader>gd", ":call vlime#plugin#FindDefinition(vlime#ui#CurAtom())<CR>", opts)
    --                 -- vim.keymap.set("n", "<localleader>gs", ":call vlime#plugin#ShowOperatorArgList(vlime#ui#CurOperator())<CR>", opts)
    --                 -- vim.keymap.set("n", "<localleader>gi", ":call vlime#plugin#Inspect(vlime#ui#CurExprOrAtom())<CR>", opts)
    --             end
    --         })
    --     end
    -- },

    -- -- Parinfer: Structural editing and auto-balancing of parens
    -- {
    --     "eraserhd/parinfer-rust",
    --     build = "cargo build --release",
    --     ft = { "lisp", "scheme", "racket" },
    --     config = function()
    --         vim.g.parinfer_mode = "smart"
    --         vim.g.parinfer_enabled = 1
    --         vim.g.parinfer_force_balance = true
    --     end
    -- },

    -- Rainbow Parentheses for better visual matching
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local rainbow_delimiters = require('rainbow-delimiters')

            vim.g.rainbow_delimiters = {
                strategy = {
                    [''] = rainbow_delimiters.strategy['global'],
                    lisp = rainbow_delimiters.strategy['local'],
                },
                query = {
                    [''] = 'rainbow-delimiters',
                    lisp = 'rainbow-blocks',
                },
                highlight = {
                    'RainbowDelimiterRed',
                    'RainbowDelimiterYellow',
                    'RainbowDelimiterBlue',
                    'RainbowDelimiterOrange',
                    'RainbowDelimiterGreen',
                    'RainbowDelimiterViolet',
                    'RainbowDelimiterCyan',
                },
            }
        end,
    },

    -- Configure Treesitter for Lisp syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                vim.list_extend(opts.ensure_installed, { "commonlisp" })
            end
        end,
    },

    -- Additional Common Lisp support
    {
        "sheerun/vim-polyglot",
        lazy = false,
        config = function()
            vim.g.lisp_rainbow = 1
            vim.cmd([[
        let g:lisp_instring = 1
        let g:lisp_rainbow = 1
        let g:lisp_navigation = 1
      ]])
        end
    },

    -- Optional: Snippets for Common Lisp
    {
        "L3MON4D3/LuaSnip",
        config = function()
            local ls = require("luasnip")
            local s = ls.snippet
            local t = ls.text_node
            local i = ls.insert_node

            -- Add Common Lisp snippets
            ls.add_snippets("lisp", {
                s("defun", {
                    t("(defun "),
                    i(1, "name"),
                    t(" ("),
                    i(2, "args"),
                    t(")"),
                    t({ "", "  " }),
                    i(3, "body"),
                    t({ "", ")" }),
                }),
                s("defmacro", {
                    t("(defmacro "),
                    i(1, "name"),
                    t(" ("),
                    i(2, "args"),
                    t(")"),
                    t({ "", "  " }),
                    i(3, "body"),
                    t({ "", ")" }),
                }),
                s("defpackage", {
                    t("(defpackage :"),
                    i(1, "name"),
                    t({ "", "  (:use :cl)" }),
                    i(2, ""),
                    t({ "", ")" }),
                }),
                s("let", {
                    t("(let (("),
                    i(1, "var"),
                    t(" "),
                    i(2, "val"),
                    t("))"),
                    t({ "", "  " }),
                    i(3, "body"),
                    t({ "", ")" }),
                }),
            })
        end,
    },
}
