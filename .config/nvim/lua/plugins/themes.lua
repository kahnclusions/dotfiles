---@type LazySpec
return {
   {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {
         style = "night",
      },
   },
   { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
   { "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
   {
      "mcchrish/zenbones.nvim",
      lazy = false,
      priority = 1000,
      dependencies = {
         "rktjmp/lush.nvim",
      },
   },
   {
      "rose-pine/nvim",
      name = "rose-pine",
      config = function()
         require("rose-pine").setup({
            -- highlight_groups = {
            --    Cursor = { fg = "#ffffff", bg = "#6e6a86" },
            -- },
         })
      end,
   },
   {
      "thesimonho/kanagawa-paper.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
      config = function()
         -- require("kanagawa-paper").setup({
         --    overrides = function(colors)
         --       return {
         --          NeoTreeNormal = { bg = colors.theme.ui.bg },
         --          NeoTreeNormalNC = { bg = colors.theme.ui.bg },
         --          Normal = { bg = colors.theme.ui.float.bg },
         --          NormalNC = { bg = colors.theme.ui.float.bg },
         --       }
         --    end,
         -- })
      end,
   },
   {
      "Verf/deepwhite.nvim",
      lazy = false,
      priority = 1000,
   },
   {
      "gbprod/nord.nvim",
      lazy = false,
      priority = 1000,
      config = function()
         require("nord").setup({})
      end,
   },
}
