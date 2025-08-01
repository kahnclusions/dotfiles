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
do
  local deps = require("mini.deps")
  deps.setup({path = {package = path_package}})
end
local add = _G.MiniDeps.add
local now = _G.MiniDeps.now
local later = _G.MiniDeps.later
add({source = "https://github.com/Olical/nfnl"})
local function _2_()
  vim.g.mapleader = " "
  vim.o.number = false
  vim.o.relativenumber = false
  vim.o.list = true
  vim.opt.listchars = {tab = "\194\187 ", trail = "\194\183", nbsp = "\226\144\163"}
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
  local kanagawa = require("kanagawa")
  local function _5_(colors)
    _G.assert((nil ~= colors), "Missing argument colors on /Users/ck/.config/nvim/init.fnl:125")
    return {FlashLabel = {fg = colors.theme.ui.bg, bg = colors.theme.vcs.added}}
  end
  kanagawa.setup({overrides = _5_})
  vim.cmd("colorscheme kanagawa")
  add("f-person/auto-dark-mode.nvim")
  return require("auto-dark-mode").setup({update_interval = 2000})
end
now(_4_)
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
  local pick = require("mini.pick")
  pick.setup()
  vim.ui.select = pick.ui_select
  return nil
end
later(_19_)
local function _20_()
  local mini_notify = require("mini.notify")
  mini_notify.setup({lsp_progress = {enable = false}})
  vim.notify = mini_notify.make_notify()
  return nil
end
later(_20_)
local function _21_()
  add({source = "j-hui/fidget.nvim"})
  local fidget = require("fidget")
  return fidget.setup()
end
later(_21_)
local function _22_()
  local move = require("mini.move")
  do local _ = move.setup end
  return {mappings = {left = "<S-left>", right = "<S-right>", down = "<S-down>", up = "<S-up>", line_left = "<S-left>", line_right = "<S-right>", line_down = "<S-down>", line_up = "<S-up>"}}
end
later(_22_)
local function _23_()
  add({source = "https://github.com/nvim-treesitter/nvim-treesitter", checkout = "master", monitor = "master"})
  local ts_parsers = {"bash", "dockerfile", "fennel", "fish", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "go", "gomod", "gosum", "html", "javascript", "json", "lua", "make", "markdown", "python", "rust", "sql", "toml", "tsx", "terraform", "typescript", "vim", "yaml"}
  local function _24_()
    local nts = require("nvim-treesitter.configs")
    return nts.setup({ensure_installed = ts_parsers, highlight = {enable = true}})
  end
  return now(_24_)
end
later(_23_)
local function _25_()
  local hi = require("mini.hipatterns")
  return hi.setup({hex_color = hi.gen_highlighter.hex_color()})
end
later(_25_)
local function _26_()
  local is = require("mini.indentscope")
  return is.setup({draw = {delay = 0, animation = is.gen_animation.none()}, symbol = "\226\149\142"})
end
now(_26_)
local function _27_()
  do local _ = require("mini.files").setup end
  return {mappings = {close = "<ESC>"}, windows = {preview = true, border = "rounded", width_preview = 80}}
end
later(_27_)
local function _28_()
  add({source = "https://github.com/neovim/nvim-lspconfig"})
  vim.lsp.enable("vtsls")
  vim.lsp.enable("fennel_ls")
  vim.lsp.enable("rust_analyzer")
  return vim.lsp.enable("lua_ls")
end
later(_28_)
local function _29_()
  add({source = "https://github.com/stevearc/aerial.nvim"})
  require("aerial").setup({})
  return vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", {desc = "Aerial toggle"})
end
later(_29_)
local function _30_(diagnostic)
  _G.assert((nil ~= diagnostic), "Missing argument diagnostic on /Users/ck/.config/nvim/init.fnl:289")
  local diagnostic_message = {[{vim.diagnostic.severity.ERROR}] = diagnostic.message, [{vim.diagnostic.severity.WARN}] = diagnostic.message, [{vim.diagnostic.severity.INFO}] = diagnostic.message, [{vim.diagnostic.severity.HINT}] = diagnostic.message}
  return diagnostic_message[diagnostic.severity]
end
vim.diagnostic.config({severity_sort = true, float = {border = "rounded", source = "if_many"}, underline = {severity = vim.diagnostic.severity.ERROR}, signs = {text = {[vim.diagnostic.severity.ERROR] = "\238\170\135", [vim.diagnostic.severity.WARN] = "\238\169\172", [vim.diagnostic.severity.INFO] = "\238\169\180", [vim.diagnostic.severity.HINT] = "\238\172\166"}}, virtual_text = {source = "if_many", spacing = 2, format = _30_}})
local function _31_()
  add({source = "saghen/blink.cmp", checkout = "v1.6.0"})
  local blink_cmp = require("blink.cmp")
  return blink_cmp.setup({keymap = {preset = "default", ["<Tab>"] = {"select_and_accept", "fallback_to_mappings"}}, completion = {documentation = {auto_show_delay_ms = 500, auto_show = false}}, sources = {default = {"lsp", "path"}}, fuzzy = {implementation = "prefer_rust"}, signature = {enabled = true}})
