-- 06 - presets
local lfs = require('lfs')
local dataPath = lfs.writedir() .. 'Data\\mdc\\'
local modPath = lfs.writedir() .. 'Mods\\tech\\mdc\\'

dofile(modPath..'mdc.lua')
dofile(dataPath..'mdc.lua')

headline(0, "PRESETS")

columns = 6
head(1, 0, "#")
head(1, 1, "FREQ")
multihead(1, 2, 1, 5, "NAME")

for i, preset in ipairs(mdc.presets) do
	cell(1 + i, 0, i)
	cell(1 + i, 1, preset.freq)
	multicell(1 + i, 2, 1 + i, 5, preset.name)
end
