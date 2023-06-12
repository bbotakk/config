-- Init.lua is the file that is run by neovim on startup, thus here you state which other files should be evaluated (files containing plugin configuration, options, keybindings, etc...).
-- You can add configuration straight to this file, but it is better practice to have an individual file for each plugin, located under `user`
-- to add a new plugin eg. named xyz:
    -- 1. add the line `use = {'xyz'}` to the file `user/plugins.lua`. Under the section where all the other plugins are installed
    -- 2. create a file under `user` and call it `xyz.lua` there goes all the configuration for the plugin. 
    -- 3. add a line to this file : `require "user/xyz` 
require "user.plugins"
require "user.options"
require "user.keybindings"
require "user.colorscheme"
require "user.cmp"
require "user.lsp"
require "user.telescope"
require "user.gitsigns"
require "user.treesitter"
require "user.autopairs"
require "user.comment"
require "user.nvim-tree"
require "user.lualine"
require "user.project"
require "user.impatient"
require "user.indentline"
require "user.whichkey"
require "user.matchup"
require "user.dap"
require "user.vimtex"
require "user.colorizer"
require "user.leap"
require "user.flit"
require "user.rust-tools"
require "user.nu"
require "user.orgmode"
