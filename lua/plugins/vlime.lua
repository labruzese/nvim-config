return {
    "vlime/vlime",
    lazy = true,
    ft = { "lisp" },
    rtp = "vim",
    config = function()
        -- Set Vlime leader key to backslash (default)
        vim.g.vlime_leader = "\\"

        -- Configure how Vlime opens windows
        vim.g.vlime_window_settings = {
            repl = {
                pos = "botright", -- Position the window at the right side
                size = 50,        -- Width of the window (adjust as needed)
                vertical = 1,     -- Use vertical split (1 = enabled, 0 = disabled)
            },
            preview = {
                pos = "botright",
                size = 50,
                vertical = 1,
            },
            sldb = {
                pos = "botright",
                size = 50,
                vertical = 1,
            },
            inspector = {
                pos = "botright",
                size = 50,
                vertical = 1,
            },
            trace = {
                pos = "botright",
                size = 50,
                vertical = 1,
            },
        }
    end,
}
