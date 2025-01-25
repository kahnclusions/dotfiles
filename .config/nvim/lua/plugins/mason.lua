---@type LazySpec
return {
   {
      "jay-babu/mason-null-ls.nvim",
      -- overrides `require("mason-null-ls").setup(...)`
      opts = function(_, opts)
         -- add more things to the ensure_installed table protecting against community packs modifying it
         opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
            "prettier",
            "stylua",
            "swiftformat",
            "swiftlint",
            -- add more arguments for adding more null-ls sources
         })
      end,
   },
}
