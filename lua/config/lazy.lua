local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.diagnostic.config({ virtual_lines = false })
require("lazy").setup({
	spec = {
		{ import = "plugins" },
		{ import = "custom.plugins" },
	},
	defaults = {
		lazy = true, -- every plugin is lazy-loaded by default
		version = "*", -- try installing the latest stable version for plugins that support semver
	},
	ui = { border = "rounded", browser = "chrome", throttle = 40, custom_keys = { ["<localleader>l"] = false } },
	change_detection = { enabled = false, notify = false },
	checker = { enabled = true }, -- automatically check for plugin updates
	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
				"lazyredraw",
			},
		},
	},
})
