local status_ok, dressing = pcall(require, "dressing")
if not status_ok then
	return
end

dressing.setup({
	input = {
		title_pos = "center",
		relative = "editor",
		default_prompt = "➤ ",
		win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" },
		prefer_width = 30,
		max_width = { 140, 0.9 },
		min_width = { 50, 0.2 },
	},
	select = {
		backend = { "telescope", "builtin" },
		builtin = { win_options = { winhighlight = "Normal:Normal,NormalNC:Normal" } },
	},
})
