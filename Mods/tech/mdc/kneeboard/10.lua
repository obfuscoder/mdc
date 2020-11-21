-- 10 - departure procedure
local lfs = require('lfs')
local dataPath = lfs.writedir() .. 'Data\\mdc\\'
local modPath = lfs.writedir() .. 'Mods\\tech\\mdc\\'

dofile(modPath..'mdc.lua')
dofile(dataPath..'mdc.lua')

plate(dataPath .. '/plates/' .. mdc.plates.departure.procedure)
