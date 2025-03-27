return {
  {                   -- Added an extra { here
    "kdheepak/lazygit.nvim",
    lazy = false,     -- Added this line
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = {     -- Added this block
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
    },
    config = function()
      vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", { silent = true })
      vim.g.lazygit_use_neovim_remote = 1
    end,
  }
}
