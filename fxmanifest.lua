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
	'@ox_lib/init.lua',
	'@oxmysql/lib/MySQL.lua',
	'source/shared/init.lua',
}

server_scripts {
	'source/server/init.lua',
}

dependencies {
	'ox_lib',-- requires at least version 3.0.1 https://github.com/overextended/ox_lib/releases
	'esx_datastore',-- https://github.com/esx-framework/esx_datastore
    '/server:6129',-- requires at least server build 6129
    '/onesync',-- requires onesync to be enabled
}