local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	use({ "wbthomason/packer.nvim"}) -- Have packer manage itself
	use({ "nvim-lua/plenary.nvim"}) -- Useful lua functions used by lots of plugins
	use({ "windwp/nvim-autopairs"}) -- Autopairs, integrates with both cmp and treesitter
	use({ "numToStr/Comment.nvim"})
	use({ "JoosepAlviste/nvim-ts-context-commentstring"})
	use({ "kyazdani42/nvim-web-devicons"})
	use({ "kyazdani42/nvim-tree.lua"})
	use({ "moll/vim-bbye"})
	use({ "nvim-lualine/lualine.nvim"})
	use({ "ahmedkhalf/project.nvim"})
	use({ "lewis6991/impatient.nvim"})
	use({ "lukas-reineke/indent-blankline.nvim"})
	use({ "folke/which-key.nvim" })
    use ({'mbbill/undotree'})
	use({ "norcalli/nvim-colorizer.lua" })

	-- Colorschemes
	use({ "ellisonleao/gruvbox.nvim" })
	-- use({ "ishan9299/nvim-solarized-lua" })
    use ({'overcache/NeoSolarized'})

	-- Cmp
	use({ "hrsh7th/nvim-cmp"}) -- The completion plugin
	use({ "hrsh7th/cmp-buffer"}) -- buffer completions
	use({ "hrsh7th/cmp-path"}) -- path completions
	use({ "saadparwaiz1/cmp_luasnip"}) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp"})
	use({ "hrsh7th/cmp-nvim-lua"})

	-- Snippets
	use({ "L3MON4D3/LuaSnip"}) --snippet engine
	use({ "rafamadriz/friendly-snippets"}) -- a bunch of snippets to use

	-- LSP
	use({ "VonHeikemen/lsp-zero.nvim" })
	use({ "neovim/nvim-lspconfig"}) -- enable LSP
	use({ "williamboman/mason.nvim"}) -- simple to use language server installer
	use({ "williamboman/mason-lspconfig.nvim"})
	use({ "jose-elias-alvarez/null-ls.nvim"}) -- for formatters and linters
	use({ "RRethy/vim-illuminate"})
	use({ "folke/trouble.nvim", requires = "nvim-tree/nvim-web-devicons" }) -- problems panel

    -- language specifics
	use({ "lervag/vimtex" })
	use({ "dhruvasagar/vim-table-mode" })
    use({"LhKipp/nvim-nu"})
    use{("simrat39/rust-tools.nvim")}
    use {'nvim-orgmode/orgmode'}

	-- Telescope
	use({ "nvim-telescope/telescope.nvim"})
	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		commit = "8e763332b7bf7b3a426fd8707b7f5aa85823a5ac",
	})

	-- Git
    use ({"tpope/vim-fugitive"})

    -- improve vim editing defaults
	use("ggandor/leap.nvim") -- direct jumps with: s
    use("ggandor/flit.nvim") -- f & t: improved
	use("tpope/vim-surround") -- operator mode delimiter manipulation.
	use("andymass/vim-matchup") -- improves `%`
    use ({"tpope/vim-repeat"}) -- makes the `.` work with plugins

	-- debugging
	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
