local data_exists, custom_dasboard = pcall(require, "custom.dashboard")
if data_exists then
	if type(custom_dasboard) == "table" then
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
	end
else
	require("user.startify")
end
