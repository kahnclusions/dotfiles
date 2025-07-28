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
  return require("mini.ai").setup
end
later(_6_)
local function _7_()
  return require("mini.bracketed").setup
end
later(_7_)
local function _8_()
  return require("mini.bufremove").setup
end
later(_8_)
local function _9_()
  return require("mini.colors").setup
end
later(_9_)
local function _10_()
  return require("mini.comment").setup
end
later(_10_)
local function _11_()
  return require("mini.icons").setup
end
later(_11_)
local function _12_()
  return require("mini.fuzzy").setup
end
later(_12_)
local function _13_()
  return require("mini.misc").setup
end
later(_13_)
local function _14_()
  return require("mini.surround").setup
end
later(_14_)
local function _15_()
  return require("mini.trailspace").setup
end
later(_15_)
local function _16_()
  return require("mini.extra").setup
end
later(_16_)
local function _17_()
  return require("mini.visits").setup
end
later(_17_)
local function _18_()
  return require("mini.diff").setup
end
later(_18_)
local function _19_()
  add({source = "https://github.com/nvim-treesitter/nvim-treesitter", checkout = "master", monitor = "master"})
  local ts_parsers = {"bash", "dockerfile", "fennel", "fish", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "go", "gomod", "gosum", "html", "javascript", "json", "lua", "make", "markdown", "python", "rust", "sql", "toml", "tsx", "terraform", "typescript", "vim", "yaml"}
  local function _20_()
    local nts = require("nvim-treesitter.configs")
    return nts.setup({ensure_installed = ts_parsers, highlight = {enable = true}})
  end
  return now(_20_)
end
later(_19_)
local function _21_()
  local hi = require("mini.hipatterns")
  return hi.setup({hex_color = hi.gen_highlighter.hex_color()})
end
later(_21_)
local function _22_()
  local is = require("mini.indentscope")
  return is.setup({draw = {delay = 0, animation = is.gen_animation.none()}, symbol = "\226\149\142"})
end
now(_22_)
local function _23_()
  local clue = require("mini.clue")
  return clue.setup({triggers = {{mode = "n", keys = "<leader>"}, {mode = "x", keys = "<leader>"}, {mode = "n", keys = "\\"}, {mode = "i", keys = "<C-x>"}, {mode = "n", keys = "g"}, {mode = "x", keys = "g"}, {mode = "n", keys = "s"}, {mode = "n", keys = "'"}, {mode = "n", keys = "`"}, {mode = "x", keys = "'"}, {mode = "x", keys = "`"}, {mode = "n", keys = "\""}, {mode = "x", keys = "\""}, {mode = "i", keys = "<C-r>"}, {mode = "c", keys = "<C-r>"}, {mode = "n", keys = "<C-w>"}, {mode = "n", keys = "z"}, {mode = "x", keys = "z"}}, clues = {{mode = "n", keys = "<Leader>b", desc = "\239\139\146 Buffer"}, {mode = "n", keys = "<Leader>e", desc = "\239\128\130 Explore"}, {mode = "n", keys = "<Leader>f", desc = "\239\128\130 Find"}, {mode = "n", keys = "<Leader>g", desc = "\243\176\138\162 Git"}, {mode = "n", keys = "<Leader>i", desc = "\243\176\143\170 Insert"}, {mode = "n", keys = "<Leader>l", desc = "\243\176\152\166 LSP"}, {mode = "n", keys = "<Leader>m", desc = "\238\173\145 Mini"}, {mode = "n", keys = "<Leader>q", desc = "\239\141\175 NVim"}, {mode = "n", keys = "<Leader>s", desc = "\243\176\134\147 Session"}, {mode = "n", keys = "<Leader>s", desc = "\238\158\149 Terminal"}, {mode = "n", keys = "<Leader>u", desc = "\243\176\148\131 UI"}, {mode = "n", keys = "<Leader>w", desc = "\238\173\191 Window"}, clue.gen_clues.g(), clue.gen_clues.builtin_completion(), clue.gen_clues.marks(), clue.gen_clues.registers(), clue.gen_clues.windows(), clue.gen_clues.z()}, window = {delay = 300}})
end
now(_23_)
local function _24_()
  do local _ = require("mini.files").setup end
  return {mappings = {close = "<ESC>"}, windows = {preview = true, border = "rounded", width_preview = 80}}
end
later(_24_)
local function _25_()
  add({source = "https://github.com/neovim/nvim-lspconfig"})
  vim.lsp.enable("vtsls")
  vim.lsp.enable("fennel_ls")
  vim.lsp.enable("rust_analyzer")
  return vim.lsp.enable("lua_ls")
end
later(_25_)
local function _26_()
  add({source = "https://github.com/stevearc/aerial.nvim"})
  require("aerial").setup({})
  return vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", {desc = "Aerial toggle"})
end
later(_26_)
local function _27_(diagnostic)
  _G.assert((nil ~= diagnostic), "Missing argument diagnostic on /Users/ck/.config/nvim/init.fnl:293")
  local diagnostic_message = {[{vim.diagnostic.severity.ERROR}] = diagnostic.message, [{vim.diagnostic.severity.WARN}] = diagnostic.message, [{vim.diagnostic.severity.INFO}] = diagnostic.message, [{vim.diagnostic.severity.HINT}] = diagnostic.message}
  return diagnostic_message[diagnostic.severity]
