local data_exists, frmt = pcall(require, "custom.format_onsave")
if not data_exists then
	require("user.format_onsave")
end
if frmt.disable == 0 then
	require("user.format_onsave")
end
