local status_ok, navic = pcall(require, "nvim-navic")
if not status_ok then
	return
end

local ico = require("user.icons")
local icons = ico.kind

navic.setup({
	icons = {
		Array = icons.Array .. " ",
		Boolean = icons.Boolean,
		Class = icons.Class .. " ",
		Color = icons.Color .. " ",
		Constant = icons.Constant .. " ",
		Constructor = icons.Constructor .. " ",
		Enum = icons.Enum .. " ",
		EnumMember = icons.EnumMember .. " ",
		Event = icons.Event .. " ",
		Field = icons.Field .. " ",
		File = icons.File .. " ",
		Folder = icons.Folder .. " ",
		Function = icons.Function .. " ",
		Interface = icons.Interface .. " ",
		Key = icons.Key .. " ",
		Keyword = icons.Keyword .. " ",
		Method = icons.Method .. " ",
		Module = icons.Module .. " ",
		Namespace = icons.Namespace .. " ",
		Null = icons.Null .. " ",
		Number = icons.Number .. " ",
		Object = icons.Object .. " ",
		Operator = icons.Operator .. " ",
		Package = icons.Package .. " ",
		Property = icons.Property .. " ",
		Reference = icons.Reference .. " ",
		Snippet = icons.Snippet .. " ",
		String = icons.String .. " ",
		Struct = icons.Struct .. " ",
		Text = icons.Text .. " ",
		TypeParameter = icons.TypeParameter .. " ",
		Unit = icons.Unit .. " ",
		Value = icons.Value .. " ",
		Variable = icons.Variable .. " ",
	},
	highlight = true,
	separator = " " .. ico.ui.ChevronRight .. " ",
	depth_limit = 0,
	depth_limit_indicator = "..",
})
