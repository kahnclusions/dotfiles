-- [nfnl] init.fnl
local vim = _G.vim
local path_package = (vim.fn.stdpath("data") .. "/site")
local mini_path = (path_package .. "/pack/deps/start/mini.nvim")
local clone_cmd = {"git", "clone", "--filter=blob:none", "https://github.com/echasnovski/mini.nvim", mini_path}
if not vim.loop.fs_stat(mini_path) then
  vim.cmd("echo \"Installing mini.nvim\" | redraw")
  vim.fn.system(clone_cmd)
  vim.cmd("packadd mini.nvim | helptags ALL")
  vim.cmd("echo \"Installed `mini.nvim`\" | redraw")
else
end
require("mini.deps").setup({path = {package = path_package}})
local add = _G.MiniDeps.add
local now = _G.MiniDeps.now
local later = _G.MiniDeps.later
add({source = "https://github.com/Olical/nfnl"})
local function _2_()
  vim.g.mapleader = " "
  vim.o.number = false
  vim.o.relativenumber = false
  vim.o.laststatus = 2
  vim.o.list = true
  vim.o.autoindent = true
  vim.o.expandtab = true
  vim.o.scrolloff = 10
  vim.o.clipboard = "unnamed,unnamedplus"
  vim.o.mouse = "a"
  vim.o.ignorecase = true
  vim.o.smartcase = true
  vim.o.signcolumn = "yes"
  vim.o.updatetime = 250
  vim.o.timeoutlen = 300
  vim.o.splitright = true
  vim.o.splitbelow = true
  vim.opt.listchars = {tab = "\194\187 ", trail = "\194\183", nbsp = "\226\144\163"}
  vim.opt.winborder = "single"
  return vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
end
now(_2_)
local function _3_()
  return require("mini.basics").setup({options = {basic = true, extra_ui = true, win_borders = "bold"}, mappings = {basic = true, windows = true}, autocommands = {basic = true, relnum_in_visual_mode = true}})
end
later(_3_)
local function _4_()
  add({source = "rebelot/kanagawa.nvim"})
  vim.cmd("colorscheme kanagawa")
  add("f-person/auto-dark-mode.nvim")
  return require("auto-dark-mode").setup({update_interval = 2000})
end
now(_4_)
local function _5_()
  return add({source = "zenbones-theme/zenbones.nvim", depends = {"rktjmp/lush.nvim"}})
end
later(_5_)
local function _6_()
  return require("mini.bracketed").setup
end
later(_6_)
local function _7_()
  return require("mini.bufremove").setup
end
later(_7_)
local function _8_()
  return require("mini.colors").setup
end
later(_8_)
local function _9_()
  return require("mini.comment").setup
end
later(_9_)
local function _10_()
  return require("mini.icons").setup
end
later(_10_)
local function _11_()
  return require("mini.fuzzy").setup
end
later(_11_)
local function _12_()
  return require("mini.misc").setup
end
later(_12_)
local function _13_()
  return require("mini.surround").setup
end
later(_13_)
local function _14_()
  return require("mini.trailspace").setup
end
later(_14_)
local function _15_()
  return require("mini.extra").setup
end
later(_15_)
local function _16_()
  return require("mini.visits").setup
end
later(_16_)
local function _17_()
  add({source = "https://github.com/nvim-treesitter/nvim-treesitter", checkout = "master", monitor = "master"})
  local ts_parsers = {"bash", "dockerfile", "fennel", "fish", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "go", "gomod", "gosum", "html", "javascript", "json", "lua", "make", "markdown", "python", "rust", "sql", "toml", "tsx", "terraform", "typescript", "vim", "yaml"}
  local function _18_()
    local nts = require("nvim-treesitter.configs")
    return nts.setup({ensure_installed = ts_parsers, highlight = {enable = true}})
  end
  return now(_18_)
end
later(_17_)
local function _19_()
  local hi = require("mini.hipatterns")
  return hi.setup({hex_color = hi.gen_highlighter.hex_color()})
