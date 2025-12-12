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
local function _2_()
  vim.o.wrap = true
  vim.o.number = false
  vim.o.list = false
  vim.o.autoindent = true
  vim.o.expandtab = true
  vim.o.scrolloff = 10
  vim.o.clipboard = "unnamed,unnamedplus"
  vim.o.updatetime = 250
  vim.o.timeoutlen = 300
  vim.opt.winborder = "single"
  vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
  vim.opt.tabstop = 4
  return require("mini.basics").setup({options = {basic = true, extra_ui = true, win_borders = "bold"}, mappings = {basic = true, windows = true}, autocommands = {basic = true, relnum_in_visual_mode = false}})
end
now(_2_)
local function _3_()
  local mini_notify = require("mini.notify")
  mini_notify.setup({lsp_progress = {enable = false}})
  vim.notify = mini_notify.make_notify()
  return nil
end
now(_3_)
local function _4_()
  add({source = "https://github.com/uhs-robert/oasis.nvim"})
  local uid = (vim.uv or vim.loop).getuid
  local is_root = (uid == 0)
  local is_remote = (not (vim.env.SSH_CONNECTION == nil) or not (vim.env.SSH_TTY == nil))
  local is_sudoedit = (not is_root and (vim.env.SUDOEDIT == "1"))
  local function pick_colorscheme()
    local is_elevated = (is_root or is_sudoedit)
    if is_remote then
      if is_elevated then
        return "oasis-abyss"
      else
        return "oasis-mirage"
      end
    else
      if is_elevated then
        return "oasis-sol"
      else
        return "oasis-lagoon"
      end
    end
  end
  local oasis = require("oasis")
  oasis.setup({light_style = "lagoon", dark_style = "lagoon", light_intensity = 2})
  vim.cmd.colorscheme(pick_colorscheme())
  add("f-person/auto-dark-mode.nvim")
  return require("auto-dark-mode").setup({update_interval = 2000})
end
now(_4_)
local function _8_()
  return require("mini.ai").setup()
end
later(_8_)
local function _9_()
  return require("mini.bracketed").setup()
end
later(_9_)
local function _10_()
  return require("mini.bufremove").setup()
end
later(_10_)
local function _11_()
  return require("mini.comment").setup()
end
later(_11_)
local function _12_()
  return require("mini.git").setup()
end
later(_12_)
local function _13_()
  return require("mini.icons").setup()
end
later(_13_)
local function _14_()
  return require("mini.fuzzy").setup()
end
later(_14_)
local function _15_()
  return require("mini.misc").setup()
end
later(_15_)
local function _16_()
  return require("mini.surround").setup()
end
later(_16_)
local function _17_()
  return require("mini.extra").setup()
end
later(_17_)
local function _18_()
  return require("mini.visits").setup()
end
later(_18_)
local function _19_()
  return require("mini.starter").setup()
end
now(_19_)
local function _20_()
  return require("mini.diff").setup({view = {signs = {add = "\226\148\131", change = "\226\148\131", delete = "\226\148\131"}, priority = 199}})
end
later(_20_)
local function _21_()
  vim.g.minitrailspace_disable = true
  return require("mini.trailspace").setup()
end
later(_21_)
local function _22_()
  local pick = require("mini.pick")
  pick.setup()
  vim.ui.select = pick.ui_select
  return nil
end
later(_22_)
local function _23_()
  add({source = "j-hui/fidget.nvim"})
  local fidget = require("fidget")
  return fidget.setup()
end
later(_23_)
local function _24_()
  local move = require("mini.move")
  do local _ = move.setup end
  return {mappings = {left = "<S-left>", right = "<S-right>", down = "<S-down>", up = "<S-up>", line_left = "<S-left>", line_right = "<S-right>", line_down = "<S-down>", line_up = "<S-up>"}}
end
later(_24_)
local function _25_()
  add({source = "https://github.com/nvim-treesitter/nvim-treesitter", checkout = "master", monitor = "master"})
  local ts_parsers = {"bash", "dockerfile", "fennel", "fish", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "go", "gomod", "gosum", "html", "http", "javascript", "json", "lua", "make", "markdown", "nix", "python", "rust", "sql", "toml", "tsx", "terraform", "typescript", "vim", "yaml"}
  local function _26_()
    local nts = require("nvim-treesitter.configs")
    return nts.setup({ensure_installed = ts_parsers, highlight = {enable = true}})
  end
  return now(_26_)
