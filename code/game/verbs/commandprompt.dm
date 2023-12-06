#define SECRET_GUARDIAN "ssix" //actual person responsible for handling donoses, bans and ranks/deranks. If you can read this, do not talk about this person anywhere outside #donos, not even #commissariat. It's secret for a reason
// not so secret anymore ripperonis
var/roundsinvite = 1

client/verb/prompt_command()
	set name = "Command Prompt"
	set category = "OOC"
	var/list/inputlist = list("showlads","togglenat","setspouse","invite","togglefuta","mycolor","retro","love","auth", "register", "add_donator", "ban", "unban", "add_role", "absencelabiosdeseda", "superretro","remove_role", "musica", "tremer","rsctoggle","fix64","togglesquire","togglesize")
	var/list/debug = list("showgamemode", "setgamemode", "changeskill")
	var/chosenoption = input("Input a command.","[src.key]")
	if(!chosenoption)
		return
	if(inputlist.Find(chosenoption))
		to_chat(src, "Command Used : <b>[chosenoption]</b>")
		switch(chosenoption)
			if("register")
				async_call(.proc/RegisterCallback, "HandleRegistrationDeferred", list(src.ckey), src)
				return
			if("showlads")
				src.showlads()
				return
			if("setspouse")
				src.set_spouse()
				return
			if("love")
				src.sendlove()
				return
			if("invite")
				if((ckey(usr.key) in comradelist) || usr.client.holder || usr.ckey == SECRET_GUARDIAN)
				//if(ckey(usr.key) in villainlist || ckey(usr.key) in comradelist)
					if(usr.client.prefs.roundsplayed < roundsinvite  && !usr.client.holder && !(usr.ckey == SECRET_GUARDIAN))
						to_chat(src, "<span class='highlighttext'>Вам нужно отыграть [roundsinvite] раундов, что-бы пригласить другого человека. Вы уже отыграли [usr.client.prefs.roundsplayed] раундов.</span>")
						return
					else
						invite_ckey()
						return
				else
					if(ckey(usr.key) in villainlist)
						if(usr.client.prefs.roundsplayed < roundsinvite && !usr.client.holder && !(usr.ckey == SECRET_GUARDIAN))
							to_chat(src, "<span class='highlighttext'>Вам нужно отыграть [roundsinvite] раундов, что-бы пригласить другого человека. Вы уже отыграли [usr.client.prefs.roundsplayed] раундов.</span>")
							return
						else
							invite_ckey()
							return
					else
						to_chat(src, "<span class='highlighttext'>Вам не разрешается это сделать.</span>")
						return

			if("superretro")
				if(src.prefs.UI_type == "Luna")
					to_chat(src, "Включен ретро-интерфейс, не забудьте перезайти.")
					src.prefs.UI_type = "Retro"
					src.prefs.UI_style = "Luna"
					src.prefs.save_preferences()
					if(mob.hud_used)	qdel(mob.hud_used)		//remove the hud objects
					mob.hud_used = new /datum/hud(mob)
					mob.add_filter_effects()
					mob.updatePig()
					mob?.hud_used?.add_inventory_overlay()
					mob?.Do_OLDHUD()

			if("retro")
				if(src.prefs.UI_type == "Luna")
					to_chat(src, "Включен ретро-интерфейс, не забудьте перезайти")
					src.prefs.UI_type = "Retro"
					src.prefs.UI_style = "Luna"
					src.prefs.save_preferences()
					if(mob.hud_used)	qdel(mob.hud_used)		//remove the hud objects
					mob.hud_used = new /datum/hud(mob)
					mob.add_filter_effects()
					mob.updatePig()
					mob?.hud_used?.add_inventory_overlay()
				else
					to_chat(src, "Выключен ретро-интерфейс, не забудьте перезайти")
					src.prefs.UI_type = "Luna"
					src.prefs.UI_style = "Luna"
					src.prefs.save_preferences()
					if(mob.hud_used)	qdel(mob.hud_used)		//remove the hud objects
					mob.hud_used = new /datum/hud(mob)
					mob.add_filter_effects()
					mob.updatePig()
					mob?.hud_used?.add_inventory_overlay()
					mob?.hud_used?.persistant_inventory_update()
					mob?.hud_used?.hidden_inventory_update()
				return
			if("mycolor")
				src.colorooc()
				return
			if("absencelabiosdeseda")
				to_chat(src, "Ui, sedoso!")
				return
			if("togglefuta")
				if(!futa.Find(src.ckey))
					to_chat(usr, "<span class='combatbold'>[pick(nao_consigoen)]</span> <span class='combat'>[pick("I'm poor","I don't have it","My wallet is empty","I'm broke")]!</span>")
					return
				if(src.mob.type != /mob/new_player)
					to_chat(usr, "<span class='combatbold'>FAIL!</span><span class='combat'> Его можно поменять только в вестибюле!</span>")
					return

				var/input = input(usr, "Вы уверены, что хотите отключить / включить futa?", "Farweb") in list("Yes", "No")
				switch(input)
					if("No")
						return
					if("Yes")
						if(src.prefs.togglefuta)
							to_chat(usr, "<span class='highlighttext'>Ты отключил futa.</span>")
							src.prefs.togglefuta = FALSE
							prefs.save_preferences()
							prefs.savefile_update()
						else
							to_chat(usr, "<span class='highlighttext'>Вы включили futa.</span>")
							src.prefs.togglefuta = TRUE
							prefs.save_preferences()
							prefs.savefile_update()
						return
				return
			if("togglesize")
				if(!thirtycm.Find(src.ckey))
					to_chat(usr, "<span class='combatbold'>[pick(nao_consigoen)]</span> <span class='combat'>[pick("I'm poor","I don't have it","My wallet is empty","I'm broke")]!</span>")
					return
				if(src.mob.type != /mob/new_player)
					to_chat(usr, "<span class='combatbold'>FAIL!</span><span class='combat'> It can only be changed in the lobby!</span>")
					return

				var/input = input(usr, "Вы уверены, что хотите отключить / включить 30 см?", "Farweb") in list("Yes", "No")
				switch(input)
					if("No")
						return
					if("Yes")
						if(src.prefs.togglesize)
							to_chat(usr, "<span class='highlighttext'>Вы отключили 30 см.</span>")
							src.prefs.togglesize = FALSE
							prefs.save_preferences()
							prefs.savefile_update()
						else
							to_chat(usr, "<span class='highlighttext'>Вы включили 30 см.</span>")
							src.prefs.togglesize = TRUE
							prefs.save_preferences()
							prefs.savefile_update()
						return
				return

			if("togglenat")
				var/input = input(usr, "Вы уверены, что хотите скрыть/ показать свою страну?", "Farweb") in list("Yes", "No")
				switch(input)
					if("No")
						return
					if("Yes")
						if(src.prefs.toggle_nat == TRUE)
							to_chat(usr, "<span class='highlighttext'>Ты скрыл свою страну.</span>")
							src.prefs.toggle_nat = FALSE
							prefs.save_preferences()
							prefs.savefile_update()
						else
							to_chat(usr, "<span class='highlighttext'>Вы показали свою страну.</span>")
							src.prefs.toggle_nat = TRUE
							prefs.save_preferences()
							prefs.savefile_update()
						return
				return
			if("auth")
				var/auth = input("Input a password.","[src.key]")
				if(!auth)
					return
				if(auth == privatepartypass)
					privatepartyallow = TRUE
					to_chat(world,"<b>Authorized!</b> <span class='highlighttext'>Повелитель разрешил частную вечеринку.</span>")
					world << 'thanet.ogg'

			if("add_donator")
				if(!usr.client.holder && !(usr.ckey == SECRET_GUARDIAN))
					to_chat(src, "<span class='highlighttext'>Вам не разрешается этого делать.</span>")
					return
				var/donateadd = input("What type of donation do you want to add?") in list ("Urchin","Mercenary","Seaspotter Merc", "Red Dawn Merc", "Lord", "Crusader", "Tophat", "Monk", "Futa", "Trap apoc", "Outlaw", "Water bottle", "Luxury donation", "Pjack", "Custom OOC Color","30cm","Tribunal Veteran","Adult Squire")
				switch(donateadd)
					if("Seaspotter Merc")
						add_seaspotter()
					if("Mercenary")
						add_mercenary()
					if("Urchin")
						add_urchin()
					if("Red Dawn Merc")
						add_reddawn()
					if("Lord")
						add_lord()
					if("Crusader")
						add_crusader()
					if("Tophat")
						add_tophat()
					if("Monk")
						add_monk()
					if("Futa")
						add_futa()
					if("Trap apoc")
						add_trapapoc()
					if("Outlaw")
						add_outlaw()
					if("Water bottle")
						add_waterbottle()
					if("Luxury donation")
						add_luxurydonation()
					if("Pjack")
						add_pjack()
					if("Custom OOC Color")
						add_customooc()
					if("30cm")
						add_30cm()
					if("Tribunal Veteran")
						add_tribvet()
					if("Adult Squire")
						add_squirea()
			if("ban")
				if(!usr.client.holder && !(usr.ckey == SECRET_GUARDIAN))
					to_chat(usr, "<span class='highlighttext'>Вам не разрешается этого делать.</span>")
					return
				remove_whitelist()
			if("unban")
				if(!usr.client.holder && !(usr.ckey == SECRET_GUARDIAN))
					to_chat(usr, "<span class='highlighttext'>Вам не разрешается этого делать.</span>")
					return
				remove_ban()
			if("add_role")
				if(!usr.client.holder && !(usr.ckey == SECRET_GUARDIAN))
					to_chat(usr, "<span class='highlighttext'>Вам не разрешается этого делать.</span>")
					return
				var/input = input(usr, "Which role do you want to add an user to?", "Farweb") in list("Villain", "Comrade","Pig+")
				switch(input)
					if("Comrade")
						add_comrade()
					if("Villain")
						add_villain()
					if("Pig+")
						add_pigplus()
			if("remove_role")
				if(!usr.client.holder && !(usr.ckey == SECRET_GUARDIAN))
					to_chat(usr, "<span class='highlighttext'>Вам не разрешается этого делать.</span>")
					return
				var/input = input(usr, "Which role do you want to remove an user from?", "Farweb") in list("Villain", "Comrade","Pig+")
				switch(input)
					if("Comrade")
						remove_comrade()
					if("Villain")
						remove_villain()
					if("Pig+")
						remove_pigplus()
			if("musica")
				if(ishuman(src.mob) && ckey == "stimusz" || ckey == "mynameajeff" || ckey == "wolxy" || ckey == "bailol"  || ckey == "johnegbert3" || ckey == "comicao1" || ckey == "necbromancer")
					var/mob/living/carbon/human/H = mob

					if(H.combat_musicoverlay)
						H.combat_musicoverlay = null
						to_chat(H, "<span class='highlighttext'><b>MÚSICA CUSTOM DESATIVADA</b></span>")
						return

					var/sound/S = input("Your music file") as sound|null

					if(S)
						H.combat_musicoverlay = S
						to_chat(H, "<span class='highlighttext'><b>MÚSICA CUSTOM ATIVADA</b></span>")
					return
			if("tremer")
				if(ishuman(src.mob) && ckey == "stimusz" || ckey == "mynameajeff" || ckey == "wolxy" || ckey == "bailol" || ckey == "comicao1" || ckey == "necbromancer")
					var/mob/living/carbon/human/H = mob

					if(H.fakeDREAMER)
						H.fakeDREAMER = 0
						return
					H.fakeDREAMER = 1
					return
			if("rsctoggle")
				if(src.prefs.rsc_fix == 1)
					src.prefs.rsc_fix = 0
				else
					src.prefs.rsc_fix = 1
				src.prefs.save_preferences()
				if(src.prefs.rsc_fix)
					to_chat(src, "Ресурсы теперь будут загружаться перед подключением, не забудьте повторно подключиться.")
				else
					to_chat(src, "Ресурсы теперь будут загружаться перед подключением, не забудьте повторно подключиться.")
			if("fix64")
				if(src.prefs.zoom_level == 2)
					src.prefs.zoom_level = 0
				else
					src.prefs.rsc_fix = 2
				src.prefs.save_preferences()
				if(src.prefs.zoom_level)
					to_chat(src, "Вы включили 2-кратный зум. Не забудьте снова подключиться.")
				else
					to_chat(src, "Вы включили функцию растягивания по размеру. Не забудьте снова подключиться.")
			if("togglesquire")
				if(!adultsquire.Find(src.ckey))
					to_chat(usr, "<span class='combatbold'>[pick(nao_consigoen)]</span> <span class='combat'>[pick("I'm poor","I don't have it","My wallet is empty","I'm broke")]!</span>")
					return
				var/input = input(usr, "Вы уверены, что хотите отключить / включить adult squire?", "Farweb") in list("Yes", "No")
				switch(input)
					if("No")
						return
					if("Yes")
						if(src.prefs.toggle_squire == TRUE)
							to_chat(usr, "<span class='highlighttext'>You disabled adult squire.</span>")
							src.prefs.toggle_squire = FALSE
							prefs.save_preferences()
							prefs.savefile_update()
						else
							to_chat(usr, "<span class='highlighttext'>You enabled adult squirea.</span>")
							src.prefs.toggle_squire = TRUE
							prefs.save_preferences()
							prefs.savefile_update()
						return
		return
	else if(debug.Find(chosenoption) && (src.ckey in secret_devs))
		to_chat(src, "Command Used : <b>[chosenoption]</b>")
		switch(chosenoption)
			if("showgamemode")
				to_chat(usr, "Current Gamemode: <b>[ticker.mode.config_tag]</b>")
				return
			if("setgamemode")
				var/input = input(usr, "Wich one?", "Farbebra") in list("kingwill", "changeling", "revolution", "dreamer", "succubus", "inspector", "siege", "quietday", "alien", "None", "(CANCEL)")
				if(input == "(CANCEL)")
					return
				log_game("[src.ckey] forces a gamemode called: [input]")
				if(input == "None")
					ticker.forcemod = null
					to_chat(usr, "Forced Gamemode: <b>None</b>")
				else
					ticker.forcemod = input
					to_chat(usr, "Forced Gamemode: <b>[ticker?.forcemod]</b>")
				return
			if("changeskill")
				if(istype(mob, /mob/living/carbon/human))
					var/mob/living/carbon/human/H = mob
					if(!length(H.my_skills.skills_holder))
						return
					var/list/skills_list = list()
					for(var/skill_id in 1 to H.my_skills.skills_holder.len)
						var/datum/skill/S = get_skill_data(skill_id, H.my_skills)
						if(!S)
							continue
						skills_list[S.name] = skill_id
					if(!length(skills_list))
						to_chat(src, "<span class='combat'>I'm dumb...</span>")
						return
					var/name_skill = input(src, "Which skill i want to change?", "Thinking") in skills_list
					if(!name_skill)
						return
					var/num_skill = input(src, "Change to?", "Thinking") as num
					if(num_skill > 20)
						to_chat(src, "Too high!")
						return
					else if(num_skill < 0)
						to_chat(src, "Too low!")
						return
					log_game("[src.ckey]/[H.real_name] changes his skill([name_skill]) to [num_skill]")
					H.my_skills.CHANGE_SKILL(skills_list[name_skill], round(num_skill))
					to_chat(src, "Skill Changed!")
					return
	else
		to_chat(src, "<span class='highlighttext'>Fail!: <span class='feedback'>[chosenoption]</span> <span class='highlighttext'>isn't a valid command.</span>")
		return

client/verb/ambi_volume()
	set name = "AmbiVolume"
	set category = "OOC"
	if(!prefs)
		return
	var/input = input(usr, "CURRENT: [src?.prefs?.ambi_volume] \n Set your Ambience Volume (0/255 Maximum)", "Farweb") as num
	if(input > 255 || input < 0)
		return
	to_chat(usr, "<spanclass='jogtowalk'>New Ambience volume is now [input]%</span>")
	prefs?.ambi_volume = input
	prefs?.save_preferences()
	prefs?.savefile_update()

client/verb/music_volume()
	set name = "MusicVolume"
	set category = "OOC"
	if(!prefs)
		return
	var/input = input(usr, "CURRENT: [src?.prefs?.music_volume] \n Set your Music Volume (0/255 Maximum)", "Farweb") as num
	if(input > 255 || input < 0)
		return
	to_chat(usr, "<spanclass='jogtowalk'>New Music volume is now [input]%</span>")
	prefs?.music_volume = input
	prefs?.save_preferences()
	prefs?.savefile_update()

/client/proc/RegisterCallback(var/token)
	if(token == "False")
		to_chat(src, "Вы уже получили свой жетон. Свяжитесь с патриархом, если он был утерян.")
		return
	if(token == "fail")
		to_chat(src, "При попытке выполнить операцию с базой данных произошла ошибка. Наорать на Нопм.")
		return
	to_chat(src, "Это ваш ключ: [token] <br><b style='color: red'>НЕ ЗАБЫВАЙ ОБ ЭТОМ!</b><br>")
	to_chat(src, "Message Lyoll on Discord with !register YOURKEYHERE")
	return