fx_version 'cerulean'
game 'gta5'
author '<Discord : Errorism#0009>, <Website : https://script.errorism.cc>'
description 'This resource is created by Errorism\'s Scripts'
lua54 'yes'

files {
	'locales/*.json',
	'config/shared_cfg.lua',
}

ui_page 'source/web/index.html'

shared_scripts {
	'@oxmysql/lib/MySQL.lua',
	'source/shared/init.lua',
}

server_scripts {
	'source/server/init.lua',
}

dependencies {
	'oxmysql', -- (https://github.com/overextended/oxmysql)
	'es_extended',-- (https://github.com/esx-framework/esx_core)
	'esx_ambulancejob',-- (https://github.com/esx-framework/esx_ambulancejob)
	'esx_datastore',-- (https://github.com/esx-framework/esx_datastore)
}