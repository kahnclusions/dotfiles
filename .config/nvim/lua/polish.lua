if true then
   return
end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add({
   extension = {
      foo = "fooscript",
   },
   filename = {
      ["Foofile"] = "fooscript",
   },
   pattern = {
      ["~/%.config/foo/.*"] = "fooscript",
   },
})

for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
   local default_diagnostic_handler = vim.lsp.handlers[method]
   vim.lsp.handlers[method] = function(err, result, context, config)
      if err ~= nil and err.code == -32802 then
         return
      end
      return default_diagnostic_handler(err, result, context, config)
   end
end

vim.api.nvim_create_autocmd("FileType", {
   pattern = "rust",
   callback = function(args)
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
})