end
later(_19_)
local function _20_()
  local is = require("mini.indentscope")
  return is.setup({draw = {delay = 0, animation = is.gen_animation.none()}, symbol = "\226\149\142"})
end
now(_20_)
local function _21_()
  local clue = require("mini.clue")
  return clue.setup({triggers = {{mode = "n", keys = "<leader>"}, {mode = "x", keys = "<leader>"}, {mode = "n", keys = "\\"}, {mode = "i", keys = "<C-x>"}, {mode = "n", keys = "g"}, {mode = "x", keys = "g"}, {mode = "n", keys = "s"}, {mode = "n", keys = "'"}, {mode = "n", keys = "`"}, {mode = "x", keys = "'"}, {mode = "x", keys = "`"}, {mode = "n", keys = "\""}, {mode = "x", keys = "\""}, {mode = "i", keys = "<C-r>"}, {mode = "c", keys = "<C-r>"}, {mode = "n", keys = "<C-w>"}, {mode = "n", keys = "z"}, {mode = "x", keys = "z"}}, clues = {{mode = "n", keys = "<Leader>b", desc = "\239\139\146 Buffer"}, {mode = "n", keys = "<Leader>e", desc = "\239\128\130 Explore"}, {mode = "n", keys = "<Leader>f", desc = "\239\128\130 Find"}, {mode = "n", keys = "<Leader>g", desc = "\243\176\138\162 Git"}, {mode = "n", keys = "<Leader>i", desc = "\243\176\143\170 Insert"}, {mode = "n", keys = "<Leader>l", desc = "\243\176\152\166 LSP"}, {mode = "n", keys = "<Leader>m", desc = "\238\173\145 Mini"}, {mode = "n", keys = "<Leader>q", desc = "\239\141\175 NVim"}, {mode = "n", keys = "<Leader>s", desc = "\243\176\134\147 Session"}, {mode = "n", keys = "<Leader>s", desc = "\238\158\149 Terminal"}, {mode = "n", keys = "<Leader>u", desc = "\243\176\148\131 UI"}, {mode = "n", keys = "<Leader>w", desc = "\238\173\191 Window"}, clue.gen_clues.g(), clue.gen_clues.builtin_completion(), clue.gen_clues.marks(), clue.gen_clues.registers(), clue.gen_clues.windows(), clue.gen_clues.z()}, window = {delay = 300}})
end
now(_21_)
local function _22_()
  do local _ = require("mini.files").setup end
  return {mappings = {close = "<ESC>"}, windows = {preview = true, border = "rounded", width_preview = 80}}
end
later(_22_)
local function _23_()
  add({source = "https://github.com/neovim/nvim-lspconfig"})
  vim.lsp.enable("vtsls")
  vim.lsp.enable("fennel_ls")
  vim.lsp.enable("rust_analyzer")
  return vim.lsp.enable("lua_ls")
end
later(_23_)
local function _24_()
  add({source = "https://github.com/stevearc/aerial.nvim"})
  require("aerial").setup({})
  return vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", {desc = "Aerial toggle"})
end
later(_24_)
vim.diagnostic.config({signs = {text = {[vim.diagnostic.severity.ERROR] = "\238\170\135", [vim.diagnostic.severity.WARN] = "\238\169\172", [vim.diagnostic.severity.INFO] = "\238\169\180", [vim.diagnostic.severity.HINT] = "\238\172\166"}}})
local function _25_()
  add({source = "https://github.com/saghen/blink.cmp"})
  local blink_cmp = require("blink.cmp")
  return blink_cmp.setup({keymap = {preset = "default"}, completion = {documentation = {auto_show_delay_ms = 500, auto_show = false}}, sources = {default = {"lsp", "path"}}, fuzzy = {implementation = "lua"}, signature = {enabled = true}})
end
later(_25_)
require("keybinds")
return require("status")
