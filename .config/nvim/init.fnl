;; kickstart.fnl

;; Set the `vim` global for Fennel.
(local vim (. _G :vim))

;; Setup package manager and mini.nvim
(local path-package (.. (vim.fn.stdpath "data") "/site"))
(local mini-path (.. path-package "/pack/deps/start/mini.nvim"))
(local clone-cmd ["git" "clone" "--filter=blob:none" "https://github.com/echasnovski/mini.nvim" mini-path])

(if (not (vim.loop.fs_stat mini-path))
   (do
      (vim.cmd "echo \"Installing mini.nvim\" | redraw")
      (vim.fn.system clone-cmd)
      (vim.cmd "packadd mini.nvim | helptags ALL")
      (vim.cmd "echo \"Installed `mini.nvim`\" | redraw")))

((. (require :mini.deps) :setup) { :path { :package path-package }})


;; Mini.deps globals
(local add _G.MiniDeps.add)
(local now _G.MiniDeps.now)
(local later _G.MiniDeps.later)


;; nfnl - this converts fennel to lua for neovim
(add { :source "https://github.com/Olical/nfnl" })


;; Basic Neovim configuration, runs immediately
(now (fn [] 
   ; Leader key
   (set vim.g.mapleader " ")

   ; Enable line number column, and absolute/relative line numbers
   (set vim.o.number false)
   (set vim.o.relativenumber false)

   (set vim.o.laststatus 2)
   (set vim.o.list true)

   (set vim.o.autoindent true)
   (set vim.o.expandtab true)

   (set vim.o.scrolloff 10)

   (set vim.o.clipboard "unnamed,unnamedplus")

   (set vim.o.mouse "a")

   ; Ignore case in search unless explicitly provided
   (set vim.o.ignorecase true)
   (set vim.o.smartcase true)

   ; Always show the sign column
   (set vim.o.signcolumn "yes")

   ; Set shorter update times
   (set vim.o.updatetime 250)
   (set vim.o.timeoutlen 300)

   ; Smarter splits
   (set vim.o.splitright true)
   (set vim.o.splitbelow true)

   ; Display certain characters that are usually invisible
   (set vim.opt.listchars { :tab  "» " :trail  "·" :nbsp  "␣" })

   ; Set borders of floating windows
   (set vim.opt.winborder "single")

   ; Escape key clears search highlights
   (vim.keymap.set "n" "<Esc>" "<cmd>nohlsearch<CR>")))

;; Mini.basics
(later (fn []
    ((. (require :mini.basics) :setup) {
        :options {
            :basic true
            :extra_ui true
            :win_borders "bold"
        }
        :mappings {
            :basic true
            :windows true
        }
        :autocommands {
            :basic true
            :relnum_in_visual_mode true
        }
    })))


;; Default colour scheme - load now
(now (fn []
   (add { :source "rebelot/kanagawa.nvim" })
   (vim.cmd "colorscheme kanagawa")
   (add "f-person/auto-dark-mode.nvim")
   ((. (require :auto-dark-mode) :setup) {:update_interval 2000})))

;; Extra colour schemes - load later
(later (fn [] 
   (add { :source "zenbones-theme/zenbones.nvim" :depends ["rktjmp/lush.nvim"] })
   ))


;; Mini.nvim plugins
(later (fn [] (. (require :mini.bracketed)   :setup)))
(later (fn [] (. (require :mini.bufremove)   :setup)))
(later (fn [] (. (require :mini.colors)      :setup)))
(later (fn [] (. (require :mini.comment)     :setup)))
(later (fn [] (. (require :mini.icons)       :setup)))
(later (fn [] (. (require :mini.fuzzy)       :setup)))
(later (fn [] (. (require :mini.misc)        :setup)))
(later (fn [] (. (require :mini.surround)    :setup)))
(later (fn [] (. (require :mini.trailspace)  :setup)))
(later (fn [] (. (require :mini.extra)       :setup)))
(later (fn [] (. (require :mini.visits)      :setup)))


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
      (nts.setup {
               :ensure_installed ts-parsers
               :highlight { :enable true }
               })))))


(later (fn [] (let [hi (require :mini.hipatterns)]
   (hi.setup {
      :hex_color (hi.gen_highlighter.hex_color)
      }))))

(now (fn [] 
   (let [is (require :mini.indentscope)]
      (is.setup { 
         :draw { :delay 0 :animation (is.gen_animation.none) }
         :symbol "╎" }))))
;(later (fn [] (. (require :mini.cursorword)  :setup)))
; (now (fn [] 
;    (add { :source "https://github.com/saghen/blink.indent" })
;    ((. (require :blink.indent) :setup) {})))

;; Mini.clue (which-key style helper)
(now (fn []
   (local clue (require :mini.clue))
   (clue.setup {
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

      :clues [
          { :mode "n" :keys "<Leader>b" :desc " Buffer" }
          { :mode "n" :keys "<Leader>e" :desc " Explore" }
          { :mode "n" :keys "<Leader>f" :desc " Find" }
          { :mode "n" :keys "<Leader>g" :desc "󰊢 Git" }
          { :mode "n" :keys "<Leader>i" :desc "󰏪 Insert" }
          { :mode "n" :keys "<Leader>l" :desc "󰘦 LSP" }
          { :mode "n" :keys "<Leader>m" :desc " Mini" }
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

(later (fn []
    (. (require :mini.files) :setup) {
        :mappings {
            :close "<ESC>"
        }
        :windows {
            :preview true
            :border "rounded"
            :width_preview 80
        }
    }))

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
   ((. (require :aerial) :setup) {})
   (vim.keymap.set "n" "<leader>a" "<cmd>AerialToggle!<CR>" { :desc "Aerial toggle" })))


;; Diagnostics
(vim.diagnostic.config {
  :signs {
    :text {
      vim.diagnostic.severity.ERROR ""
      vim.diagnostic.severity.WARN ""
      vim.diagnostic.severity.INFO ""
      vim.diagnostic.severity.HINT ""
    }
  }
})


;; Completion
(later (fn []
   (add { :source "https://github.com/saghen/blink.cmp" })
   (let [blink-cmp (require :blink.cmp)]
      (blink-cmp.setup {
         :keymap { :preset "default" }
         :completion {
            :documentation { :auto_show false :auto_show_delay_ms 500 }
         }
         :sources {
            :default [ "lsp" "path" ]
         }
         :fuzzy { :implementation "lua" }
         :signature { :enabled true }
   }))))


; (now (fn [] 
;    (add { :source "nvim-lualine/lualine.nvim" })
;    ((. (require :lualine) :setup) { :options { :theme "kanso" } })
;    ))


;; Imports
(require :keybinds)
(require :status)
