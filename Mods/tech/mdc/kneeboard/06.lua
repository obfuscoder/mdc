-- 5
local lfs = require('lfs')
local dataPath = lfs.writedir() .. 'Data\\mdc\\'
local modPath = lfs.writedir() .. 'Mods\\tech\\mdc\\'

dofile(modPath..'mdc.lua')
dofile(dataPath..'mdc.lua')

headline(0, "RAMROD")

columns = 10
for i = 1, string.len(mdc.ramrod) do
	head(1, i-1, i-1)
	cell(2, i-1, string.sub(mdc.ramrod, i, i))
end
