;; init.fnl
;;
;; Easy to use neovim config in a single Fennel file
;;
;; This is a pretty good example of how to configure Neovim
;; without using overly complex distributions. I've tried to
;; document what's going on as much as possible.
;;
;; This config provides most of the things one comes to expect
;; from a code editor, like auto-complete, do to definition,
;; hover documentation, bookmarks, fuzzy finder, etc.
;;
;; If you aren't familiar with Fennel, you can look in the
;; [fennel reference](https://fennel-lang.org/reference) for help.
;;
;; "These are your father's parentheses. Elegant weapons for a more... civilized age."


;; Set the `vim` global.
(local vim _G.vim)

;; Setup package manager and mini.nvim.
;; NOTE: If you don't want to bring in all of mini.nvim, you could instead clone `mini.deps`.
(local path-package (.. (vim.fn.stdpath "data") "/site"))
(local mini-path (.. path-package "/pack/deps/start/mini.nvim"))
(local clone-cmd ["git" "clone" "--filter=blob:none" "https://github.com/echasnovski/mini.nvim" mini-path])

(if (not (vim.loop.fs_stat mini-path))
   (do
      (vim.cmd "echo \"Installing mini.nvim\" | redraw")
      (vim.fn.system clone-cmd)
      (vim.cmd "packadd mini.nvim | helptags ALL")
      (vim.cmd "echo \"Installed `mini.nvim`\" | redraw")))

;; This is the part that actually sets up the package manager.
(let [deps (require :mini.deps)]
  (deps.setup { :path { :package path-package }}))


;; Mini.deps globals
(local add _G.MiniDeps.add) ; adds a package
(local now _G.MiniDeps.now) ; runs a function "now", for packages needed by the first render. Errors
                            ; are collected and displayed together with vim.notify.
(local later _G.MiniDeps.later) ; runs a function "later" on the next event loop, allowing packages
                                ; to be loaded asynchronously without blocking Neovim from starting.


;; Basic Neovim configuration
(now (fn []
   ; Wrap long lines
   (set vim.o.wrap true)

   ; I don't like line numbers being visible, so I disable them completely.
   (set vim.o.number false)

   ; Display certain (undesirable) characters that are usually invisible.
   (set vim.o.list true)
   (set vim.opt.listchars { :tab  "» " :trail  "·" :nbsp  "␣" })

   ; Auto-indent after pressing enter, and expand tab into spaces.
   (set vim.o.autoindent true)
   (set vim.o.expandtab true)

   ; Minimum number of screen lines to keep above and below the cursor.
   (set vim.o.scrolloff 10)

   ; Always use the clipboard instead of the + and * registers.
   (set vim.o.clipboard "unnamed,unnamedplus")

   ; Set shorter (faster) update times
   (set vim.o.updatetime 250)
   (set vim.o.timeoutlen 300)

   ; Set borders of floating windows
   (set vim.opt.winborder "single")

   ; Escape key clears search highlights
   (vim.keymap.set "n" "<Esc>" "<cmd>nohlsearch<CR>")

   ; `mini.basics` contains sensible default configs for a nice "out of the box"
   ; experience in neovim.
   ((. (require :mini.basics) :setup) {
        :options {
            ; Leader key and other common neovim configs are set here
            ; https://github.com/echasnovski/mini.basics/main/lua/mini/basics.lua#L431-L480
            :basic true

            ; Slight transparency for floating windows and other UI tweaks
            :extra_ui true

            ; Borders between nvim windows (aka panes), not floating.
            :win_borders "bold"
        }
        :mappings {
            :basic true
            :windows true
        }
        :autocommands {
            :basic true ; briefly highlight yanked text after yanking
            :relnum_in_visual_mode false ; show relative numbers in visual mode
        }
    })))


; Notifications
; Load this `now` so that other errors in config will be shown with mini.notify.
(now (fn []
   (let [mini-notify (require :mini.notify)]
      ; Don't show lsp progress in mini.notify, we'll use Fidget later
      (mini-notify.setup { :lsp_progress { :enable false }})
      ; Override `vim.notify` to send all notifications to Mini
      (set vim.notify (mini-notify.make_notify)))))


; Themes / colour scheme
; Load our main theme "now"
(now (fn []
   (add { :source "rebelot/kanagawa.nvim" })

   (local kanagawa (require :kanagawa))
   (kanagawa.setup {
      :overrides (lambda [colors] {
         :FlashLabel { :fg colors.theme.ui.bg :bg colors.theme.vcs.added }
      })
   })
   (vim.cmd "colorscheme kanagawa")

   (add "f-person/auto-dark-mode.nvim")
   ((. (require :auto-dark-mode) :setup) {:update_interval 2000})))


;; Mini.nvim plugins
(later (fn [] ((. (require :mini.ai)          :setup)))) ; Better around/inside text objects
(later (fn [] ((. (require :mini.bracketed)   :setup)))) ; Movement using ][
(later (fn [] ((. (require :mini.bufremove)   :setup)))) ; Remove buffers after a while
(later (fn [] ((. (require :mini.comment)     :setup)))) ;
(later (fn [] ((. (require :mini.icons)       :setup)))) ; Various icons
(later (fn [] ((. (require :mini.fuzzy)       :setup)))) ; Fuzzy search
(later (fn [] ((. (require :mini.misc)        :setup)))) ; Miscellanous configuration
(later (fn [] ((. (require :mini.surround)    :setup)))) ; vim-surround alternative
(later (fn [] ((. (require :mini.extra)       :setup)))) ; Extras
(later (fn [] ((. (require :mini.visits)      :setup)))) ; Frecency tracking
(later (fn [] ((. (require :mini.diff)        :setup)))) ; Diff viewer
(later (fn []
   (set vim.g.minitrailspace_disable true)
   ((. (require :mini.trailspace)  :setup))))


; Picker (alternative to Telescope)
(later (fn [] (let [pick (require :mini.pick)]
   (pick.setup)
   (set vim.ui.select pick.ui_select)
   )))


; Fidget notifier for lsp_progress messages
(later (fn []
   (add { :source "j-hui/fidget.nvim" })
   (local fidget (require :fidget))
   (fidget.setup)))


; mini-move - Move selections around
(later (fn []
   (let [move (require :mini.move)]
      move.setup {
         :mappings {
            :left   "<S-left>"
            :right  "<S-right>"
            :down   "<S-down>"
            :up     "<S-up>"

            :line_left   "<S-left>"
            :line_right  "<S-right>"
            :line_down   "<S-down>"
            :line_up     "<S-up>"
         }
      })))


;; Tree-sitter
(later (fn []
   (add { :source "https://github.com/nvim-treesitter/nvim-treesitter"
         :checkout "master"
         :monitor "master" })
   (local ts-parsers [
      "bash"
      "dockerfile"
      "fennel"
      "fish"
      "git_config"
      "git_rebase"
      "gitattributes"
      "gitcommit"
      "gitignore"
      "go"
      "gomod"
      "gosum"
      "html"
      "javascript"
      "json"
      "lua"
      "make"
      "markdown"
      "python"
      "rust"
      "sql"
      "toml"
      "tsx"
      "terraform"
      "typescript"
      "vim"
      "yaml"
   ])
   (now (fn []
      (local nts (require :nvim-treesitter.configs))
      (nts.setup { :ensure_installed ts-parsers
                   :highlight { :enable true }})))))


(later (fn [] (let [hi (require :mini.hipatterns)]
   (hi.setup { :hex_color (hi.gen_highlighter.hex_color) }))))


(now (fn []
   (let [is (require :mini.indentscope)]
      (is.setup {
         :draw { :delay 0 :animation (is.gen_animation.none) }
         :symbol "╎" }))))


(later (fn []
    ((. (require :mini.files) :setup) {
        :mappings {
            :close "<ESC>"
        }
        :windows {
            :preview true
            :border "rounded"
            :width_preview 80
        }
    })))

; LSP Config
(later (fn []
   (add { :source "https://github.com/neovim/nvim-lspconfig" })
        (vim.lsp.enable "vtsls")
        (vim.lsp.enable "fennel_ls")
        (vim.lsp.enable "rust_analyzer")
        (vim.lsp.enable "lua_ls")))


; Aerial
(later (fn []
   (add { :source "https://github.com/stevearc/aerial.nvim" })
   ((. (require :aerial) :setup))
   (vim.keymap.set "n" "<leader>a" "<cmd>AerialToggle!<CR>" { :desc "Aerial toggle" })))


;; Diagnostics
(vim.diagnostic.config {
   :severity_sort true
   :float { :border "rounded" :source "if_many" }
   :underline { :severity vim.diagnostic.severity.ERROR }
   :signs {
      :text {
         vim.diagnostic.severity.ERROR ""
         vim.diagnostic.severity.WARN ""
         vim.diagnostic.severity.INFO ""
         vim.diagnostic.severity.HINT ""
      }
   }
   :virtual_text {
      :source "if_many"
      :spacing 2
      :format (lambda [diagnostic]
        (let [diagnostic_message {
          [vim.diagnostic.severity.ERROR] diagnostic.message
          [vim.diagnostic.severity.WARN] diagnostic.message
          [vim.diagnostic.severity.INFO] diagnostic.message
          [vim.diagnostic.severity.HINT] diagnostic.message
        }]
        (. diagnostic_message diagnostic.severity)
      ))
   }
})


;; Completion using blink.cmp
(later (fn []
   (add { :source "saghen/blink.cmp" :checkout "v1.6.0" })
   (let [blink-cmp (require :blink.cmp)]
      (blink-cmp.setup {
         :keymap { 
            :preset "default"
            :<Tab> ["select_and_accept" "fallback_to_mappings"]
         }
         :completion {
            :documentation { :auto_show false :auto_show_delay_ms 500 }
         }
         :sources {
            :default [ "lsp" "path" ]
         }
         :fuzzy { :implementation "prefer_rust" }
         :signature { :enabled true }
   }))))


;; Highlight when yanking text
(vim.api.nvim_create_autocmd "TextYankPost" {
  :desc "Highlight when yanking (copying) text"
  :group (vim.api.nvim_create_augroup "kickstart-highlight-yank" { :clear true })
  :callback (lambda [] (vim.hl.on_yank { :timeout 500 } ))
})


;; Statusline
(now (fn []
   (let [statusline (require :mini.statusline)]
      (statusline.setup {
        :content {
            :active (fn []
               (local MiniStatusline (. _G :MiniStatusline))
               (let [(mode mode-hl) (MiniStatusline.section_mode { :trunc_width 120 })
                     diff          (MiniStatusline.section_diff { :trunc_width 75 })
                     diagnostics   (MiniStatusline.section_diagnostics { :trunc_width 75 })
                     lsp           (MiniStatusline.section_lsp { :trunc_width 75 })
                     git           (MiniStatusline.section_git { :trunc_width 40 })
                     filename      (MiniStatusline.section_filename { :trunc_width 140 })
                     fileinfo      (MiniStatusline.section_fileinfo { :trunc_width 120 })
                     search        (MiniStatusline.section_searchcount { :trunc_width 75 })
                     location      (MiniStatusline.section_location { :trunc_width  1000 })
                ]

                (MiniStatusline.combine_groups [
                    { :hl mode-hl                 :strings [ mode ] }
                    { :hl "MiniStatuslineDevinfo" :strings [ git diff diagnostics lsp ]}
                    "%<"
                    { :hl "MiniStatuslineFilename" :strings [ filename ] }
                    "%="
                    { :hl "MiniStatuslineFileinfo" :strings [ fileinfo ] }
                    { :hl mode-hl                  :strings [ search location ] }
                ])))
            :inactive nil
        }})
      (set statusline.section_location (fn [] "%2l:%-2v")))))


;; Helper function to start mini.pick with marks
(lambda pick-marks [name pattern]
      (let [pick (require :mini.pick)
            marks (vim.fn.getmarklist)
            local-marks (vim.fn.getmarklist (vim.api.nvim_buf_get_name 0))
            all-marks (vim.fn.extend marks local-marks)
            cwd (vim.fn.getcwd)
            items (icollect [_ v (ipairs all-marks)] 
               (let [file-raw (if (= nil v.file) (vim.api.nvim_buf_get_name 0) v.file)
                     file (vim.fn.expand file-raw)]
               (if (and (vim.startswith file cwd) (v.mark:match pattern))
                  { :text (.. (v.mark:gsub "'" "") "│" (. v.pos 2) "│" (file:sub (+ 2 (cwd:len))))
                    :path (vim.fn.expand file) 
                    :lnum (. v.pos 2) }
                  nil))
            )
            height (if (> (length items) 30) 40 30)
            ]
         (pick.start { :source { :name name :items items } :window { :config { :height height }} }))
     )


;; Mini.clue (which-key style helper)
(later (fn []
   (local clue (require :mini.clue))
   (clue.setup {
      ; When to show the helper window
      :triggers [
         ; Leader triggers
         { :mode "n" :keys "<leader>" }
         { :mode "x" :keys "<leader>" }

         { :mode "n" :keys "\\" }

         ; Built-in completion
         { :mode "i" :keys "<C-x>" }

         ; `g` key
         { :mode "n" :keys "g" }
         { :mode "x" :keys "g" }

         ; Surround
         { :mode "n" :keys "s" }

         ; Marks
         { :mode "n" :keys "'" }
         { :mode "n" :keys "`" }
         { :mode "x" :keys "'" }
         { :mode "x" :keys "`" }

         { :mode "n" :keys "m" }
         { :mode "x" :keys "m" }

         ; Registers
         { :mode "n" :keys "\"" }
         { :mode "x" :keys "\"" }
         { :mode "i" :keys "<C-r>" }
         { :mode "c" :keys "<C-r>" }

         ; Window commands
         { :mode "n" :keys "<C-w>" }

         ; `z` key
         { :mode "n" :keys "z" }
         { :mode "x" :keys "z" }
      ]
      ; Content to show in the helper window
      :clues [
          { :mode "n" :keys "<Leader>b" :desc " Buffer" }
          { :mode "n" :keys "<Leader>e" :desc " Explore" }
          { :mode "n" :keys "<Leader>f" :desc " Find" }
          { :mode "n" :keys "<Leader>g" :desc "󰊢 Git" }
          { :mode "n" :keys "<Leader>i" :desc "󰏪 Insert" }
          { :mode "n" :keys "<Leader>l" :desc "󰘦 LSP" }
          { :mode "n" :keys "<Leader>m" :desc "󰸕 Marks" }
          { :mode "n" :keys "<Leader>n" :desc "󰎟 Notify" }
          { :mode "n" :keys "<Leader>q" :desc " NVim" }
          { :mode "n" :keys "<Leader>s" :desc "󰆓 Session" }
          { :mode "n" :keys "<Leader>s" :desc " Terminal" }
          { :mode "n" :keys "<Leader>u" :desc "󰔃 UI" }
          { :mode "n" :keys "<Leader>w" :desc " Window" }
          (clue.gen_clues.g)
          (clue.gen_clues.builtin_completion)
          (clue.gen_clues.marks)
          (clue.gen_clues.registers)
          (clue.gen_clues.windows)
          (clue.gen_clues.z)
      ]
      :window {
          :delay 300
      }
   })))


;; Neogit
(later (fn [] 
   (add { :source "NeogitOrg/neogit" :depends ["nvim-lua/plenary.nvim"] })
   (local neogit (require :neogit))
   (neogit.setup)
   ))


(later (fn []
   (add { :source "chentoast/marks.nvim" })
   (local marks (require :marks))
   (marks.setup)
   ))


;; flash.nvim - jump to anywhere
(later (fn []
   (add { :source "folke/flash.nvim" })
   (let [map vim.keymap.set 
         flash (require :flash)]
      (flash.setup)

      ; Find anything
      (map ["n" "x" "o" "v"] "f" (fn [] (let [flash (require :flash)] (flash.jump))) { :desc "Flash jump" })
      (map ["i"] "<c-f>" (fn [] (let [flash (require :flash)] (flash.jump))) { :desc "Flash jump" })
      (map ["n" "x" "o" "v"] "F" (fn [] (let [flash (require :flash)] (flash.treesitter))) { :desc "Flash treesitter jump" })
      (map "c" "<c-s>" (fn [] (let [flash (require :flash)] (flash.toggle))) { :desc "Flash toggle" })

      (map ["n" "x" "o"] "<leader>jc" (fn [] (let [flash (require :flash)] (flash.jump { :continue true }))) { :desc "Continue jump" })

      ; Jump to line
      (map ["n" "x" "o"] "<leader>jl" (fn [] (let [flash (require :flash)] (flash.jump {
         :search { :mode "search" :max_length 0 }
         :label { :after [0 0] }
         :pattern "^"
      }))) { :desc "Jump to line" })

      ; Start saerch with current word under cursor
      (map ["n" "x" "o"] "<leader>jw" (fn [] (let [flash (require :flash)] (flash.jump {
         :pattern (vim.fn.expand "<cword>")
      }))) { :desc "Jump to current word" })

      ; Show vim diagnostics at jump destination (doesn't jump)
      (map ["n"] "<leader>jd" (fn [] 
         (let [flash (require :flash)] 
            (flash.jump {
               :action (lambda [matched state]
                  (vim.api.nvim_win_call matched.win (fn []
                     (vim.api.nvim_win_set_cursor matched.win matched.pos)
                     (vim.diagnostic.open_float)))
                  (state:restore))
            }))
      ) { :desc "Show diagnostics at location" }))))


;; Keybindings
(later (fn []
   (local map vim.keymap.set)

   ;; How to escape
   (map "n" "<leader>q" "<cmd>wqa<cr>" { :desc "Quit" })

   ;; Windows
   (map "n" "<leader>wv" "<C-w>v<cr>" { :desc "Split window vertically" })
   (map "n" "<leader>ws" "<C-w>s<cr>" { :desc "Split window horizontally" })
   (map "n" "<leader>wc" "<C-w>c<cr>" { :desc "Close window" })

   ;; Finding files
   (map "n" "<leader>ff" (fn [] (let [pick (require :mini.pick)] (pick.builtin.files))) { :desc "Find files" })
   (map "n" "<leader>f<enter>" (fn [] (let [pick (require :mini.pick)] (pick.builtin.resume))) { :desc "Resume" })
   (map "n" "<leader><space>" (fn [] (let [pick (require :mini.pick)] (pick.builtin.grep_live))) { :desc "Find String" })
   (map "n" "<leader>fb" (fn [] (let [pick (require :mini.pick)] (pick.builtin.buffers))) { :desc "Find Buffer" })
   (map "n" "<leader>fw" (fn [] (let [pick (require :mini.pick) word (vim.fn.expand "<cword>")]
      (pick.builtin.grep { :pattern word }))) { :desc "Find Buffer" })
   (map "n" "," (fn [] (let [extra (require :mini.extra)] (extra.pickers.buf_lines { :scope "current" }))) { :desc "Find Lines" })
   (map "n" "<leader>fo" (fn [] (let [ex (require :mini.extra)] (ex.pickers.oldfiles { :current_dir true }))) { :desc "Old files" })

   (map "n" "<leader>fs" "<cmd>w<cr>" { :desc "Write buffer (save)" })

   (fn files-open-current []
      (local buffer-name (vim.api.nvim_buf_get_name 0))
      (local mini-files (require :mini.files))
      (if (or (= buffer-name "") (string.match buffer-name "Starter"))
         (mini-files.open (vim.loop.cwd))
         (mini-files.open (vim.api.nvim_buf_get_name 0))))

   ;; File Explorer
   (map "n" "<leader>f." files-open-current { :desc "Explore files at current" })
   (map "n" "<leader>fe" (fn [] ((. (require :mini.files) :open))) { :desc "Explore files" })

   ; Pick marks (global + local)
   (map "n" "<leader>mm" (fn []
      (pick-marks "User marks" "[A-Za-z]")) { :desc "All user marks" })
   (map "n" "<leader>mg" (fn []
      (pick-marks "Global marks" "[A-Z]")) { :desc "Global marks" })
   (map "n" "<leader>ml" (fn []
      (pick-marks "Local marks" "[a-z]")) { :desc "Local user marks" })
   (map "n" "<leader>mM" (fn []
      (pick-marks "Marks" ".")) { :desc "All marks" })
   (map "n" "<leader>ma" (fn []
      (pick-marks "Marks" ".")) { :desc "All marks" })

   ;; LSP
   (map "n" "<leader>ld" (fn [] (vim.lsp.buf.definition)) { :desc "Go to definition" } )
   (map "n" "<leader>lr" (fn [] (vim.lsp.buf.rename)) { :desc "Rename" } )
   (map "n" "<leader>la" (fn [] (vim.lsp.buf.code_action)) { :desc "Code actions" } )
   (map "n" "<leader>le" (fn [] (let [extra (require :mini.extra)] (extra.pickers.diagnostic { :scope "current" })) ) { :desc "LSP Errors" } )
   (map "n" "gd" (fn [] (vim.lsp.buf.definition)) { :desc "Go to definition" } )
   (map "n" "<leader>lh" (fn [] (vim.lsp.buf.signature_help)) { :desc "Signature help" })

   ; LSP Go-to Pickers
   (map "n" "grr" (fn [] (let [ex (require :mini.extra)] (ex.pickers.lsp { :scope "references" }))) { :desc "Go to references" })
   (map "n" "gri" (fn [] (let [ex (require :mini.extra)] (ex.pickers.lsp { :scope "implementation" }))) { :desc "Go to implementations" })

   ; Shift lines and selections
   (map "n" "sk" (fn [] (let [move (require :mini.move)] (move.move_line "up"))) { :desc "Move line up" })
   (map "n" "sj" (fn [] (let [move (require :mini.move)] (move.move_line "down"))) { :desc "Move line down" })
   (map "n" "sh" (fn [] (let [move (require :mini.move)] (move.move_line "left"))) { :desc "Move line up" })
   (map "n" "sl" (fn [] (let [move (require :mini.move)] (move.move_line "right"))) { :desc "Move line down" })
   (map "v" "sk" (fn [] (let [move (require :mini.move)] (move.move_selection "up"))) { :desc "Move selection up" })
   (map "v" "sj" (fn [] (let [move (require :mini.move)] (move.move_selection "down"))) { :desc "Move selection down" })
   (map "v" "sh" (fn [] (let [move (require :mini.move)] (move.move_selection "left"))) { :desc "Move selection left" })
   (map "v" "sl" (fn [] (let [move (require :mini.move)] (move.move_selection "right"))) { :desc "Move selection left" })

   ;; Diagnostics
   (map "n" "<leader>dd" (fn [] (vim.diagnostic.open_float)) { :desc "Open diagnostic float" })

   ;; Neogit
   (map "n" "<leader>gg" (fn [] (let [neogit (require :neogit)] (neogit.open { :kind "floating" }))) { :desc "Neo(g)it" })

   ;; Notifications
   (map "n" "<leader>nc" (fn [] (let [notify (require :mini.notify)] (notify.clear))) { :desc "Notify Clear" })
   (map "n" "<leader>nh" (fn [] (let [notify (require :mini.notify)] (notify.show_history))) { :desc "Notify History" })

   ;; I'm not sure what this does?
   (map "n" "<leader>fr" (fn [] (let [ex (require :mini.extra)] (ex.pickers.visit_paths))) { :desc "Visit paths" })))


;; nfnl - this converts Fennel to Lua when saving this file.
(later (fn [] (add { :source "https://github.com/Olical/nfnl" })))
