--[[
Addon re-maked by https://steamcommunity.com/id/ame0nna/
Base and original addon writed by https://steamcommunity.com/sharedfiles/filedetails/?id=1396785547
	original addon: https://steamcommunity.com/sharedfiles/filedetails/?id=1396785547
Thanks for help to solve bug: https://netzona.org/members/racc0on.14267/
]]--

if SERVER then

	util.AddNetworkString("Announcedeconf")

	resource.AddFile("sound/detectdeconf/scp/008.mp3")
	resource.AddFile("sound/detectdeconf/scp/049.mp3")
	resource.AddFile("sound/detectdeconf/scp/066.mp3")
	

	local StatusSCP = {
		["SCP-008-1"] = {
			Disconnect = 0, -- dont modify "0" ALL values
			Deconf = 0,
			Here = 0, 
			Announce = 0, 
			sound = "detectdeconf/scp/008.mp3", 
			Disabled = 0, 
		},
		["SCP-049"] = { 
			Disconnect = 0, 
			Deconf = 0, 
			Here = 0,
			Announce = 0, 
			sound = "detectdeconf/scp/049.mp3",
			Disabled = 0,
		},
	}

	local penis = 1

	local function DeconfACTION(team,deconf,name)

		if not timer.Exists("TimerBeforeReLaunch" .. team) then

			if StatusSCP[name]["Announce"] == 0 then

				StatusSCP[name]["Announce"] = 1

				net.Start("Announcedeconf")
				net.WriteString(StatusSCP[name]["sound"])
				net.Broadcast()
				timer.Create("TimerBeforeReLaunch" .. team,10,1,function()  end)
				

				print("test")

			end

		end

	end

	local function ReconfACTION(team,deconf,name)
		if StatusSCP[name]["Deconf"] == 1 then
			StatusSCP[name]["Deconf"] = 0
			StatusSCP[name]["Announce"] = 0
		end
	end
	


	local function ThinkScpSound()
		if penis == 1 then
			for k, v in pairs(player.GetAll()) do
				if StatusSCP[team.GetName(v:Team())] != nil then
				if StatusSCP[team.GetName(v:Team())]["Disabled"] == 0 then
					if StatusSCP[team.GetName(v:Team())]["Disconnect"] == 0 then
						if v:Alive() then
							StatusSCP[team.GetName(v:Team())]["Deconf"] = 1
							DeconfACTION(v:Team(), 1,team.GetName(v:Team()))
 
						elseif StatusSCP[team.GetName(v:Team())]["Deconf"] == 1 then
							ReconfACTION(v:Team(), 1,team.GetName(v:Team()))
							StatusSCP[team.GetName(v:Team())]["Deconf"] = 0
						end
					end
				end
				end
			end
		end
	end
	hook.Add("Think","ThinkScpSound",ThinkScpSound)


	local function SCPISHERE(ply, before, after)

		if IsValid(ply) then
			
			if StatusSCP[team.GetName(after)] != nil then
				
				StatusSCP[team.GetName(after)]["Here"] = 1
				StatusSCP[team.GetName(after)]["Disconnect"] = 0

			end

			if StatusSCP[team.GetName(before)] != nil then
				
				StatusSCP[team.GetName(before)]["Here"] = 0

			end

		end

	end
	hook.Add("OnPlayerChangedTeam","SCPISHERE",SCPISHERE)

	local function SCPISDISCONNECT(ply)
			
			if StatusSCP[team.GetName(ply:Team())] != nil then
				
				StatusSCP[team.GetName(ply:Team())]["Disconnect"] = 1

			end

	end
	hook.Add("PlayerDisconnected","SCPISDISCONNECT", SCPISDISCONNECT)

	util.AddNetworkString("ModifytableSCP")

	net.Receive("ModifytableSCP", function(len,ply)

		local scp = net.ReadString()

		if StatusSCP[scp]['Disabled'] == 0 then
			StatusSCP[scp]['Disabled'] = 1
		else
			StatusSCP[scp]['Disabled'] = 0
		end

	end)

end