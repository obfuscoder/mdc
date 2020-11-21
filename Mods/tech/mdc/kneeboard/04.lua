-- 04 - support
local lfs = require('lfs')
local dataPath = lfs.writedir() .. 'Data\\mdc\\'
local modPath = lfs.writedir() .. 'Mods\\tech\\mdc\\'

dofile(modPath..'mdc.lua')
dofile(dataPath..'mdc.lua')

headline(0, "SUPPORT")

columns = 6
headline(1, "TANKER")
multihead(2, 0, 2, 1, "CALLSIGN")
head(2, 2, "TCN")
head(2, 3, "FREQ")
head(2, 4, "ALT")
head(2, 5, "TAS")

for i, tanker in ipairs(mdc.support.tanker) do
	multicell(2*i + 1, 0, 2*i + 1, 1, tanker.callsign)
	cell(2*i + 1, 2, tanker.tacan)
	cell(2*i + 1, 3, tanker.comms)
	cell(2*i + 1, 4, tanker.altitude)
	cell(2*i + 1, 5, tanker.speed)

	head(2*i + 2, 1, "POS")
	multicell(2*i + 2, 2, 2*i + 2, 5, tanker.position)
end

local base_row = 2 * table.getn(mdc.support.tanker) + 3

columns = 10
headline(base_row, "AWACS")
multihead(base_row + 1, 0, base_row + 1, 1, "CALLSIGN")
head(base_row + 1, 2, "FREQ")
head(base_row + 1, 3, "ALT")
multihead(base_row + 1, 4, base_row + 1, 9, "POS")

for i, awacs in ipairs(mdc.support.awacs) do
	multicell(base_row + 1 + i, 0, base_row + 1 + i, 1, awacs.callsign)
	cell(base_row + 1 + i, 2, awacs.comms)
	cell(base_row + 1 + i, 3, awacs.altitude)
	multicell(base_row + 1 + i, 4, base_row + 1 + i, 9, awacs.position)
end

base_row = 2 * table.getn(mdc.support.tanker) + table.getn(mdc.support.awacs) + 5

headline(base_row, "FAC")
multihead(base_row + 1, 0, base_row + 1, 1, "CALLSIGN")
head(base_row + 1, 2, "FREQ")
head(base_row + 1, 3, "ELEV")
multihead(base_row + 1, 4, base_row + 1, 9, "POS")

for i, fac in ipairs(mdc.support.fac) do
	multicell(base_row + 1 + i, 0, base_row + 1 + i, 1, fac.callsign)
	cell(base_row + 1 + i, 2, fac.comms)
	cell(base_row + 1 + i, 3, fac.altitude)
	multicell(base_row + 1 + i, 4, base_row + 1 + i, 9, fac.position)
end
