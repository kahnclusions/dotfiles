-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
   "AstroNvim/astrolsp",
   ---@type AstroLSPOpts
   opts = {
      servers = { "sourcekit" },
      config = {
         tsserver = { enabled = false },
         ["rust_analyzer"] = {
            settings = {
               ["rust-analyzer"] = {
                  diagnostics = {
                     disabled = { "unresolved-proc-macro" },
                  },
                  cargo = {
                     -- features = { "ssr" }, -- features = ssr, for LSP support in leptos SSR functions
                  },
               },
            },
         },
      },
      -- customize lsp formatting options
      formatting = {
         -- control auto formatting on save
         format_on_save = {
            ignore_filetypes = { -- disable format on save for specified filetypes
               "typescript",
               "typescriptreact",
            },
         },
         disabled = { -- disable formatting capabilities for the listed language servers
            "tsserver",
            "typescript-tools",
            -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
            -- "lua_ls",
         },
      },
   },
}
