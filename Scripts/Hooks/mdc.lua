net.log("MDC - loaded.")

local mdc = {}
mission = ""
unit = ""
lastchange = 0

local lfs = require('lfs')

package.path = package.path .. ";" .. lfs.writedir() .. "Mods\\tech\\mdc\\?.lua" .. ";.\\LuaSocket\\?.lua;"

dofile(lfs.writedir() .. "Config\\mdc.lua")

local http = require("socket.http")

local num_scripts = 6

local copyScripts = function()
	net.log("MDC - Installing kneeboard scripts")
	for i = 1, num_scripts do
		local inFile = io.open(lfs.writedir() .. "Mods\\tech\\mdc\\kneeboard\\" .. i .. ".lua", "r")
		local outFile = io.open(lfs.writedir() .. "KNEEBOARD\\" .. i .. ".lua", "w")
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

local downloadData = function()
	local outputFile = io.open(lfs.writedir() .. "Data\\mdc\\mdc.lua", "w")
	result, code, headers = http.request(config.url)
	outputFile:write(result)
	outputFile:close()
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
