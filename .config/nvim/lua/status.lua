-- [nfnl] fnl/status.fnl
local now = _G.MiniDeps.now
local function _1_()
  local statusline = require("mini.statusline")
  local function _2_()
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
  return statusline.setup({content = {active = _2_, inactive = nil}})
end
return now(_1_)
