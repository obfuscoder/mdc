net.log("MDC - loaded.")

local mdc = {}
mission = ""
unit = ""
lastchange = 0

local lfs = require('lfs')

package.path = package.path .. ";" .. lfs.writedir() .. "Mods\\tech\\mdc\\?.lua" .. ";.\\LuaSocket\\?.lua;"

dofile(lfs.writedir() .. "Config\\mdc.lua")

local http = require("socket.http")

local num_scripts = 12

local copyScripts = function()
	net.log("MDC - Installing kneeboard scripts")
	for i = 1, num_scripts do
		-- DCS uses the file "1" as default page when opening KB for the first time.
		-- All kneeboard files in the same folder are sorted alphabetically.
		-- To let the other pages follow the first one, we have to prepend "2"
		local inFilePath = lfs.writedir() .. "Mods\\tech\\mdc\\kneeboard\\" .. string.format("%02d", i) .. ".lua"
		local outFilePath = lfs.writedir() .. "KNEEBOARD\\2-" .. string.format("%02d", i) .. ".lua"
		if i == 1 then
			outFilePath = lfs.writedir() .. "KNEEBOARD\\1.lua"
		end
		local inFile = io.open(inFilePath, "r")
		local outFile = io.open(outFilePath, "w")
		local content = inFile:read("*all")
		inFile:close()
		outFile:write(content)
		outFile:close()
	end
end

local deleteScripts = function()
	net.log("MDC - deleting kneeboard scripts")
	for i = 1, num_scripts do
		os.remove(lfs.writedir() .. "KNEEBOARD\\" .. i .. ".lua")
	end
end

local downloadToFile = function(url, path)
	net.log("MDC - downloading " .. url .. " to " .. path)
	local outputFile = io.open(path, "w")
	result, code, headers = http.request(url)
	outputFile:write(result)
	outputFile:close()
end

local downloadData = function()
	local dataPath = lfs.writedir() .. 'Data\\mdc\\'
	local dataFilePath = dataPath .. "mdc.lua"
	downloadToFile(config.url, dataFilePath)
	net.log("MDC - downloaded and installed")
end

mdc.onMissionLoadEnd = function()
	net.log("MDC - onMissionLoadEnd")

	if DCS.isMultiplayer() then
		copyScripts()
	else
		deleteScripts()
	end
end

mdc.onShowBriefing = function()
	net.log("MDC - onShowBriefing")
	unit = "*"
	lastchange = DCS.getRealTime()
end

mdc.onPlayerChangeSlot = function(id)
	net.log("MDC - onPlayerChangeSlot(id="..id..")")
	if id == net.get_my_player_id() then
		local slotid = net.get_player_info(id, "slot")
		net.log("MDC - Multiplayer id: " .. tostring(id))
		net.log("MDC - Slot id: "  .. tostring(slotid))
		unit = DCS.getUnitProperty(slotid, DCS.UNIT_TYPE)
		net.log("MDC - unit: "  .. tostring(unit))
		lastchange = DCS.getRealTime()
		downloadData()
	end
end

DCS.setUserCallbacks(mdc)
net.log("MDC - initialized.")
