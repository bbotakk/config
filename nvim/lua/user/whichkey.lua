-- use [""] when mapping a special char
local mappings = {
	["'"] = {
		"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
		"Buffers",
	},
    w = {"<cmd>w<cr>", "write buffer"},
    W = {"<cmd>wa<cr>", "write all"},
	q = { "<cmd>w<cr><cmd>bd!<CR>", "quit buffer" },
	Q = { "<cmd>wa<cr><cmd>qa<cr>", "quit all" },
	p = { "<cmd>TroubleToggle<CR>", "problems" },
    n = { "<cmd>nohl<cr>", "nohighlight"},
    u = { "<cmd>UndotreeToggle<CR>", "undotree" },
    N = {
        name = "notes",
        t = {"<cmd>ObsidianToday<cr>", "Today"},
        y = {"<cmd>ObsidianYesterday<cr>", "Yesterday"},
        d = {"<cmd>ObsidianSearch<cr>", "Search"},
        l = {"<cmd>ObsidianOpen<cr>", "launch"},
        s = {"<cmd>ObsidianQuickSwitch<cr>", "QuickSwitch"},
        n = {"<cmd>ObsidianNew<cr>", "New"},
    },
	["="] = { "<cmd>lua vim.lsp.buf.format{async=true}<CR>", "format" },
	f = {
		name = "file",
    -- note we use prefix in order to make the user use the shortcut without leader. (because the it is the same as in the terminal)
		["<M-f>"] = {
			"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<CR>",
			"find file",
		},
		["<M-x>"] = { "<cmd>NvimTreeToggle<CR>", "file explorer" },
		["<M-r>"] = { "<cmd>Telescope oldfiles<cr>", "recent files" },
		p = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
        x = {"<cmd>!chmod +x %<cr>", "make executeable"},
	},
    [";"] = {
        name = "commands",
        d = {"<cmd>set background=dark<cr>", "background: dark"},
        l = {"<cmd>set background=light<cr>", "background: light"},
        i = {"<cmd>IndentBlanklineToggle<cr>", "indent indicator: toggle"},
        c = {"<cmd>ColorizerToggle<cr>", "colorizer: toggle"},
    },
	H = {
		name = "help",
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		k = { "<cmd>Telescope keymaps<cr>", "Keybindings" },
		c = { "<cmd>Telescope commands<cr>", "Commands" },
		r = { "<cmd>Telescope registers<cr>", "Registers" },
	},
	G = {
		name = "Git",
        p = {"<cmd>Git push<cr>", "push"},
        P = {"<cmd>Git commit -am 'sync'<cr><cmd>Git push<cr>", "commit all & push" }
	},
	C = {
		name = "code",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = {
			"<cmd>Telescope diagnostics bufnr=0<cr>",
			"Document Diagnostics",
		},
		w = {
			"<cmd>Telescope diagnostics<cr>",
			"Workspace Diagnostics",
		},
		["="] = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
		R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
	},
	D = {
		name = "Debug",
		b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
		c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
		i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
		o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
		O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
		r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
		l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
		u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
		x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
	},
}

local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local opts = {
	mode = { "n", "v" }, -- NORMAL mode && VISUAL mode
	prefix = "<leader>", -- leader key is defined in keymaps.lua
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

which_key.setup(setup)
which_key.register(mappings, opts)
