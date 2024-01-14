---@diagnostic disable: undefined-global
fx_version 'cerulean'
game 'gta5'
description 'tofu-dynamic-water'
version '0.0.1'

client_scripts {
	'client/*.lua',
}

files {
	-- default water.xml from OpenIV
	-- 'water.xml',
	-- custom water.xml that floods the entire map
	'flood.xml'
}

-- This must be set to the XML file loaded. If you omit this attribute Peds & Vehicles etc.. won't be affected by Water
-- and they will continue to drive and walk around underwater.
data_file 'WATER_FILE' 'flood.xml'
