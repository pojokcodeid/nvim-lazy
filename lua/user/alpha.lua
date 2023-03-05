local data_exists, custom_dasboard = pcall(require, "core.config")
if data_exists then
	local model = custom_dasboard.model
	if model ~= nil then
		if model == 1 then
			require("user.startify")
		else
			require("user.dashboard")
		end
	else
		require("user.startify")
	end
else
	require("user.startify")
end
