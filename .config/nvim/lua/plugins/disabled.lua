-- Path ~/.config/nvim/lua/plugins/disabled.lua

-- Tanner Weber
-- tannerw@pdx.edu

return {
	-- change trouble config
	{
		"folke/trouble.nvim",
		-- opts will be merged with the parent spec
		opts = { use_diagnostic_signs = true },
	},

	{ "folke/trouble.nvim",      enabled = false },
	-- disabling LazyVim plugins
	{ "folke/noice.nvim",        enabled = false },
	{ "nvim-lua/plenary.nvim",   enabled = false },
	{ "MagicDuck/grug-far.nvim", enabled = false },
	{ "MunifTanjim/nui.nvim",    enabled = false },
	{ "stevearc/conform.nvim",   enabled = false },
}
