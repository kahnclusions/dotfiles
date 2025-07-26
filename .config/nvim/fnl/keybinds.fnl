(local vim (. _G :vim)) 
(local map vim.keymap.set)

;; How to escape
(map "n" "<leader>q" "<cmd>wqa<cr>" { :desc "Quit" })

;; Finding files
(map "n" "<leader>ff" (fn [] (let [pick (require :mini.pick)] (pick.builtin.files))) { :desc "Find files" } )
(map "n" "<leader>f<enter>" (fn [] (let [pick (require :mini.pick)] (pick.builtin.resume))) { :desc "Resume" } )
(map "n" "<leader><space>" (fn [] (let [pick (require :mini.pick)] (pick.builtin.grep_live))) { :desc "Find String" } )
(map "n" "<leader>fb" (fn [] (let [pick (require :mini.pick)] (pick.builtin.buffers))) { :desc "Find Buffer" } )
(map "n" "<leader>fw" (fn [] (let [pick (require :mini.pick) word (vim.fn.expand "<cword>")] 
   (pick.builtin.grep { :pattern word }))) { :desc "Find Buffer" } )
(map "n" "," (fn [] (let [extra (require :mini.extra)] (extra.pickers.buf_lines { :scope "current" }))) { :desc "Find Lines" } )
(map "n" "<leader>fo" (fn [] (let [ex (require :mini.extra)] (ex.pickers.oldfiles { :current_dir true }))) { :desc "Old files" })

;; File Explorer
(map "n" "fe" (fn []
   (local buffer-name (vim.api.nvim_buf_get_name 0))
   (local mini-files (require :mini.files))
   (if (or (= buffer-name "") (string.match buffer-name "Starter"))
      (mini-files.open (vim.loop.cwd))
      (mini-files.open (vim.api.nvim_buf_get_name 0)))))

;; LSP
(map "n" "<leader>ld" (fn [] (vim.lsp.buf.definition)) { :desc "Go to definition" } )
(map "n" "<leader>lr" (fn [] (vim.lsp.buf.rename)) { :desc "Rename" } )
(map "n" "<leader>la" (fn [] (vim.lsp.buf.code_action)) { :desc "Code actions" } )
(map "n" "<leader>le" (fn [] (let [extra (require :mini.extra)] (extra.pickers.diagnostic { :scope "current" })) ) { :desc "LSP Errors" } )
(map "n" "gd" (fn [] (vim.lsp.buf.definition)) { :desc "Go to definition" } )
(map "n" "<leader>lh" (fn [] (vim.lsp.buf.signature_help)) { :desc "Signature help" })

(map "n" "grr" (fn [] (let [ex (require :mini.extra)] (ex.pickers.lsp { :scope "references" }))) { :desc "Go to references" })
(map "n" "gri" (fn [] (let [ex (require :mini.extra)] (ex.pickers.lsp { :scope "implementation" }))) { :desc "Go to implementations" })

(map "n" "<leader>fr" (fn [] (let [ex (require :mini.extra)] (ex.pickers.visit_paths))) { :desc "Visit paths" })

