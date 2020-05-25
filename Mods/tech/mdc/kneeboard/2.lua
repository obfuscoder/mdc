-- 2
local lfs = require('lfs')
local dataPath = lfs.writedir() .. 'Data\\mdc\\'
local modPath = lfs.writedir() .. 'Mods\\tech\\mdc\\'

dofile(modPath..'mdc.lua')
dofile(dataPath..'mdc.lua')

headline(0, "FLIGHTPLAN")

columns = 20
head(1, 0, "#")
multihead(1, 1, 1, 5, "NAME")
multihead(1, 6, 1, 15, "POSITION")
multihead(1, 16, 1, 17, "ALT")
multihead(1, 18, 1, 19, "TOT")

for i, wp in ipairs(mdc.waypoints) do
	cell(1+i, 0, i)
	multicell(1+i, 1, 1+i, 5, wp.name)
	multicell(1+i, 6, 1+i, 15, wp.coords)
	multicell(1+i, 16, 1+i, 17, wp.alt)
	multicell(1+i, 18, 1+i, 19, wp.tot)
end

local base_row = table.getn(mdc.waypoints) + 3

headline(base_row, "COMMS")

head(base_row + 1, 0, "#")
multihead(base_row + 1, 1, base_row + 1, 19, "USAGE")

for i, comms in ipairs(mdc.comms) do
	cell(base_row + 1 + i, 0, i)
	multicell(base_row + 1 + i, 1, base_row + 1 + i, 19, comms)
end
