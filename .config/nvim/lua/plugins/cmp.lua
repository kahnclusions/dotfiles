return {
   {
      "hrsh7th/cmp-nvim-lsp-signature-help",
      lazy = false,
   },
   {
      "hrsh7th/nvim-cmp",
      dependencies = {
         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-nvim-lsp-signature-help",
         "hrsh7th/cmp-buffer",
         "hrsh7th/cmp-path",
         "saadparwaiz1/cmp_luasnip",
         "hrsh7th/cmp-cmdline",
      },
      lazy = false,
      opts = function(_, opts)
         local cmp = require("cmp")
         -- opts.window = cmp.config.window
         opts.view = { docs = { auto_open = false } }
         opts.mapping["<C-g>"] = function()
            if cmp.visible_docs() then
               cmp.close_docs()
            else
               cmp.open_docs()
            end
         end
         opts.sources = cmp.config.sources({
            { name = "nvim_lsp_signature_help", priority = 1000 },
            { name = "nvim_lsp", priority = 1000 },
            -- { name = "luasnip", priority = 750 },
            { name = "buffer", priority = 500 },
            { name = "path", priority = 250 },
            { name = "emoji", priority = 700 }, -- add new source
         })
      end,
   },
}
