return {
	"kyazdani42/nvim-web-devicons",
	lazy = true,
	dependencies = "pojokcodeid/nvim-material-icon",
	opts = function()
		local material_icon_ok, material_icon = pcall(require, "nvim-material-icon")
		if not material_icon_ok then
			return
		end
		material_icon.setup({
			override = {},
		})
		return {
			override = material_icon.get_icons(),
			override_by_filename = {},
		}
	end,
	config = function(_, opts)
		require("nvim-web-devicons").setup(opts)
	end,
}
