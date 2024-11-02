-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
   "AstroNvim/astrocore",
   ---@type AstroCoreOpts
   opts = {
      git_worktrees = {
         {
            toplevel = vim.env.HOME,
            gitdir = vim.env.HOME .. "/.dotfiles",
         },
      },
      -- vim options can be configured here
      options = {
         opt = { -- vim.opt.<key>
            relativenumber = false, -- sets vim.opt.relativenumber
            number = false, -- sets vim.opt.number
            spell = false, -- sets vim.opt.spell
            -- signcolumn = "auto", -- sets vim.opt.signcolumn to auto
            wrap = true, -- sets vim.opt.wrap
            showtabline = 0,
            -- guicursor = "n-v-c-sm:block-Cursor,i-ci-ve:ver25,r-cr-o:hor20",
         },
         g = { -- vim.g.<key>
            -- configure global vim variables (vim.g)
            -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
            -- This can be found in the `lua/lazy_setup.lua` file
            ui_notifications_enabled = false,
         },
      },
      -- Mappings can be configured through AstroCore as well.
      -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
      mappings = {
         -- first key is the mode
         n = {
            -- second key is the lefthand side of the map
            ["<leader>fs"] = { ":w!<cr>", desc = "Save File" },

            -- navigate buffer tabs with `H` and `L`
            -- L = {
            --   function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
            --   desc = "Next buffer",
            -- },
            -- H = {
            --   function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
            --   desc = "Previous buffer",
            -- },

            -- mappings seen under group name "Buffer"
            ["<Leader>bD"] = {
               function()
                  require("astroui.status.heirline").buffer_picker(function(bufnr)
                     require("astrocore.buffer").close(bufnr)
                  end)
               end,
               desc = "Pick to close",
            },
            -- tables with just a `desc` key will be registered with which-key if it's installed
            -- this is useful for naming menus
            ["<Leader>b"] = { desc = "Buffers" },
            -- quick save
            -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
         },
         t = {
            -- setting a mapping to false will disable it
            -- ["<esc>"] = false,
         },
      },
   },
}