end
later(_25_)
local function _27_()
  local hi = require("mini.hipatterns")
  return hi.setup({hex_color = hi.gen_highlighter.hex_color()})
end
later(_27_)
local function _28_()
  local is = require("mini.indentscope")
  return is.setup({draw = {delay = 0, animation = is.gen_animation.none()}, symbol = "\226\149\142"})
end
now(_28_)
local function _29_()
  local show_dotfiles = false
  local filter_show
  local function _30_()
    return true
  end
  filter_show = _30_
  local filter_hide
  local function _31_(fs_entry)
    return not vim.startswith(fs_entry.name, ".")
  end
  filter_hide = _31_
  require("mini.files").setup({content = {filter = filter_hide}, mappings = {close = "<ESC>"}, windows = {preview = true, border = "rounded", width_preview = 80}})
  local toggle_dotfiles
  local function _32_()
    show_dotfiles = not show_dotfiles
    local mini_files = require("mini.files")
    local new_filter
    if show_dotfiles then
      new_filter = filter_show
    else
      new_filter = filter_hide
    end
    return mini_files.refresh({content = {filter = new_filter}})
  end
  toggle_dotfiles = _32_
  local function _34_(args)
    local buf_id = args.data.buf_id
    local function _35_()
      return toggle_dotfiles()
    end
    return vim.keymap.set("n", "g.", _35_, {buffer = buf_id})
  end
  return vim.api.nvim_create_autocmd("User", {pattern = "MiniFilesBufferCreate", callback = _34_})
end
later(_29_)
local function _36_()
  add({source = "https://github.com/neovim/nvim-lspconfig"})
  vim.lsp.enable("vtsls")
  vim.lsp.enable("fennel_ls")
  vim.lsp.enable("rust_analyzer")
  vim.lsp.enable("tailwindcss")
  vim.lsp.enable("gopls")
  vim.lsp.enable("nil_ls")
  vim.lsp.enable("sourcekit")
  return vim.lsp.enable("lua_ls")
end
later(_36_)
local function _37_()
  add({source = "https://github.com/stevearc/aerial.nvim"})
  local aerial = require("aerial")
  aerial.setup({attach_mode = "global"})
  return vim.keymap.set("n", "<leader>aa", "<cmd>AerialToggle!<CR>", {desc = "Aerial toggle"})
end
later(_37_)
local function _38_()
  add({source = "https://github.com/SmiteshP/nvim-navic"})
  add({source = "https://github.com/MunifTanjim/nui.nvim"})
  add({source = "https://github.com/hasansujon786/nvim-navbuddy"})
  local navbuddy = require("nvim-navbuddy")
  navbuddy.setup({lsp = {auto_attach = true}})
  vim.keymap.set("n", "<leader>an", "<cmd>Navbuddy<CR>", {desc = "Navbuddy"})
  return vim.keymap.set("n", "<leader>nn", "<cmd>Navbuddy<CR>", {desc = "Navbuddy"})
end
later(_38_)
local function _39_()
  add({source = "https://github.com/stevearc/conform.nvim"})
  local conform = require("conform")
  return conform.setup({format_on_save = {timeout_ms = 500, lsp_format = "fallback"}, formatters_by_ft = {lua = {"stylua"}, javascript = {"prettierd", "prettier", stop_after_first = true}, typescript = {"prettierd", "prettier", stop_after_first = true}, typescriptreact = {"prettierd", "prettier", stop_after_first = true}}})
end
later(_39_)
local function _40_()
  add({source = "https://github.com/mfussenegger/nvim-lint"})
  do
    local lint = require("lint")
    lint.linters_by_ft = {typescriptreact = {"eslint_d"}, typescript = {"eslint_d"}, javascript = {"eslint_d"}}
  end
  local function _41_()
    local lint = require("lint")
    return lint.try_lint()
  end
  return vim.api.nvim_create_autocmd({"BufWritePost"}, {callback = _41_})
end
later(_40_)
local function _42_(diagnostic)
  if (nil == diagnostic) then
    _G.error("Missing argument diagnostic on /Users/ck/.config/nvim/init.fnl:392", 2)
  else
  end
  local diagnostic_message = {[{vim.diagnostic.severity.ERROR}] = diagnostic.message, [{vim.diagnostic.severity.WARN}] = diagnostic.message, [{vim.diagnostic.severity.INFO}] = diagnostic.message, [{vim.diagnostic.severity.HINT}] = diagnostic.message}
  return diagnostic_message[diagnostic.severity]
