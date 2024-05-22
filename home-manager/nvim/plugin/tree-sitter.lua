require('nvim-treesitter.install').prefer_git = true

require('nvim-treesitter.configs').setup {
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	}
}
