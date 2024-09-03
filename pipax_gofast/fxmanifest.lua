fx_version 'cerulean'
games { 'gta5' }

author 'pipax91'
description 'GO FAST'
version '2.0.0'
discord 'https://discord.gg/FXTuCZdCkY'

shared_scripts {
    '@es_extended/imports.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}

dependencies {
    'es_extended',
    'mysql-async'
}