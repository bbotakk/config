-- leader keymaps found under: `user/whichkey.lua` (all leader mappings use whichkey Plugin thus allowing the mapping to get a name etc...
-- control mappings are only used for window management etc. vim is all keystrokes

-- Modes (first argument), one map for multiple modes: use `{}`
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- `local` defines an alias in the current file. readability.
local opts = { noremap = true, silent = true }
local bind = vim.keymap.set

bind("", "<Space>", "<Nop>", opts) -- unmap it
vim.g.mapleader = " " -- <space> as leader
vim.g.maplocalleader = " " -- <space> again to localleader

-- navigate the windows with
bind({ "n", "i", "x", "t" }, "<M-j>", "<Cmd>wincmd W<CR>", opts)
bind({ "n", "i", "x", "t" }, "<M-k>", "<cmd>wincmd w<cr>", opts)
bind({ "n", "i", "x", "t" }, "<M-s>", "<cmd>wincmd v<cr>", opts)
bind({ "n", "i", "x", "t" }, "<M-q>", "<cmd>q!<cr>", opts)
-- resize windows with
bind({ "t", "n", "i", "v", "x" }, "<M-->", "<cmd>vertical resize -2<cr>", opts)
bind({ "t", "n", "i", "v", "x" }, "<M-=>", "<cmd>vertical resize +2<cr>", opts)

-- same mappings as in i3 and terminal
bind(
	{ "n", "v", "i", "x" },
	"<M-f>",
	"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
	opts
)
bind({ "n", "v", "i", "x" }, "<M-r>", "<cmd>Telescope oldfiles<cr>", opts) -- mapped to `r` recent
bind({ "n", "v", "i", "x" }, "<M-x>", "<cmd>NvimTreeToggle<CR>", opts) -- x for Xplorer
bind({ "n", "v", "i", "x" }, "<M-/>", "<cmd>Telescope live_grep theme=ivy<cr>", opts) -- ctl+slash
bind({ "n", "v", "i", "x" }, "<M-'>", "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>", opts)

-- misc
bind("i", "<c-c>", "<esc>", opts) -- better than reaching for esc.
bind("n", "U", "<C-r>", opts) --undo
bind("n", "Q", "@q", opts) -- quickmacro: call
bind("v", "p", '"_dP', opts) -- keeps registers content when pasting in visual mode

-- Stay in indent mode
bind("v", "<", "<gv", opts)
bind("v", ">", ">gv", opts)

-- less disorienting jumps.
bind({ "n", "v", "x" }, "<c-d>", "<c-d>zz", opts)
bind({ "n", "v", "x" }, "<c-u>", "<c-u>zz", opts)
bind({ "n", "v", "x" }, "<c-o>", "<c-o>zz", opts)
bind({ "n", "v", "x" }, "<c-i>", "<c-i>zz", opts)
bind({ "n", "v", "x" }, "n", "nzz", opts)
bind({ "n", "v", "x" }, "N", "Nzz", opts)

-- add relative line jumps to jumplist
bind("n", "j", 'v:count ? (v:count > 1 ? "m\'" .. v:count : "") .. "j" : "gj"', { expr = true, noremap = true })
bind("n", "k", 'v:count ? (v:count > 1 ? "m\'" .. v:count : "") .. "k" : "gk"', { expr = true, noremap = true })

-- lsp mappings
bind("n", "<M-h>", "<cmd>lua vim.lsp.buf.hover()<cr>", opts) -- help over keyword
bind("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
bind("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
bind("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
bind("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
bind("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
bind("n", "gn", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
bind("n", "gN", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
