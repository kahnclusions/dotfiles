-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
   "AstroNvim/astrolsp",
   init = function()
      for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
         local default_diagnostic_handler = vim.lsp.handlers[method]
         vim.lsp.handlers[method] = function(err, result, context, config)
            if err ~= nil and err.code == -32802 then
               return
            end
            return default_diagnostic_handler(err, result, context, config)
         end
      end
   end,
   ---@type AstroLSPOpts
   opts = {
      servers = { "sourcekit" },
      config = {
         tsserver = { enabled = false },
         ["rust_analyzer"] = {
            settings = {
               ["rust-analyzer"] = {
                  cargo = {
                     check = { command = "check", extraArgs = {} },
                     extraEnv = { CARGO_PROFILE_RUST_ANALYZER_INHERITS = "dev" },
                     extraArgs = { "--profile", "rust-analyzer" },
                     -- features = { "hydrate", "csr" }, -- features = ssr, for LSP support in leptos SSR functions
                  },
               },
            },
         },
         tailwindcss = {
            filetypes = { "rust" },
         },
      },
      -- customize lsp formatting options
      formatting = {
         -- control auto formatting on save
         format_on_save = {
            ignore_filetypes = { -- disable format on save for specified filetypes
               "typescriptreact",
               "typescript",
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
