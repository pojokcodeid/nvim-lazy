local sources = {}
local dap_data = pcode.dap_ensure_installed or {}
for _, nullls in pairs(dap_data) do
	table.insert(sources, nullls)
end
require("mason").setup()
require("mason-nvim-dap").setup({
	ensure_installed = sources,
	automatic_setup = true,
	handlers = {
		function(config)
			-- all sources with no handler get passed here

			-- Keep original functionality
			require("mason-nvim-dap").default_setup(config)
		end,
	},
})