end
vim.diagnostic.config({severity_sort = true, float = {border = "rounded", source = "if_many"}, underline = {severity = vim.diagnostic.severity.ERROR}, signs = {text = {[vim.diagnostic.severity.ERROR] = "\243\176\154\145", [vim.diagnostic.severity.WARN] = "\238\153\148", [vim.diagnostic.severity.INFO] = "\238\172\166", [vim.diagnostic.severity.HINT] = "\239\144\128"}}, virtual_text = {source = "if_many", spacing = 2, format = _42_}})
local function _44_()
  add({source = "saghen/blink.cmp", checkout = "v1.6.0"})
  local blink_cmp = require("blink.cmp")
  return blink_cmp.setup({keymap = {preset = "default", ["<Tab>"] = {"select_and_accept", "fallback_to_mappings"}}, completion = {documentation = {auto_show_delay_ms = 500, auto_show = false}}, sources = {default = {"lsp", "path"}}, fuzzy = {implementation = "prefer_rust"}, signature = {enabled = true}})
end
later(_44_)
local function _45_()
  return vim.hl.on_yank({timeout = 500})
end
vim.api.nvim_create_autocmd("TextYankPost", {desc = "Highlight when yanking (copying) text", group = vim.api.nvim_create_augroup("kickstart-highlight-yank", {clear = true}), callback = _45_})
local function _46_()
  local statusline = require("mini.statusline")
  local function _47_()
    local MiniStatusline = _G.MiniStatusline
    local mode, mode_hl = MiniStatusline.section_mode({trunc_width = 120})
    local diagnostics = MiniStatusline.section_diagnostics({trunc_width = 75})
    local lsp = MiniStatusline.section_lsp({trunc_width = 75})
    local git = MiniStatusline.section_git({trunc_width = 40})
    local filename = MiniStatusline.section_filename({trunc_width = 140})
    local fileinfo = MiniStatusline.section_fileinfo({trunc_width = 120})
    local search = MiniStatusline.section_searchcount({trunc_width = 75})
    local location = MiniStatusline.section_location({trunc_width = 1000})
    return MiniStatusline.combine_groups({{hl = mode_hl, strings = {mode}}, {hl = "MiniStatuslineDevinfo", strings = {git, diagnostics, lsp}}, "%<", {hl = "MiniStatuslineFilename", strings = {filename}}, "%=", {hl = "MiniStatuslineFileinfo", strings = {fileinfo}}, {hl = mode_hl, strings = {search, location}}})
  end
  statusline.setup({content = {active = _47_, inactive = nil}})
  local function _48_()
    return "%2l:%-2v"
  end
  statusline.section_location = _48_
  return nil
