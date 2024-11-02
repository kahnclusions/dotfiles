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
      "rebelot/kanagawa.nvim",
      lazy = false,
      priority = 1000,
      config = function()
         require("kanagawa").setup({
            colors = {
               all = {
                  ui = {
                     bg_gutter = "none",
                  },
               },
            },
            -- overrides = function(colors)
            --    local theme = colors.theme
            --    return {
            -- LineNr = { bg = "none" },
            -- SignColumn = { bg = "none" },
            -- FoldColumn = { bg = "none" },

            -- NormalFloat = { bg = "none" },
            -- FloatBorder = { bg = "none" },
            -- FloatTitle = { bg = "none" },

            -- Save an hlgroup with dark background and dimmed foreground
            -- so that you can use it where your still want darker windows.
            -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
            -- NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

            -- Popular plugins that open floats will link to NormalFloat by default;
            -- set their background accordingly if you wish to keep them dark and borderless
            -- LazyNormal = { bg = theme.ui.bg_m3 },
            -- MasonNormal = { bg = theme.ui.bg_m3 },
            -- Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
            -- PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            -- PmenuSbar = { bg = theme.ui.bg_m1 },
            -- PmenuThumb = { bg = theme.ui.bg_p2 },
            -- TelescopeTitle = { fg = theme.ui.special, bold = true },
            -- TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            -- TelescopePromptBorder = { bg = theme.ui.bg_p1 },
            -- TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            -- TelescopeResultsBorder = { bg = theme.ui.bg_m1 },
            -- TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            -- TelescopePreviewBorder = { bg = theme.ui.bg_dim },
            -- }
            -- end,
         })
      end,
   },
}
