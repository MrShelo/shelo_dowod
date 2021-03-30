
fx_version "bodacious"
games {"gta5"}

client_script 'client.lua'

server_scripts {

  '@mysql-async/lib/MySQL.lua',
  'server.lua'

}

dependencies {
	'es_extended',
	'esx_society',
	'esx_license',
	'mythic_progbar',
	'pNotify'
}