end
now(_46_)
local function pick_marks(name, pattern)
  if (nil == pattern) then
    _G.error("Missing argument pattern on /Users/ck/.config/nvim/init.fnl:466", 2)
  else
  end
  if (nil == name) then
    _G.error("Missing argument name on /Users/ck/.config/nvim/init.fnl:466", 2)
  else
  end
  local pick = require("mini.pick")
  local marks = vim.fn.getmarklist()
  local local_marks = vim.fn.getmarklist(vim.api.nvim_buf_get_name(0))
  local all_marks = vim.fn.extend(marks, local_marks)
  local cwd = vim.fn.getcwd()
  local items
  do
    local tbl_26_ = {}
    local i_27_ = 0
    for _, v in ipairs(all_marks) do
      local val_28_
      do
        local file_raw
        if (nil == v.file) then
          file_raw = vim.api.nvim_buf_get_name(0)
        else
          file_raw = v.file
        end
        local file = vim.fn.expand(file_raw)
        if (vim.startswith(file, cwd) and v.mark:match(pattern)) then
          val_28_ = {text = (v.mark:gsub("'", "") .. "\226\148\130" .. v.pos[2] .. "\226\148\130" .. file:sub((2 + cwd:len()))), path = vim.fn.expand(file), lnum = v.pos[2]}
        else
          val_28_ = nil
        end
      end
      if (nil ~= val_28_) then
        i_27_ = (i_27_ + 1)
        tbl_26_[i_27_] = val_28_
      else
      end
    end
    items = tbl_26_
  end
  local height
  if (#items > 30) then
    height = 40
  else
    height = 30
  end
  return pick.start({source = {name = name, items = items}, window = {config = {height = height}}})
end
local function _55_()
  local clue = require("mini.clue")
  return clue.setup({triggers = {{mode = "n", keys = "<leader>"}, {mode = "x", keys = "<leader>"}, {mode = "n", keys = "\\"}, {mode = "i", keys = "<C-x>"}, {mode = "n", keys = "g"}, {mode = "x", keys = "g"}, {mode = "n", keys = "s"}, {mode = "n", keys = "'"}, {mode = "n", keys = "`"}, {mode = "x", keys = "'"}, {mode = "x", keys = "`"}, {mode = "n", keys = "m"}, {mode = "x", keys = "m"}, {mode = "n", keys = "\""}, {mode = "x", keys = "\""}, {mode = "i", keys = "<C-r>"}, {mode = "c", keys = "<C-r>"}, {mode = "n", keys = "<C-w>"}, {mode = "n", keys = "z"}, {mode = "x", keys = "z"}, {mode = "n", keys = "["}, {mode = "x", keys = "["}, {mode = "n", keys = "]"}, {mode = "x", keys = "]"}}, clues = {{mode = "n", keys = "<Leader>b", desc = "\239\139\146 Buffer"}, {mode = "n", keys = "<Leader>e", desc = "\239\128\130 Explore"}, {mode = "n", keys = "<Leader>f", desc = "\239\128\130 Find"}, {mode = "n", keys = "<Leader>g", desc = "\243\176\138\162 Git"}, {mode = "n", keys = "<Leader>i", desc = "\243\176\143\170 Insert"}, {mode = "n", keys = "<Leader>l", desc = "\243\176\152\166 LSP"}, {mode = "n", keys = "<Leader>m", desc = "\243\176\184\149 Marks"}, {mode = "n", keys = "<Leader>n", desc = "\243\176\142\159 Notify"}, {mode = "n", keys = "<Leader>q", desc = "\239\141\175 NVim"}, {mode = "n", keys = "<Leader>s", desc = "\243\176\134\147 Session"}, {mode = "n", keys = "<Leader>s", desc = "\238\158\149 Terminal"}, {mode = "n", keys = "<Leader>u", desc = "\243\176\148\131 UI"}, {mode = "n", keys = "<Leader>w", desc = "\238\173\191 Window"}, clue.gen_clues.g(), clue.gen_clues.builtin_completion(), clue.gen_clues.marks(), clue.gen_clues.registers(), clue.gen_clues.windows(), clue.gen_clues.z()}, window = {delay = 300}})
end
later(_55_)
local function _56_()
  add({source = "NeogitOrg/neogit", depends = {"nvim-lua/plenary.nvim"}})
  local neogit = require("neogit")
  return neogit.setup()
end
later(_56_)
local function _57_()
  add({source = "https://github.com/chentoast/marks.nvim"})
  local marks = require("marks")
  return marks.setup()
end
later(_57_)
local function _58_()
  add({source = "https://github.com/folke/snacks.nvim"})
  local snacks = require("snacks")
  local map = vim.keymap.set
  snacks.setup({picker = {sources = {explorer = {layout = {layout = {width = 25}}}, grep = {layout = {layout = {width = 0.7, max_width = 120}}}, buffers = {layout = {layout = {width = 0.35, min_width = 60}}}, lines = {win = {preview = {number = false, relativenumber = false}}, layout = {preview = "main", layout = {{win = "input", height = 1, border = "none"}, {{win = "list", width = 0}, {win = "preview", title = "{preview}", title_pos = "left", width = 0.8, border = true}, box = "horizontal"}, box = "vertical", width = 0.5, height = 15, max_height = 15, position = "bottom"}}}}, win = {preview = {wo = {number = false, relativenumber = false}}}, layouts = {default = {preview = "main", layout = {{win = "input", height = 1, border = "none"}, {{win = "list", width = 0}, {win = "preview", title = "{preview}", title_pos = "left", width = 0.8, border = true}, box = "horizontal"}, box = "vertical", width = 0.45, height = 0.4, max_height = 30, min_width = 60, max_width = 80, position = "float", anchor = "NW", row = -2, col = 0, border = true, title = " {title} {live} {flags}", title_pos = "center", backdrop = false}}}}})
  local function _59_()
    return _G.Snacks.picker.explorer()
  end
  map("n", "<leader>fe", _59_, {desc = "Files"})
  local function _60_()
    local SmartPick = require("SmartPick")
    return SmartPick.picker()
  end
  map("n", "<leader>fF", _60_, {desc = "Files"})
  local function _61_()
    return _G.Snacks.picker.smart()
  end
  return map("n", "<leader>ff", _61_, {desc = "Files"})
end
later(_58_)
local function _62_()
  add({source = "folke/flash.nvim"})
  local map = vim.keymap.set
  local flash = require("flash")
  flash.setup()
  local function _63_()
    local flash0 = require("flash")
    return flash0.jump()
  end
  map({"n", "x", "o", "v"}, "f", _63_, {desc = "Flash jump"})
  local function _64_()
    local flash0 = require("flash")
    return flash0.jump()
  end
  map({"i"}, "<c-f>", _64_, {desc = "Flash jump"})
  local function _65_()
    local flash0 = require("flash")
    return flash0.treesitter()
  end
  map({"n", "x", "o", "v"}, "F", _65_, {desc = "Flash treesitter jump"})
  local function _66_()
    local flash0 = require("flash")
    return flash0.toggle()
  end
  map("c", "<c-s>", _66_, {desc = "Flash toggle"})
  local function _67_()
    local flash0 = require("flash")
    return flash0.jump({continue = true})
  end
  map({"n", "x", "o"}, "<leader>jc", _67_, {desc = "Continue jump"})
  local function _68_()
    local flash0 = require("flash")
    return flash0.jump({search = {mode = "search", max_length = 0}, label = {after = {0, 0}}, pattern = "^"})
  end
  map({"n", "x", "o"}, "<leader>jl", _68_, {desc = "Jump to line"})
  local function _69_()
    local flash0 = require("flash")
    return flash0.jump({pattern = vim.fn.expand("<cword>")})
  end
  map({"n", "x", "o"}, "<leader>jw", _69_, {desc = "Jump to current word"})
  local function _70_()
    local flash0 = require("flash")
    local function _71_(matched, state)
      if (nil == state) then
        _G.error("Missing argument state on /Users/ck/.config/nvim/init.fnl:676", 2)
      else
      end
      if (nil == matched) then
        _G.error("Missing argument matched on /Users/ck/.config/nvim/init.fnl:676", 2)
      else
      end
      local function _74_()
        vim.api.nvim_win_set_cursor(matched.win, matched.pos)
        return vim.diagnostic.open_float()
      end
      vim.api.nvim_win_call(matched.win, _74_)
      return state:restore()
    end
    return flash0.jump({action = _71_})
  end
  return map({"n"}, "<leader>jd", _70_, {desc = "Show diagnostics at location"})
end
later(_62_)
local function _75_()
  add({source = "https://github.com/patrickpichler/hovercraft.nvim"})
  local hovercraft = require("hovercraft")
  local map = vim.keymap.set
  hovercraft.setup()
  local function _76_()
    local hovercraft0 = require("hovercraft")
    if hovercraft0.is_visible() then
      return hovercraft0.enter_popup()
    else
      return hovercraft0.hover()
    end
  end
  return map("n", "K", _76_, {desc = "Hover"})
end
later(_75_)
local function _78_()
  local map = vim.keymap.set
  map("n", "<leader>q", "<cmd>qa<cr>", {desc = "Quit"})
  map("n", "<leader>wv", "<C-w>v<cr>", {desc = "Split window vertically"})
  map("n", "<leader>ws", "<C-w>s<cr>", {desc = "Split window horizontally"})
  map("n", "<leader>wc", "<C-w>c<cr>", {desc = "Close window"})
  local function _79_()
    return _G.Snacks.picker.grep()
  end
  map("n", "<leader><space>", _79_, {desc = "Find String"})
  local function _80_()
    return _G.Snacks.picker.lines({layout = {preview = "main"}, win = {preview = {wo = {number = false, relativenumber = false}}}})
  end
  map("n", "<leader>/", _80_, {desc = "Find lines"})
  local function _81_()
    return _G.Snacks.picker.buffers()
  end
  map("n", "<leader>fb", _81_, {desc = "Find Buffer"})
  local function _82_()
    return _G.Snacks.picker.grep_word()
  end
  map({"n", "v"}, "<leader>fw", _82_, {desc = "Find current word"})
  local function _83_()
    return _G.Snacks.picker.recent()
  end
  map("n", "<leader>fo", _83_, {desc = "Old files"})
  local function _84_()
    return _G.Snacks.picker.resume({})
  end
  map("n", "<leader>fr", _84_, {desc = "Resume snacking"})
  map("n", "<leader>fs", "<cmd>w<cr>", {desc = "Write buffer (save)"})
  local function _85_()
    local extra = require("mini.extra")
    return extra.pickers.buf_lines({scope = "current"})
  end
  map("n", ",", _85_, {desc = "Pick lines in current file"})
  local function files_open_current()
    local buffer_name = vim.api.nvim_buf_get_name(0)
    local mini_files = require("mini.files")
    if ((buffer_name == "") or string.match(buffer_name, "Starter")) then
      return mini_files.open(vim.loop.cwd())
    else
      return mini_files.open(vim.api.nvim_buf_get_name(0))
    end
  end
  map("n", "<leader>f.", files_open_current, {desc = "Explore files at current"})
  local function _87_()
    return require("mini.files").open(vim.loop.cwd())
  end
  map("n", "<leader>fE", _87_, {desc = "Explore files"})
  local function _88_()
    return _G.Snacks.picker.marks()
  end
  map("n", "<leader>mm", _88_, {desc = "Marks"})
  local function _89_()
    return pick_marks("Global marks", "[A-Z]")
  end
  map("n", "<leader>mg", _89_, {desc = "Global marks"})
  local function _90_()
    return pick_marks("Local marks", "[a-z]")
  end
  map("n", "<leader>ml", _90_, {desc = "Local user marks"})
  local function _91_()
    return pick_marks("Marks", ".")
  end
  map("n", "<leader>mM", _91_, {desc = "All marks"})
  local function _92_()
    return pick_marks("Marks", ".")
  end
  map("n", "<leader>ma", _92_, {desc = "All marks"})
  local function _93_()
    return vim.lsp.buf.definition()
  end
  map("n", "<leader>ld", _93_, {desc = "Go to definition"})
  local function _94_()
    return vim.lsp.buf.rename()
  end
  map("n", "<leader>lr", _94_, {desc = "Rename"})
  local function _95_()
    return vim.lsp.buf.code_action()
  end
  map("n", "<leader>la", _95_, {desc = "Code actions"})
  local function _96_()
    local extra = require("mini.extra")
    return extra.pickers.diagnostic({scope = "current"})
  end
  map("n", "<leader>le", _96_, {desc = "LSP Errors"})
  local function _97_()
    return vim.lsp.buf.definition()
  end
  map("n", "gd", _97_, {desc = "Go to definition"})
  local function _98_()
    return vim.lsp.buf.signature_help()
  end
  map("n", "<leader>lh", _98_, {desc = "Signature help"})
  local function _99_()
    local ex = require("mini.extra")
    return ex.pickers.lsp({scope = "references"})
  end
  map("n", "grr", _99_, {desc = "Go to references"})
  local function _100_()
    local ex = require("mini.extra")
    return ex.pickers.lsp({scope = "implementation"})
  end
  map("n", "gri", _100_, {desc = "Go to implementations"})
  local function _101_()
    local move = require("mini.move")
    return move.move_line("up")
  end
  map("n", "sk", _101_, {desc = "Move line up"})
  local function _102_()
    local move = require("mini.move")
    return move.move_line("down")
  end
  map("n", "sj", _102_, {desc = "Move line down"})
  local function _103_()
    local move = require("mini.move")
    return move.move_line("left")
  end
  map("n", "sh", _103_, {desc = "Move line up"})
  local function _104_()
    local move = require("mini.move")
    return move.move_line("right")
  end
  map("n", "sl", _104_, {desc = "Move line down"})
  local function _105_()
    local move = require("mini.move")
    return move.move_selection("up")
  end
  map("v", "sk", _105_, {desc = "Move selection up"})
  local function _106_()
    local move = require("mini.move")
    return move.move_selection("down")
  end
  map("v", "sj", _106_, {desc = "Move selection down"})
  local function _107_()
    local move = require("mini.move")
    return move.move_selection("left")
  end
  map("v", "sh", _107_, {desc = "Move selection left"})
  local function _108_()
    local move = require("mini.move")
    return move.move_selection("right")
  end
  map("v", "sl", _108_, {desc = "Move selection left"})
  local function _109_()
    return vim.diagnostic.open_float()
  end
  map("n", "<leader>dd", _109_, {desc = "Open diagnostic float"})
  local function _110_()
    local neogit = require("neogit")
    return neogit.open({kind = "floating"})
  end
  map("n", "<leader>gg", _110_, {desc = "Neo(g)it"})
  local function _111_()
    local notify = require("mini.notify")
    return notify.clear()
  end
  map("n", "<leader>nc", _111_, {desc = "Notify Clear"})
  local function _112_()
    local notify = require("mini.notify")
    return notify.show_history()
  end
  return map("n", "<leader>nh", _112_, {desc = "Notify History"})
end
later(_78_)
local function _113_()
  return add({source = "https://github.com/Olical/nfnl"})
end
return later(_113_)
