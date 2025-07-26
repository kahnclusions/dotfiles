-- [nfnl] fnl/keybinds.fnl
local vim = _G.vim
local map = vim.keymap.set
map("n", "<leader>q", "<cmd>wqa<cr>", {desc = "Quit"})
local function _1_()
  local pick = require("mini.pick")
  return pick.builtin.files()
end
map("n", "<leader>ff", _1_, {desc = "Find files"})
local function _2_()
  local pick = require("mini.pick")
  return pick.builtin.resume()
end
map("n", "<leader>f<enter>", _2_, {desc = "Resume"})
local function _3_()
  local pick = require("mini.pick")
  return pick.builtin.grep_live()
end
map("n", "<leader><space>", _3_, {desc = "Find String"})
local function _4_()
  local pick = require("mini.pick")
  return pick.builtin.buffers()
end
map("n", "<leader>fb", _4_, {desc = "Find Buffer"})
local function _5_()
  local pick = require("mini.pick")
  local word = vim.fn.expand("<cword>")
  return pick.builtin.grep({pattern = word})
end
map("n", "<leader>fw", _5_, {desc = "Find Buffer"})
local function _6_()
  local extra = require("mini.extra")
  return extra.pickers.buf_lines({scope = "current"})
end
map("n", ",", _6_, {desc = "Find Lines"})
local function _7_()
  local ex = require("mini.extra")
  return ex.pickers.oldfiles({current_dir = true})
end
map("n", "<leader>fo", _7_, {desc = "Old files"})
local function _8_()
  local buffer_name = vim.api.nvim_buf_get_name(0)
  local mini_files = require("mini.files")
  if ((buffer_name == "") or string.match(buffer_name, "Starter")) then
    return mini_files.open(vim.loop.cwd())
  else
    return mini_files.open(vim.api.nvim_buf_get_name(0))
  end
end
map("n", "fe", _8_)
local function _10_()
  return vim.lsp.buf.definition()
end
map("n", "<leader>ld", _10_, {desc = "Go to definition"})
local function _11_()
  return vim.lsp.buf.rename()
end
map("n", "<leader>lr", _11_, {desc = "Rename"})
local function _12_()
  return vim.lsp.buf.code_action()
end
map("n", "<leader>la", _12_, {desc = "Code actions"})
local function _13_()
  local extra = require("mini.extra")
  return extra.pickers.diagnostic({scope = "current"})
end
map("n", "<leader>le", _13_, {desc = "LSP Errors"})
local function _14_()
  return vim.lsp.buf.definition()
end
map("n", "gd", _14_, {desc = "Go to definition"})
local function _15_()
  return vim.lsp.buf.signature_help()
end
map("n", "<leader>lh", _15_, {desc = "Signature help"})
local function _16_()
  local ex = require("mini.extra")
  return ex.pickers.lsp({scope = "references"})
end
map("n", "grr", _16_, {desc = "Go to references"})
local function _17_()
  local ex = require("mini.extra")
  return ex.pickers.lsp({scope = "implementation"})
end
map("n", "gri", _17_, {desc = "Go to implementations"})
local function _18_()
  local ex = require("mini.extra")
  return ex.pickers.visit_paths()
end
return map("n", "<leader>fr", _18_, {desc = "Visit paths"})
