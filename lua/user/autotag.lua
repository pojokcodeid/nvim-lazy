local status_ok, cfg = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

cfg.setup({
	autotag = {
		enable = true,
	},
})
