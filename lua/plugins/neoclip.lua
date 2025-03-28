return {
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      { "kkharji/sqlite.lua" },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      require("neoclip").setup()
    end,
  }
}
