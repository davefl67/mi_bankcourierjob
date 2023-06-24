-- FX Information
fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

-- Resource Information
name 'mi_worktemplate'
author 'MI_Agimir'
version '1.0.0'
repository 'https://github.com/MIAgimir/MI_WorkTemplate'
description 'Need work? Make a job'

-- Manifest
shared_scripts {
	'@ox_lib/init.lua',
    'shared/jobs.lua',
	'shared/config.lua'
}

client_scripts {
    '@ox_core/imports/client.lua',
    'client/peds/*.lua',
    'client/tasks/*.lua',
    'client/util.lua',
    'client/main.lua'
}

export 'g6sworkphonemenu'


server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@ox_core/imports/server.lua',
    'server/vehicle.lua',
    'server/paycheck.lua',
    'server/main.lua'
}

