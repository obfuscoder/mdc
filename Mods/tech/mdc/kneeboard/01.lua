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

columns = 6
headline(19, "TOLD")
head(20, 0, "")
head(20, 1, "TAKEOFF")
head(20, 2, "TARGET")
head(20, 3, "JOKER")
head(20, 4, "BINGO")
head(20, 5, "LAND")

head(21, 0, "FUEL")
cell(21, 1, mdc.told.fuel.takeoff)
cell(21, 2, mdc.told.fuel.target)
cell(21, 3, mdc.told.fuel.joker)
cell(21, 4, mdc.told.fuel.bingo)
cell(21, 5, mdc.told.fuel.land)

columns = 11
headline(23, "AIRBASES")

head(24, 0, "")
multihead(24, 1, 24, 3, "NAME")
head(24, 4, "TCN")
head(24, 5, "ATIS")
head(24, 6, "GND")
head(24, 7, "TWR")
head(24, 8, "RWY")
head(24, 9, "ELEV")
head(24, 10, "ILS")

for i, airbase in ipairs(mdc.airbases) do
	head(24+i, 0, airbase.type)
	multicell(24+i, 1, 24+i, 3, airbase.name)
	cell(24+i, 4, airbase.tcn)
	cell(24+i, 5, airbase.atis)
	cell(24+i, 6, airbase.ground)
	cell(24+i, 7, airbase.tower)
	cell(24+i, 8, airbase.runway)
	cell(24+i, 9, airbase.elevation)
	cell(24+i, 10, airbase.ils)
end
