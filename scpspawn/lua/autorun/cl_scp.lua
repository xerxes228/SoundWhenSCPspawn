--[[
Addon maked by https://steamcommunity.com/id/ame0nna/
Base and original addon writed by https://steamcommunity.com/sharedfiles/filedetails/?id=1396785547
Thanks for help to solve bug: https://netzona.org/members/racc0on.14267/
]]--
if CLIENT then
	
	net.Receive("Announcedeconf",function(len,ply)

		local stringscp = net.ReadString()

		--EmitSound(stringscp,LocalPlayer():GetPos())
		--EmitSound( Sound( stringscp ), LocalPlayer():GetPos(), 1, CHAN_AUTO, 1, 75, 0, 100 )

		RunConsoleCommand("play",Sound( stringscp ))

	end)

end