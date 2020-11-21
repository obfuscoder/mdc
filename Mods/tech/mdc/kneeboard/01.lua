-- 01 - lineup/loadout/procedures
local lfs = require('lfs')
local dataPath = lfs.writedir() .. 'Data\\mdc\\'
local modPath = lfs.writedir() .. 'Mods\\tech\\mdc\\'

dofile(modPath..'mdc.lua')
dofile(dataPath..'mdc.lua')

headline(0, "MISSION DATA CARD")

columns = 4
head(1, 0, "OPORD #")
head(1, 1, "CALLSIGN")
head(1, 2, "MISSION")
head(1, 3, "DATETIME")

cell(2, 0, mdc.number)
cell(2, 1, mdc.callsign)
cell(2, 2, mdc.mission)
cell(2, 3, mdc.time)

columns = 8
head(3, 0, "TASK")
head(3, 7, "FREQ")
head(4, 0, "AO")

multicell(3, 1, 3, 6, mdc.task)
multicell(4, 1, 4, 6, mdc.ao)
cell(4, 7, mdc.frequency)

columns = 2
head(5, 0, "DEPARTURE")
head(5, 1, "RECOVERY")

cell(6, 0, mdc.departure)
cell(6, 1, mdc.recovery)

columns = 11
head(7, 0, "#")
multihead(7, 1, 7, 3, "CALLSIGN")
multihead(7, 4, 7, 6, "PILOT")
head(7, 7, "IFF")
head(7, 8, "TCN")
head(7, 9, "LSR")
head(7, 10, "NET")

for i, slot in ipairs(mdc.slots) do
	cell(7+i, 0, i)
	multicell(7+i, 1, 7+i, 3, slot.callsign)
	multicell(7+i, 4, 7+i, 6, slot.pilot)
	cell(7+i, 7, slot.iff)
	cell(7+i, 8, slot.tcn)
	cell(7+i, 9, slot.laser)
	cell(7+i, 10, slot.netid)
end

columns = 12
headline(13, "LOADOUT")
head(14, 0, "A/A")
head(14, 9, "GUN")
head(15, 0, "A/G")
head(15, 9, "CHF")
head(16, 0, "POD")
head(16, 9, "FLR")
head(17, 0, "TKS")
head(17, 9, "FUL")

multicell(14, 1, 14, 9, mdc.loadout.a2a)
multicell(15, 1, 15, 9, mdc.loadout.a2g)
multicell(16, 1, 16, 9, mdc.loadout.pod)
multicell(17, 1, 17, 9, mdc.loadout.tks)

multicell(14, 10, 14, 11, mdc.loadout.gun)
multicell(15, 10, 15, 11, mdc.loadout.chf)
multicell(16, 10, 16, 11, mdc.loadout.flr)
multicell(17, 10, 17, 11, mdc.loadout.fuel)

columns = 11
headline(19, "AIRBASES")

head(20, 0, "")
multihead(20, 1, 20, 3, "NAME")
head(20, 4, "TCN")
head(20, 5, "ATIS")
head(20, 6, "GND")
head(20, 7, "TWR")
head(20, 8, "RWY")
head(20, 9, "ELEV")
head(20, 10, "ILS")

for i, airbase in ipairs(mdc.airbases) do
	head(20+i, 0, airbase.type)
	multicell(20+i, 1, 20+i, 3, airbase.name)
	cell(20+i, 4, airbase.tcn)
	cell(20+i, 5, airbase.atis)
	cell(20+i, 6, airbase.ground)
	cell(20+i, 7, airbase.tower)
	cell(20+i, 8, airbase.runway)
	cell(20+i, 9, airbase.elevation)
	cell(20+i, 10, airbase.ils)
end