end
later(_31_)
local function _32_()
  return vim.hl.on_yank({timeout = 500})
end
vim.api.nvim_create_autocmd("TextYankPost", {desc = "Highlight when yanking (copying) text", group = vim.api.nvim_create_augroup("kickstart-highlight-yank", {clear = true}), callback = _32_})
local function _33_()
  local statusline = require("mini.statusline")
  local function _34_()
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
  statusline.setup({content = {active = _34_, inactive = nil}})
  local function _35_()
    return "%2l:%-2v"
  end
  statusline.section_location = _35_
  return nil
end
now(_33_)
local function pick_marks(name, pattern)
  _G.assert((nil ~= pattern), "Missing argument pattern on /Users/ck/.config/nvim/init.fnl:363")
  _G.assert((nil ~= name), "Missing argument name on /Users/ck/.config/nvim/init.fnl:363")
  local pick = require("mini.pick")
  local marks = vim.fn.getmarklist()
  local local_marks = vim.fn.getmarklist(vim.api.nvim_buf_get_name(0))
  local all_marks = vim.fn.extend(marks, local_marks)
  local cwd = vim.fn.getcwd()
  local items
  do
    local tbl_21_ = {}
    local i_22_ = 0
    for _, v in ipairs(all_marks) do
      local val_23_
      do
        local file_raw
        if (nil == v.file) then
          file_raw = vim.api.nvim_buf_get_name(0)
        else
          file_raw = v.file
        end
        local file = vim.fn.expand(file_raw)
        if (vim.startswith(file, cwd) and v.mark:match(pattern)) then
          val_23_ = {text = (v.mark:gsub("'", "") .. "\226\148\130" .. v.pos[2] .. "\226\148\130" .. file:sub((2 + cwd:len()))), path = vim.fn.expand(file), lnum = v.pos[2]}
        else
          val_23_ = nil
        end
      end
      if (nil ~= val_23_) then
        i_22_ = (i_22_ + 1)
        tbl_21_[i_22_] = val_23_
      else
      end
    end
    items = tbl_21_
  end
  local height
  if (#items > 30) then
    height = 40
  else
    height = 30
  end
  return pick.start({source = {name = name, items = items}, window = {config = {height = height}}})
end
local function _40_()
  local clue = require("mini.clue")
  return clue.setup({triggers = {{mode = "n", keys = "<leader>"}, {mode = "x", keys = "<leader>"}, {mode = "n", keys = "\\"}, {mode = "i", keys = "<C-x>"}, {mode = "n", keys = "g"}, {mode = "x", keys = "g"}, {mode = "n", keys = "s"}, {mode = "n", keys = "'"}, {mode = "n", keys = "`"}, {mode = "x", keys = "'"}, {mode = "x", keys = "`"}, {mode = "n", keys = "m"}, {mode = "x", keys = "m"}, {mode = "n", keys = "\""}, {mode = "x", keys = "\""}, {mode = "i", keys = "<C-r>"}, {mode = "c", keys = "<C-r>"}, {mode = "n", keys = "<C-w>"}, {mode = "n", keys = "z"}, {mode = "x", keys = "z"}}, clues = {{mode = "n", keys = "<Leader>b", desc = "\239\139\146 Buffer"}, {mode = "n", keys = "<Leader>e", desc = "\239\128\130 Explore"}, {mode = "n", keys = "<Leader>f", desc = "\239\128\130 Find"}, {mode = "n", keys = "<Leader>g", desc = "\243\176\138\162 Git"}, {mode = "n", keys = "<Leader>i", desc = "\243\176\143\170 Insert"}, {mode = "n", keys = "<Leader>l", desc = "\243\176\152\166 LSP"}, {mode = "n", keys = "<Leader>m", desc = "\243\176\184\149 Marks"}, {mode = "n", keys = "<Leader>n", desc = "\243\176\142\159 Notify"}, {mode = "n", keys = "<Leader>q", desc = "\239\141\175 NVim"}, {mode = "n", keys = "<Leader>s", desc = "\243\176\134\147 Session"}, {mode = "n", keys = "<Leader>s", desc = "\238\158\149 Terminal"}, {mode = "n", keys = "<Leader>u", desc = "\243\176\148\131 UI"}, {mode = "n", keys = "<Leader>w", desc = "\238\173\191 Window"}, clue.gen_clues.g(), clue.gen_clues.builtin_completion(), clue.gen_clues.marks(), clue.gen_clues.registers(), clue.gen_clues.windows(), clue.gen_clues.z()}, window = {delay = 300}})
end
now(_40_)
local function _41_()
  add({source = "NeogitOrg/neogit", depends = {"nvim-lua/plenary.nvim"}})
  local neogit = require("neogit")
  return neogit.setup()
end
later(_41_)
local function _42_()
  add({source = "chentoast/marks.nvim"})
  local marks = require("marks")
  return marks.setup()
end
later(_42_)
local function _43_()
  add({source = "folke/flash.nvim"})
  local map = vim.keymap.set
  local flash = require("flash")
  flash.setup()
  local function _44_()
    local flash0 = require("flash")
    return flash0.jump()
  end
  map({"n", "x", "o", "v"}, "f", _44_, {desc = "Flash jump"})
  local function _45_()
    local flash0 = require("flash")
    return flash0.jump()
  end
  map({"i"}, "<c-f>", _45_, {desc = "Flash jump"})
  local function _46_()
    local flash0 = require("flash")
    return flash0.treesitter()
  end
  map({"n", "x", "o", "v"}, "F", _46_, {desc = "Flash treesitter jump"})
  local function _47_()
    local flash0 = require("flash")
    return flash0.toggle()
  end
  map("c", "<c-s>", _47_, {desc = "Flash toggle"})
  local function _48_()
    local flash0 = require("flash")
    return flash0.jump({continue = true})
  end
  map({"n", "x", "o"}, "<leader>jc", _48_, {desc = "Continue jump"})
  local function _49_()
    local flash0 = require("flash")
    return flash0.jump({search = {mode = "search", max_length = 0}, label = {after = {0, 0}}, pattern = "^"})
  end
  map({"n", "x", "o"}, "<leader>jl", _49_, {desc = "Jump to line"})
  local function _50_()
    local flash0 = require("flash")
    return flash0.jump({pattern = vim.fn.expand("<cword>")})
  end
  map({"n", "x", "o"}, "<leader>jw", _50_, {desc = "Jump to current word"})
  local function _51_()
    local flash0 = require("flash")
    local function _52_(matched, state)
      _G.assert((nil ~= state), "Missing argument state on /Users/ck/.config/nvim/init.fnl:502")
      _G.assert((nil ~= matched), "Missing argument matched on /Users/ck/.config/nvim/init.fnl:502")
      local function _53_()
        vim.api.nvim_win_set_cursor(matched.win, matched.pos)
        return vim.diagnostic.open_float()
      end
      vim.api.nvim_win_call(matched.win, _53_)
      return state:restore()
    end
    return flash0.jump({action = _52_})
  end
  return map({"n"}, "<leader>jd", _51_, {desc = "Show diagnostics at location"})
end
later(_43_)
local function _54_()
  local map = vim.keymap.set
  map("n", "<leader>q", "<cmd>wqa<cr>", {desc = "Quit"})
  map("n", "<leader>wv", "<C-w>v<cr>", {desc = "Split window vertically"})
  map("n", "<leader>ws", "<C-w>s<cr>", {desc = "Split window horizontally"})
  map("n", "<leader>wc", "<C-w>c<cr>", {desc = "Close window"})
  local function _55_()
    local pick = require("mini.pick")
    return pick.builtin.files()
  end
  map("n", "<leader>ff", _55_, {desc = "Find files"})
  local function _56_()
    local pick = require("mini.pick")
    return pick.builtin.resume()
  end
  map("n", "<leader>f<enter>", _56_, {desc = "Resume"})
  local function _57_()
    local pick = require("mini.pick")
    return pick.builtin.grep_live()
  end
  map("n", "<leader><space>", _57_, {desc = "Find String"})
  local function _58_()
    local pick = require("mini.pick")
    return pick.builtin.buffers()
  end
  map("n", "<leader>fb", _58_, {desc = "Find Buffer"})
  local function _59_()
    local pick = require("mini.pick")
    local word = vim.fn.expand("<cword>")
    return pick.builtin.grep({pattern = word})
  end
  map("n", "<leader>fw", _59_, {desc = "Find Buffer"})
  local function _60_()
    local extra = require("mini.extra")
    return extra.pickers.buf_lines({scope = "current"})
  end
  map("n", ",", _60_, {desc = "Find Lines"})
  local function _61_()
    local ex = require("mini.extra")
    return ex.pickers.oldfiles({current_dir = true})
  end
  map("n", "<leader>fo", _61_, {desc = "Old files"})
  map("n", "<leader>fs", "<cmd>w<cr>", {desc = "Write buffer (save)"})
  local function files_open_current()
    local buffer_name = vim.api.nvim_buf_get_name(0)
    local mini_files = require("mini.files")
    if ((buffer_name == "") or string.match(buffer_name, "Starter")) then
      return mini_files.open(vim.loop.cwd())
    else
      return mini_files.open(vim.api.nvim_buf_get_name(0))
    end
  end
  map("n", "<leader>ec", files_open_current, {desc = "Explore files at current"})
  map("n", "<leader>e.", files_open_current, {desc = "Explore files at current"})
  local function _63_()
    local mini_files = require("mini.files")
    return mini_files.open()
  end
  map("n", "<leader>ee", _63_, {desc = "Explore files"})
  local function _64_()
    return pick_marks("User marks", "[A-Za-z]")
  end
  map("n", "<leader>mm", _64_, {desc = "All user marks"})
  local function _65_()
    return pick_marks("Global marks", "[A-Z]")
  end
  map("n", "<leader>mg", _65_, {desc = "Global marks"})
  local function _66_()
    return pick_marks("Local marks", "[a-z]")
  end
  map("n", "<leader>ml", _66_, {desc = "Local user marks"})
  local function _67_()
    return pick_marks("Marks", ".")
  end
  map("n", "<leader>mM", _67_, {desc = "All marks"})
  local function _68_()
    return pick_marks("Marks", ".")
  end
  map("n", "<leader>ma", _68_, {desc = "All marks"})
  local function _69_()
    return vim.lsp.buf.definition()
  end
  map("n", "<leader>ld", _69_, {desc = "Go to definition"})
  local function _70_()
    return vim.lsp.buf.rename()
  end
  map("n", "<leader>lr", _70_, {desc = "Rename"})
  local function _71_()
    return vim.lsp.buf.code_action()
  end
  map("n", "<leader>la", _71_, {desc = "Code actions"})
  local function _72_()
    local extra = require("mini.extra")
    return extra.pickers.diagnostic({scope = "current"})
  end
  map("n", "<leader>le", _72_, {desc = "LSP Errors"})
  local function _73_()
    return vim.lsp.buf.definition()
  end
  map("n", "gd", _73_, {desc = "Go to definition"})
  local function _74_()
    return vim.lsp.buf.signature_help()
  end
  map("n", "<leader>lh", _74_, {desc = "Signature help"})
  local function _75_()
    local ex = require("mini.extra")
    return ex.pickers.lsp({scope = "references"})
  end
  map("n", "grr", _75_, {desc = "Go to references"})
  local function _76_()
    local ex = require("mini.extra")
    return ex.pickers.lsp({scope = "implementation"})
  end
  map("n", "gri", _76_, {desc = "Go to implementations"})
  local function _77_()
    local move = require("mini.move")
    return move.move_line("up")
  end
  map("n", "sk", _77_, {desc = "Move line up"})
  local function _78_()
    local move = require("mini.move")
    return move.move_line("down")
  end
  map("n", "sj", _78_, {desc = "Move line down"})
  local function _79_()
    local move = require("mini.move")
    return move.move_line("left")
  end
  map("n", "sh", _79_, {desc = "Move line up"})
  local function _80_()
    local move = require("mini.move")
    return move.move_line("right")
  end
  map("n", "sl", _80_, {desc = "Move line down"})
  local function _81_()
    local move = require("mini.move")
    return move.move_selection("up")
  end
  map("v", "sk", _81_, {desc = "Move selection up"})
  local function _82_()
    local move = require("mini.move")
    return move.move_selection("down")
  end
  map("v", "sj", _82_, {desc = "Move selection down"})
  local function _83_()
    local move = require("mini.move")
    return move.move_selection("left")
  end
  map("v", "sh", _83_, {desc = "Move selection left"})
  local function _84_()
    local move = require("mini.move")
    return move.move_selection("right")
  end
  map("v", "sl", _84_, {desc = "Move selection left"})
  local function _85_()
    return vim.diagnostic.open_float()
  end
  map("n", "<leader>dd", _85_, {desc = "Open diagnostic float"})
  local function _86_()
    local neogit = require("neogit")
    return neogit.open({kind = "floating"})
  end
  map("n", "<leader>gg", _86_, {desc = "Neo(g)it"})
  local function _87_()
    local notify = require("mini.notify")
    return notify.clear()
  end
  map("n", "<leader>nc", _87_, {desc = "Notify Clear"})
  local function _88_()
    local notify = require("mini.notify")
    return notify.show_history()
  end
  map("n", "<leader>nh", _88_, {desc = "Notify History"})
  local function _89_()
    local ex = require("mini.extra")
    return ex.pickers.visit_paths()
  end
  return map("n", "<leader>fr", _89_, {desc = "Visit paths"})
end
return now(_54_)
