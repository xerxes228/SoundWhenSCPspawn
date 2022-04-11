# SoundWhenSCPspawn
play sound when scp job spawned

Если нужно вписать свои профессии вместо тех, которые уже созданы:
Открываем sv_scp.lua
после брекета }, делаем отступ и вписываем следующее
		["имя профессии (НЕ TEAM_...)"] = { 
			Disconnect = 0, 
			Deconf = 0, 
			Here = 0,
			Announce = 0, 
			sound = "detectdeconf/scp/049.mp3", <-- путь к mp3 файлу
			Disabled = 0,
		},
    
   Значения 0 не трогаем!!!!!!!!
   
   Локал penis=1 не трогаем, так как это нужно чисто чтоб срабатывала Local function (без него не работает)
