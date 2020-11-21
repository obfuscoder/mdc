-- 05 - other flights
local lfs = require('lfs')
local dataPath = lfs.writedir() .. 'Data\\mdc\\'
local modPath = lfs.writedir() .. 'Mods\\tech\\mdc\\'

dofile(modPath..'mdc.lua')
dofile(dataPath..'mdc.lua')

headline(0, "OTHER FLIGHTS")

columns = 10
multihead(1, 0, 1, 1, "CALLSIGN")
multihead(1, 2, 1, 3, "MISSION")
multihead(1, 4, 1, 5, "AIRFRAME")
head(1, 6, "FREQ")
head(1, 7, "TCN")
head(1, 8, "GRP")
head(1, 9, "LSR")

for i, flight in ipairs(mdc.other) do
	multicell(2*i, 0, 2*i, 1, flight.callsign)
	multicell(2*i, 2, 2*i, 3, flight.mission)
	multicell(2*i, 4, 2*i, 5, flight.airframe)
	cell(2*i, 6, flight.comms)
	cell(2*i, 7, flight.tacan)
	cell(2*i, 8, flight.group_id)
	cell(2*i, 9, flight.laser_mask)

	head(2*i + 1, 1, "AO")
	multicell(2*i + 1, 2, 2*i + 1, 4, flight.ao)
	head(2*i + 1, 5, "TASK")
	multicell(2*i + 1, 6, 2*i + 1, 9, flight.task)
end
