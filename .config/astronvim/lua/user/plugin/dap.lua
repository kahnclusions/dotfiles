require("dap-vscode-js").setup({
   debugger_path = require("user.extra")["dap-vscode-js"].debugger_path,
   adapters = {
      "pwa-node",
      "pwa-chrome",
      "node-terminal",
      "pwa-extensionHost",
   },
})

for _, language in ipairs({ "typescriptreact", "typescript", "javascript" }) do
   require("dap").configurations[language] = {
      {
         type = "pwa-node",
         request = "launch",
         name = "Launch file",
         program = "${file}",
         cwd = "${workspaceFolder}",
      },
      {
         type = "pwa-node",
         request = "attach",
         name = "Attach",
         processId = require("dap.utils").pick_process,
         cwd = "${workspaceFolder}",
      },
   }
end
