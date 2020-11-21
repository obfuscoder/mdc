-- 07 - crypto
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

headline(3, "DRYAD")

columns = 11
head(4, 0, "")
for i, header in ipairs(mdc.dryad.header) do
	head(4, i, i - 1)
end

for i, row in ipairs(mdc.dryad.rows) do
	head(4 + i, 0, row.header)
	for j, col in ipairs(row.columns) do
		cell(4 + i, j, col)
	end
end
