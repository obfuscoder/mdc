-- 08 - navaids
local lfs = require('lfs')
local dataPath = lfs.writedir() .. 'Data\\mdc\\'
local modPath = lfs.writedir() .. 'Mods\\tech\\mdc\\'

dofile(modPath..'mdc.lua')
dofile(dataPath..'mdc.lua')

headline(0, "NAVAIDS")

columns = 12

head(1, 0, "ID")
multihead(1, 1, 1, 4, "NAME")
head(1, 5, "TCN")
multihead(1, 6, 1, 10, "POSITION")
head(1, 11, "ELEV")

for i, item in ipairs(mdc.navaids) do
	cell(1 + i, 0, item.id)
	multicell(1 + i, 1, 1 + i, 4, item.name)
	cell(1 + i, 5, item.tcn)
	multicell(1 + i, 6, 1 + i, 10, item.pos)
	cell(1 + i, 11, item.elev)
end
