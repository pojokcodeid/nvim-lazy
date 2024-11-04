_G.idxOf = function(array, value)
	for i, v in ipairs(array) do
		if v == value then
			return i
		end
	end
	return nil
end

_G.LAZYGIT_TOGGLE = function()
	local ok = pcall(require, "toggleterm")
	if not ok then
		require("notify")("toggleterm not found!", "error")
		return
	end
	local Terminal = require("toggleterm.terminal").Terminal
	local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
	lazygit:toggle()
end

_G.substring = function(text, key)
	local index, _ = string.find(text, key)
	if index then
		return true
	else
		return false
	end
end

_G.all_trim = function(s)
	return s:match("^%s*(.-)%s*$")
end

_G.current_theme = function()
	if pcode.themes then
		local theme = ""
		for _, value in pairs(pcode.themes or {}) do
			theme = value
		end
		return all_trim(theme)
	end
	return ""
end

local function safeRequire(module)
	local ok, result = pcall(require, module)
	if ok then
		return result
	end
end

safeRequire("pcode.user.options")
safeRequire("pcode.user.autocmd")
safeRequire("pcode.user.keymaps")
return {}