end
vim.diagnostic.config({severity_sort = true, float = {border = "rounded", source = "if_many"}, underline = {severity = vim.diagnostic.severity.ERROR}, signs = {text = {[vim.diagnostic.severity.ERROR] = "\238\170\135", [vim.diagnostic.severity.WARN] = "\238\169\172", [vim.diagnostic.severity.INFO] = "\238\169\180", [vim.diagnostic.severity.HINT] = "\238\172\166"}}, virtual_text = {source = "if_many", spacing = 2, format = _27_}})
local function _28_()
  add({source = "https://github.com/saghen/blink.cmp"})
  local blink_cmp = require("blink.cmp")
  return blink_cmp.setup({keymap = {preset = "default"}, completion = {documentation = {auto_show_delay_ms = 500, auto_show = false}}, sources = {default = {"lsp", "path"}}, fuzzy = {implementation = "lua"}, signature = {enabled = true}})
end
later(_28_)
local function _29_()
  return vim.hl.on_yank({timeout = 500})
end
vim.api.nvim_create_autocmd("TextYankPost", {desc = "Highlight when yanking (copying) text", group = vim.api.nvim_create_augroup("kickstart-highlight-yank", {clear = true}), callback = _29_})
local function _30_()
  local statusline = require("mini.statusline")
  local function _31_()
    local MiniStatusline = _G.MiniStatusline
    local mode, mode_hl = MiniStatusline.section_mode({trunc_width = 120})
    local diff = MiniStatusline.section_diff({trunc_width = 75})
    local diagnostics = MiniStatusline.section_diagnostics({trunc_width = 75})
    local lsp = MiniStatusline.section_lsp({trunc_width = 75})
    local git = MiniStatusline.section_git({trunc_width = 40})
    local filename = MiniStatusline.section_filename({trunc_width = 140})
    local fileinfo = MiniStatusline.section_fileinfo({trunc_width = 120})
    local search = MiniStatusline.section_searchcount({trunc_width = 75})
    local location = MiniStatusline.section_location({trunc_width = 1000})
    return MiniStatusline.combine_groups({{hl = mode_hl, strings = {mode}}, {hl = "MiniStatuslineDevinfo", strings = {git, diff, diagnostics, lsp}}, "%<", {hl = "MiniStatuslineFilename", strings = {filename}}, "%=", {hl = "MiniStatuslineFileinfo", strings = {fileinfo}}, {hl = mode_hl, strings = {search, location}}})
  end
  statusline.setup({content = {active = _31_, inactive = nil}})
  local function _32_()
    return "%2l:%-2v"
  end
  statusline.section_location = _32_
  return nil
end
now(_30_)
local function _33_()
  local map = vim.keymap.set
  map("n", "<leader>q", "<cmd>wqa<cr>", {desc = "Quit"})
  local function _34_()
    local pick = require("mini.pick")
    return pick.builtin.files()
  end
  map("n", "<leader>ff", _34_, {desc = "Find files"})
  local function _35_()
    local pick = require("mini.pick")
    return pick.builtin.resume()
  end
  map("n", "<leader>f<enter>", _35_, {desc = "Resume"})
  local function _36_()
    local pick = require("mini.pick")
    return pick.builtin.grep_live()
  end
  map("n", "<leader><space>", _36_, {desc = "Find String"})
  local function _37_()
    local pick = require("mini.pick")
    return pick.builtin.buffers()
  end
  map("n", "<leader>fb", _37_, {desc = "Find Buffer"})
  local function _38_()
    local pick = require("mini.pick")
    local word = vim.fn.expand("<cword>")
    return pick.builtin.grep({pattern = word})
  end
  map("n", "<leader>fw", _38_, {desc = "Find Buffer"})
  local function _39_()
    local extra = require("mini.extra")
    return extra.pickers.buf_lines({scope = "current"})
  end
  map("n", ",", _39_, {desc = "Find Lines"})
  local function _40_()
    local ex = require("mini.extra")
    return ex.pickers.oldfiles({current_dir = true})
  end
  map("n", "<leader>fo", _40_, {desc = "Old files"})
  local function _41_()
    local buffer_name = vim.api.nvim_buf_get_name(0)
    local mini_files = require("mini.files")
    if ((buffer_name == "") or string.match(buffer_name, "Starter")) then
      return mini_files.open(vim.loop.cwd())
    else
      return mini_files.open(vim.api.nvim_buf_get_name(0))
    end
  end
  map("n", "fc", _41_)
  local function _43_()
    local mini_files = require("mini.files")
    return mini_files.open()
  end
  map("n", "fe", _43_)
  local function _44_()
    return vim.lsp.buf.definition()
  end
  map("n", "<leader>ld", _44_, {desc = "Go to definition"})
  local function _45_()
    return vim.lsp.buf.rename()
  end
  map("n", "<leader>lr", _45_, {desc = "Rename"})
  local function _46_()
    return vim.lsp.buf.code_action()
  end
  map("n", "<leader>la", _46_, {desc = "Code actions"})
  local function _47_()
    local extra = require("mini.extra")
    return extra.pickers.diagnostic({scope = "current"})
  end
  map("n", "<leader>le", _47_, {desc = "LSP Errors"})
  local function _48_()
    return vim.lsp.buf.definition()
  end
  map("n", "gd", _48_, {desc = "Go to definition"})
  local function _49_()
    return vim.lsp.buf.signature_help()
  end
  map("n", "<leader>lh", _49_, {desc = "Signature help"})
  local function _50_()
    local ex = require("mini.extra")
    return ex.pickers.lsp({scope = "references"})
  end
  map("n", "grr", _50_, {desc = "Go to references"})
  local function _51_()
    local ex = require("mini.extra")
    return ex.pickers.lsp({scope = "implementation"})
  end
  map("n", "gri", _51_, {desc = "Go to implementations"})
  local function _52_()
    local ex = require("mini.extra")
    return ex.pickers.visit_paths()
  end
  return map("n", "<leader>fr", _52_, {desc = "Visit paths"})
end
return now(_33_)
