//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:33

var/list/preferences_datums = list()

var/global/list/special_roles = list( //keep synced with the defines BE_* in setup.dm --rastaf
//some autodetection here.
	"traitor" = IS_MODE_COMPILED("traitor"),             // 0
	"operative" = IS_MODE_COMPILED("nuclear"),           // 1
	"changeling" = IS_MODE_COMPILED("changeling"),       // 2
	"wizard" = IS_MODE_COMPILED("wizard"),               // 3
	"malf AI" = IS_MODE_COMPILED("malfunction"),         // 4
	"revolutionary" = IS_MODE_COMPILED("revolution"),    // 5
	"alien candidate" = 1, //always show                 // 6
	"pAI candidate" = 1, // -- TLE                       // 7
	"cultist" = IS_MODE_COMPILED("cult"),                // 8
	"infested monkey" = IS_MODE_COMPILED("monkey"),      // 9
	"ninja" = "true",									 // 10
	"vox raider" = IS_MODE_COMPILED("heist"),			 // 11
	"diona" = 1,                                         // 12
)

var/const/MAX_SAVE_SLOTS = 10
var/list/VicesList = list(vices)
//used for alternate_option
#define GET_RANDOM_JOB 0
#define BE_ASSISTANT 1
#define RETURN_TO_LOBBY 2
#define LEGAL_RELIGION  "Gray Church"
#define ILLEGAL_RELIGION "Thanati"

datum/preferences
	//doohickeys for savefiles
	var/path
	var/default_slot = 1				//Holder so it doesn't default to slot 1, rather the last one used
	var/savefile_version = 0

	//non-preference stuff
	var/warns = 0
	var/muted = 0
	var/last_ip
	var/last_id

	//game-preferences
	var/lastchangelog = ""				//Saved changlog filesize to detect if there was a change
	var/ooccolor = "#9390be"
	var/nameglow = 0
	var/be_special = 1					//Special role selection
	var/UI_style = "Luna"
	var/UI_type = "Luna"
	var/toggles = TOGGLES_DEFAULT
	var/UI_style_color = "#ffffff"
	var/UI_style_alpha = 255
	var/chromossomes = 0
	//character preferences
	var/real_name						//our character's name
	var/generate_backstory = 0
	var/be_random_name = 0				//whether we are a random name every round
	var/dwarven = 0
	var/gender = MALE					//gender of character (well duh)
	var/fat = 0
	var/age = 30						//age of character
	var/b_type = "A+"					//blood type (not-chooseable)
	var/underwear = 0					//underwear type
	var/backbag = 1						//backpack type
	var/h_style = "Bald"				//Hair type
	var/vice = "Smoker"
	var/lobbyspecie = "Adult"
	var/InquisiPref = "Normal"
	var/GatekeeperPref = "Monk"
	var/BaronPref = "Self-Indulgence (None)"
	var/MigProvince = "Wanderer"
	var/zodiac = "Aranea"
	var/r_hair = 0						//Hair color
	var/g_hair = 0						//Hair color
	var/b_hair = 0						//Hair color
	var/f_style = "Shaved"				//Face hair type
	var/r_facial = 0					//Face hair color
	var/g_facial = 0					//Face hair color
	var/b_facial = 0					//Face hair color
	var/s_tone = 0						//Skin color
	var/r_eyes = 0						//Eye color
	var/g_eyes = 0						//Eye color
	var/b_eyes = 0						//Eye color

	var/d_style = "None"
	var/r_detail = 0
	var/g_detail = 0
	var/b_detail = 0

	var/species = "Human"
	var/language = "None"				//Secondary language
	var/religion = LEGAL_RELIGION
	var/makespecial = 0
		//Mob preview
	var/icon/preview_icon = null
	var/icon/preview_icon_front = null
	var/icon/preview_icon_side = null
	var/icon/bg2 = 'bg2.png'
	var/icon/bg1 = 'bg.png'
	var/icon/dice = 'dice.png'

		//Jobs, uses bitflags
	var/job_civilian_high = 0
	var/job_civilian_med = 0
	var/job_civilian_low = 0

	var/job_medsci_high = 0
	var/job_medsci_med = 0
	var/job_medsci_low = 0

	var/job_engsec_high = 0
	var/job_engsec_med = 0
	var/job_engsec_low = 0
	var/dom_hand = "Right-handed"
	var/toggle_nat = 1
	var/rsc_fix = 1 //Changes preload_rsc to value set by client. defaults to one as some people have issues with 0.
	var/zoom_level = 0 //Changes the map zoom level. Zero is stretch to fit.
	var/toggle_squire = FALSE //Adult squire
	//Keeps track of preferrence for not getting any wanted jobs
	var/alternate_option = 0

	// maps each organ to either null(intact), "cyborg" or "amputated"
	// will probably not be able to do this for head and torso ;)
	var/list/organ_data = list()

	var/list/flavor_texts = list()

	var/med_record = ""
	var/sec_record = ""
	var/gen_record = ""
	var/disabilities = 0
	var/roundsplayed = 0
	var/nanotrasen_relation = "Neutral"

	var/uplinklocation = "PDA"

	var/slot_name = ""
	var/occupation[] = list("No Preference", "No Preference", "No Preference")
	var/family = 0
	var/togglefuta = 0
	var/togglesize = 0
//VOLUME
	var/ambi_volume = 50
	var/music_volume = 40
	var/toggleLobbyScreen = 0

	var/graphicsSetting = 0
	var/fullscreenSetting = 1
	var/blurSetting = 0

/datum/preferences/New(client/C)
	b_type = pick(4;"O-", 36;"O+", 3;"A-", 28;"A+", 1;"B-", 20;"B+", 1;"AB-", 5;"AB+")
	if(istype(C))
		if(!IsGuestKey(C.key))
			load_path(C.ckey)
			if(load_preferences())
				if(load_character())
					return
	gender = pick(MALE, FEMALE)
	be_special = 1
	real_name = random_name(gender, dwarven_name = dwarven)
	vice = pick(VicesList)
	zodiac = "Aranea"

/datum/preferences

	proc/ShowChoices(mob/user)
		if(!user)	return
		update_preview_icon()
		user << browse_rsc(preview_icon_front, "previewicon.png")
		user << browse_rsc(preview_icon_side, "previewicon2.png")
		user << browse_rsc(bg2,"bg2.png")
		user << browse_rsc(bg1,"bg.png")
		user << browse_rsc(dice,"dice.png")
		//var/dat = "<html><head><style type='text/css'>html {overflow: auto;};body {cursor: url('pointer.cur'), auto;overflow:hidden;font-family: Times;background-repeat:repeat-x;}a {text-decoration:none;outline: none;border: none;margin:-1px;}a:focus{outline:none;border: none;}a:hover {Color:#0d0d0d;background:#505055;outline: none;border: none;}a.active { text-decoration:none; Color:#533333;border: none;}a.inactive:hover {Color:#0d0d0d;background:#bb0000;border: none;}a.active:hover {Color:#bb0000;background:#0f0f0f;}a.inactive:hover { text-decoration:none; Color:#0d0d0d; background:#bb0000;border: none;}a img {     border: 0; }TABLE.winto {z-index:-1;position: absolute;top: 12;left:14;background-position: bottom;background-repeat:repeat-x;border: 4px dotted #222222;/*    border-top:4px double #777777; */border-bottom: none;border-top: none;}TR {border: 0px;}</style></head><body background = 'bg2.png' bgColor=#0d0d0d text=#555555 alink=#777777 vlink=#777777 link=#777777>"
		var/dat = "<META charset='UTF-8'> <Title>Farweb</title> <style type='text/css'> html {overflow: auto;}; body { cursor: url('pointer.cur'), auto; overflow:hidden; font-family: Times; background-repeat:repeat-x; } a {text-decoration:none;outline: none;border: none;margin:-1px;} a:focus{outline:none;border: none;} a:hover {Color:#0d0d0d;background:#505055;outline: none;border: none;} a.active { text-decoration:none; Color:#533333;border: none;} a.inactive:hover {Color:#0d0d0d;background:#bb0000;border: none;} a.active:hover {Color:#bb0000;background:#0f0f0f;} a.inactive:hover { text-decoration:none; Color:#0d0d0d; background:#bb0000;border: none;} a img { border: 0; } TABLE.winto { z-index:-1; position: absolute; top: 12; left:14; background-position: bottom; background-repeat:repeat-x; border: 4px dotted #222222; /* border-top:4px double #777777; */ border-bottom: none; border-top: none; } TR { border: 0px; } </style>"
		var/mob/new_player/N = user
		dat += "<html><body background = 'bg2.png' bgColor=#0d0d0d text=#555555 alink=#777777 vlink=#777777 link=#777777>"
		dat += "<p style='position: absolute;top: 10;left:295; font-size:400%'><font face='Times'><b>†</b></font></p>"
		dat += "<p align = 'right'><a onfocus='this.blur()' href='?_src_=prefs;preference=toggleLobbyScreen'>¤</a></p>"
		//dat += "<p align = 'right'><a onfocus='this.blur()' href='byond://?src=[0x30005a1];preferences=1;toggletitle=1'>¤</a></p>"
		dat += "<table bgColor=#0d0d0d width=500 height=300 border=0 cellpadding=2>"
		dat += "<table class = 'winto' bgColor=#0d0d0d background = 'bg.png' width=600 border=0 cellpadding=15>"
		dat += "<tr height='10'><td width='240px'>"
		//dat += "<img src=previewicon.png height=64 width=64 align='right'><img src=previewicon2.png height=64 width=64 align='right'></center>"
		dat += "<b>Name:</b> <a href='?_src_=prefs;preference=name;task=input'><b>[real_name]</b></a><a href='?_src_=prefs;preference=name;task=random'><img src='dice.png' height=16 width=16></A><br>"
		//dat += "<br>"
		dat += "<b>Gender:</b> <a href='?_src_=prefs;preference=gender'><b>[gender == MALE ? "Male" : "Female"]</b></a><br>"
		dat += "<b>Age:</b> <a href='?_src_=prefs;preference=age;task=input'>[age]</a><br>"
		dat += "<a href='?_src_=prefs;preference=job;task=menu'><b>Fate</b></a>"
		if(user?.client?.work_chosen == "Heir")
			dat += "<br><b>Maturity:</b> <a href='?_src_=prefs;preference=lobbybe'><b>[lobbyspecie == "Adult" ? "Old" : "Young"]</b></a>"
		if(user?.client?.work_chosen == "Successor")
			dat += "<br><b>Maturity:</b> <a href='?_src_=prefs;preference=lobbybe'><b>[lobbyspecie == "Adult" ? "Old" : "Young"]</b></a>"
		if(user?.client?.work_chosen == "Jester")
			dat += "<br><b>Archetype:</b> <a href='?_src_=prefs;preference=lobbybe'><b>[lobbyspecie == "Adult" ? "Classic" : "Court"]</b></a>"
		if(user?.client?.work_chosen == "Treasurer")
			dat += "<br><b>Archetype:</b> <a href='?_src_=prefs;preference=lobbybe'><b>[lobbyspecie == "Adult" ? "Treasurer" : "Meister Disciple"]</b></a>"
		if(user?.client?.work_chosen == "Inquisitor")
			dat += "<br><b>Archetype:</b> <a href='?_src_=prefs;preference=inqui'><b>[InquisiPref]</b></a>"
		if(user?.client?.work_chosen == "Incarn")
			dat += "<br><b>Archetype:</b> <a href='?_src_=prefs;preference=gatekeeper'><b>[GatekeeperPref]</b></a>"
		if(user?.client?.work_chosen == "Baron")
			dat += "<br><a href='?_src_=prefs;preference=baron'><small>[BaronPref]</small></a>"
			dat += "<br><a onfocus='this.blur()' href='byond://?src=\ref[user];aspects=1'><small>Aspects</small></a>"
		//dat += "<b>Family:</b> <a href='?_src_=prefs;preference=family'><b>[family ? "Yes" : "No"]</b></a><br>"
		//dat += "<b>Random Marriage:</b> <a href='?_src_=prefs;preference=random_marry'><b>[random_marry ? "Yes" : "No"]</b></a>"
		dat += "</td>"

		dat += "<td valign=top rowspan=2>"
		dat += "<br><center><b></b><br><img src=previewicon.png height=64 width=64 align='right'></a><big>"
		dat += "<td width=220>"
		dat += "<table><tr><td><b>Blood Type:</b> <a href='byond://?src=\ref[user];preference=b_type;task=input'>[b_type]</a><br><b>Skin Color:</b> <a href='?_src_=prefs;preference=s_tone;task=input'>[-s_tone + 35]/255</a><br></td>"
		dat += "</tr></table>"
		dat += "<table><tr><td><b>Hair: </b><br></td>"
		dat += "<td height=16 bgColor='#[num2hex(r_hair, 2)][num2hex(g_hair, 2)][num2hex(b_hair, 2)]'><a href='?_src_=prefs;preference=hair;task=input'>Color</a></td>"
		dat += "<td><a href='?_src_=prefs;preference=h_style;task=input'>[h_style]</a></tr>"
		dat += "<tr>"
		dat += "<td> <b>Details: </b><br></td>"
		dat += "<td height=16 bgColor='#[num2hex(r_detail, 2)][num2hex(g_detail, 2)][num2hex(b_detail, 2)]'><a href='?_src_=prefs;preference=detail;task=input'>Color</a></td>"
		dat += "<td><a href='?_src_=prefs;preference=d_style;task=input'>[d_style]</a></tr>"
		dat += "<tr>"
		dat += "<td> <b>Facial: </b><br></td>"
		dat += "<td height=16 bgColor='#[num2hex(r_facial, 2)][num2hex(g_facial, 2)][num2hex(b_facial, 2)]'><a onfocus='this.blur()' href='?_src_=prefs;preference=facial;task=input'>Color</a></td>"
		dat += "<td><a href='?_src_=prefs;preference=f_style;task=input'>[f_style]</a></tr>"
		dat += "<tr>"
		dat += "<td> <b>Eyes: </b><br></td>"
		dat += "<td height=16 bgColor='#[num2hex(r_eyes, 2)][num2hex(g_eyes, 2)][num2hex(b_eyes, 2)]'><a onfocus='this.blur()' href='?_src_=prefs;preference=eyes;task=input'>Color</a></td>"
		dat += "</tr></table></b></a></td></tr>"
		dat += "<tr>"
		dat += "<td>"
		dat += "<b>Be Fat:</b> <a onfocus='this.blur()' href='?_src_=prefs;preference=fatness'><b>[fat ? "Yes" : "No"]</b></a><br>"
		//REMOVER ESSE DEPOIS
		dat += "<br>"
		dat += "<b>Vice:</b> <a onfocus='this.blur()' href='?_src_=prefs;preference=vice;task=input'><b>[vice]</b></a><br>"
		dat += "<b>Sign:</b> <a onfocus='this.blur()' href='?_src_=prefs;preference=zodiac;task=input'><b>[zodiac]</b></a><br>"
		dat += "<b>Faith:</b> <a onfocus='this.blur()' href='?_src_=prefs;preference=religion'><b>[religion == LEGAL_RELIGION ? "Gray Church" : "Heresy"]</b></a><br>"
		dat += "<b>Family:</b> <a onfocus='this.blur()' href='?_src_=prefs;preference=family'><b>[family ? "Yes" : "No"]</b></a><br>"
		dat += "<b>Origins:</b> <a href='?_src_=prefs;preference=province'><b>[MigProvince]</b></a><br>"
		dat += "<a onfocus='this.blur()' href='?_src_=prefs;preference=dom_hand'><b>[dom_hand ? "Right-handed" : "Left-handed"]</b></a><br>"
		dat += "</td>"
		dat += "<td colspan=3>"
		if(!N.special && !SpecialRolledList.Find(N.ckey))
			dat += "<a onfocus='this.blur()' href='byond://?src=\ref[user];special=1'>Make Special</A><br>"
		else
			dat += "<b>Hero. </b>"
			dat += "<a onfocus='this.blur()' href='byond://?src=\ref[user];special=1'>(?)</A><br>"
		dat += "<a onfocus='this.blur()' href=\"byond://?src=\ref[user];preference=save\">Save</a> / "
		dat += "<a onfocus='this.blur()' href=\"byond://?src=\ref[user];preference=open_load_dialog\">Load</a> / "
		dat += "<a onfocus='this.blur()' href=\"byond://?src=\ref[user];preference=reload\">New</a>"
		dat += "</td>"
		dat += "</tr>"
		dat += "<tr height=15>"
		dat += "<td colspan=3 ></td></tr><BR></table>"
		if(master_mode == "miniwar")
			dat += "<p style='position: absolute;right: 5px;bottom: 20px;'><a onfocus='this.blur()' href='byond://?src=\ref[user];mini_war=1' class=inactive><b>War is coming!</b></A></P>"

		else if(!ticker || ticker.current_state <= GAME_STATE_PREGAME)
			if(master_mode == "holywar" || master_mode == "minimig")
				dat += "<p style='position: absolute;right: 5px;bottom: 20px;'><a onfocus='this.blur()' href='byond://?src=\ref[user];late_join=1' class=inactive><b>War is coming!</b></A></P>"

			else
				if(!N.ready && master_mode != "holywar" || !N.ready && master_mode != "minimig")
					dat += "<p style='position: absolute;right: 5px;bottom: 20px;'><a onfocus='this.blur()' href='byond://?src=\ref[user];ready=1' class=inactive><b>You are not ready.<b></A></P>"
				else
					dat += "<p style='position: absolute;right: 5px;bottom: 20px;'><a onfocus='this.blur()' href='byond://?src=\ref[user];ready=0' class=inactive><b>Ready</b></A></P>"

		else if(ticker?.mode.config_tag == "siege")
			if(N.ready)
				dat += "<p style='position: absolute;right: 5px;bottom: 20px;'><a onfocus='this.blur()' href='byond://?src=\ref[user];late_war=1' class=inactive><b>Cancel</b></A></P>"
			else
				dat += "<p style='position: absolute;right: 5px;bottom: 20px;'><a onfocus='this.blur()' href='byond://?src=\ref[user];late_war=0' class=inactive><b>War!</b></A></P>"
		else
			dat += "<p style='position: absolute;right: 5px;bottom: 20px;'><a onfocus='this.blur()' href='byond://?src=\ref[user];late_join=1' class=inactive><b>Join!</b></A></P>"

		dat += "<br></body></html>"

		user << browse(dat, "window=preferences;size=600x400;can_close=0;can_resize=0;titlebar=[toggleLobbyScreen]")

	proc/SetChoices(mob/user, limit = 17, list/splitJobs = list("Chief Medical Officer"), width = 550, height = 480)
		if(!job_master)
			return

		//limit 	 - The amount of jobs allowed per column. Defaults to 17 to make it look nice.
		//splitJobs - Allows you split the table by job. You can make different tables for each department by including their heads. Defaults to CE to make it look nice.
		//width	 - Screen' width. Defaults to 550 to make it look nice.
		//height 	 - Screen's height. Defaults to 500 to make it look nice.


		var/HTML = "<META http-equiv='X-UA-Compatible' content='IE=edge' charset='UTF-8'><Title>Farweb</title><style type='text/css'>body {font-family: Times;cursor: url('pointer.cur'), auto;}a {text-decoration:none;outline: none;border: none;margin:-1px;}a:focus{outline:none;}a:hover {color:#0d0d0d;background:#505055;outline: none;border: none;}a.active { text-decoration:none; color:#533333;}a.inactive:hover {color:#0d0d0d;background:#bb0000}a.active:hover {color:#bb0000;background:#0f0f0f}a.inactive:hover { text-decoration:none; color:#0d0d0d; background:#bb0000}table { width:100%; }td {text-align: center;}TR {border: 0px;}</style><script type='text/javascript'>function updateText(tmpdesc){document.getElementById('INFO').innerHTML = tmpdesc;}</script><body bgcolor=#0d0d0d text=#555555 alink=#777777 vlink=#777777 link=#777777>"
		HTML += "<tt><center>"
		HTML += "<b>Выбери свою судьбу</b><br>"
		HTML += "<center><a href='?_src_=prefs;preference=job;task=close'>\[Done\]</a></center><br>" // Easier to press up here.
		HTML += "<table width='100%' cellpadding='1' cellspacing='0'><tr><td width='20%'>" // Table within a table for alignment, also allows you to easily add more colomns.
		HTML += "<table width='100%' cellpadding='1' cellspacing='0'>"
		var/index = -1

		//The job before the current job. I only use this to get the previous jobs color when I'm filling in blank rows.
		var/datum/job/lastJob
		if (!job_master)		return
		for(var/datum/job/job in job_master.occupations)

			index += 1
			if((index >= limit) || (job.title in splitJobs))
				if((index < limit) && (lastJob != null))
					//If the cells were broken up by a job in the splitJob list then it will fill in the rest of the cells with
					//the last job's selection color. Creating a rather nice effect.
					for(var/i = 0, i < (limit - index), i += 1)
						HTML += "<tr bgcolor=#121212><td width='60%' align='right'><a>&nbsp</a></td><td><a>&nbsp</a></td></tr>"
				HTML += "</table></td><td width='20%'><table width='100%' cellpadding='1' cellspacing='0'>"
				index = 0

			HTML += "<tr bgcolor=#121212><td width='60%' align='right'>"
			var/rank = job.title
			rank = job.title
			lastJob = job
			if((job.sex_lock && job.sex_lock != user.client.prefs.gender && (!trapapoc.Find(ckey(user.client.key)) || job.no_trapoc)) || job.flag == MIGRANT || job.flag == SIEGER || (job.total_positions == 0 && job.spawn_positions == 0))
				. += "<del>[rank]</del></td><td><b> \[UNAVAILABLE]</b></td></tr>"
				//HTML += "<font color=#454747>[rank]</font></td></tr>"
				continue
			if(job.job_whitelisted)
				if(job.job_whitelisted.Find(PIGPLUS))
					if(!comradelist.Find(ckey(user.client.key)) && !villainlist.Find(ckey(user.client.key)))
						if(!pigpluslist.Find(ckey(user.client.key)))
							HTML += "<font color=#454747>[rank]</font></td></tr>"
							continue
				else
					if(job.job_whitelisted.Find(COMRADE))
						if(!comradelist.Find(ckey(user.client.key)) && !villainlist.Find(ckey(user.client.key)))
							HTML += "<font color=#454747>[rank]</font></td></tr>"
							continue
					else
						if(job.job_whitelisted.Find(VILLAIN))
							if(!villainlist.Find(ckey(user.client.key)))
								HTML += "<font color=#454747>[rank]</font></td></tr>"
								continue
			if(job.donation_lock.len >= 1 && !job.donation_lock.Find(ckey(user.client.key)))
				HTML += "<font color=#323233>[rank]</font></td><td></td></tr>"
				continue
			if(jobban_isbanned(user, rank) || master_mode=="minimig" && job.flag != MIGRANT || master_mode=="holywar" && job.flag != MIGRANT)
				HTML += "<font color=#454747>[rank]</font></td></tr>"
				continue
			HTML += "[rank]"

			HTML += "</td><td width='40%'>"
			HTML += "<a onmouseover=\"updateText('[job.jobdesc]')\" onmouseout=\"updateText(' ')\" href='?_src_=prefs;preference=job;task=input;text=[rank]'>"

			if(GetJobDepartment(job, 1) & job.flag)
				HTML += " <font color=#e8dada>\[1st]</font>"
			else if(GetJobDepartment(job, 2) & job.flag)
				HTML += " <font color=#a39999>\[2nd]</font>"
			else if(GetJobDepartment(job, 3) & job.flag)
				HTML += " <font color=#7a7474>\[3rd]</font>"
			else
				HTML += " <font color=#2e2423>\[N/A]</font>"
			HTML += "</a></td></tr>"

		HTML += "</td'></tr></table>"

		HTML += "</center></table>"

/*		switch(alternate_option)
			if(GET_RANDOM_JOB)
				HTML += "<center><br><u><a href='?_src_=prefs;preference=job;task=random'><font color=#a0a0a0>Get random job if preferences unavailable</font></a></u></center><br>"
			if(BE_ASSISTANT)
				HTML += "<center><br><u><a href='?_src_=prefs;preference=job;task=random'><font color=#a0a0a0>Be unassigned if preference unavailable</font></a></u></center><br>"
			if(RETURN_TO_LOBBY)
				HTML += "<center><br><u><a href='?_src_=prefs;preference=job;task=random'><font color=#a0a0a0>Return to lobby if preference unavailable</font></a></u></center><br>"
*/
		HTML += "<center><font color=#e8dada><a href='?_src_=prefs;preference=job;task=reset'>\[Reset]</a></center></font>"
		HTML += "</tt>"
		HTML += "<i id = 'INFO'></i>"

		user << browse(null, "window=preferences;")
		user << browse(HTML, "window=mob_occupation;size=[width]x[height];can_close=0; can_resize=0;can_minimize=0;titlebar=1")
		//var/datum/browser/popup = new(user, "Occupation", "Occupation", width, height)
		//popup.set_content(HTML)
		//popup.set_window_options("can_close=0;")
		//popup.open()
		return

	proc/SetDisabilities(mob/user)
		var/HTML = "<body>"
		HTML += "<tt><center>"
		HTML += "<b>Choose disabilities</b><br>"

		HTML += "Need Glasses? <a href=\"byond://?src=\ref[user];preferences=1;disabilities=0\">[disabilities & (1<<0) ? "Yes" : "No"]</a><br>"
		HTML += "Seizures? <a href=\"byond://?src=\ref[user];preferences=1;disabilities=1\">[disabilities & (1<<1) ? "Yes" : "No"]</a><br>"
		HTML += "Coughing? <a href=\"byond://?src=\ref[user];preferences=1;disabilities=2\">[disabilities & (1<<2) ? "Yes" : "No"]</a><br>"
		HTML += "Tourettes/Twitching? <a href=\"byond://?src=\ref[user];preferences=1;disabilities=3\">[disabilities & (1<<3) ? "Yes" : "No"]</a><br>"
		HTML += "Nervousness? <a href=\"byond://?src=\ref[user];preferences=1;disabilities=4\">[disabilities & (1<<4) ? "Yes" : "No"]</a><br>"
		HTML += "Deafness? <a href=\"byond://?src=\ref[user];preferences=1;disabilities=5\">[disabilities & (1<<5) ? "Yes" : "No"]</a><br>"

		HTML += "<br>"
		HTML += "<a href=\"byond://?src=\ref[user];preferences=1;disabilities=-2\">\[Done\]</a>"
		HTML += "</center></tt>"

		user << browse(null, "window=preferences")
		user << browse(HTML, "window=disabil;size=350x300")
		return

	proc/SetRecords(mob/user)
		var/HTML = "<body>"
		HTML += "<tt><center>"
		HTML += "<b>Set Character Records</b><br>"

		HTML += "<a href=\"byond://?src=\ref[user];preference=records;task=med_record\">Medical Records</a><br>"

		if(length(med_record) <= 40)
			HTML += "[med_record]"
		else
			HTML += "[copytext(med_record, 1, 37)]..."

		HTML += "<br><br><a href=\"byond://?src=\ref[user];preference=records;task=gen_record\">Employment Records</a><br>"

		if(length(gen_record) <= 40)
			HTML += "[gen_record]"
		else
			HTML += "[copytext(gen_record, 1, 37)]..."

		HTML += "<br><br><a href=\"byond://?src=\ref[user];preference=records;task=sec_record\">Security Records</a><br>"

		if(length(sec_record) <= 40)
			HTML += "[sec_record]<br>"
		else
			HTML += "[copytext(sec_record, 1, 37)]...<br>"

		HTML += "<br>"
		HTML += "<a href=\"byond://?src=\ref[user];preference=records;records=-1\">\[Done\]</a>"
		HTML += "</center></tt>"

		user << browse(null, "window=preferences")
		user << browse(HTML, "window=records;size=350x300")
		return

	proc/SetAntagoptions(mob/user)
		var/HTML = "<body>"
		HTML += "<tt><center>"
		HTML += "<b>Antagonist Options</b> <hr />"
		HTML += "<br>"
		HTML +="Uplink Type : <b><a href='?src=\ref[user];preference=antagoptions;antagtask=uplinktype;active=1'>[uplinklocation]</a></b>"
		HTML +="<br>"
		HTML +="<hr />"
		HTML +="<a href='?src=\ref[user];preference=antagoptions;antagtask=done;active=1'>\[Done\]</a>"

		HTML += "</center></tt>"

		user << browse(null, "window=preferences")
		user << browse(HTML, "window=antagoptions")
		return

	proc/SetFlavorText(mob/user)
		var/HTML = "<body>"
		HTML += "<tt><center>"
		HTML += "<b>Set Flavour Text</b> <hr />"
		HTML += "<br></center>"
		HTML += "<a href='byond://?src=\ref[user];preference=flavor_text;task=general'>General:</a> "
		HTML += TextPreview(flavor_texts["general"])
		HTML += "<br>"
		HTML += "<a href='byond://?src=\ref[user];preference=flavor_text;task=head'>Head:</a> "
		HTML += TextPreview(flavor_texts["head"])
		HTML += "<br>"
		HTML += "<a href='byond://?src=\ref[user];preference=flavor_text;task=face'>Face:</a> "
		HTML += TextPreview(flavor_texts["face"])
		HTML += "<br>"
		HTML += "<a href='byond://?src=\ref[user];preference=flavor_text;task=eyes'>Eyes:</a> "
		HTML += TextPreview(flavor_texts["eyes"])
		HTML += "<br>"
		HTML += "<a href='byond://?src=\ref[user];preference=flavor_text;task=torso'>Body:</a> "
		HTML += TextPreview(flavor_texts["torso"])
		HTML += "<br>"
		HTML += "<a href='byond://?src=\ref[user];preference=flavor_text;task=arms'>Arms:</a> "
		HTML += TextPreview(flavor_texts["arms"])
		HTML += "<br>"
		HTML += "<a href='byond://?src=\ref[user];preference=flavor_text;task=hands'>Hands:</a> "
		HTML += TextPreview(flavor_texts["hands"])
		HTML += "<br>"
		HTML += "<a href='byond://?src=\ref[user];preference=flavor_text;task=legs'>Legs:</a> "
		HTML += TextPreview(flavor_texts["legs"])
		HTML += "<br>"
		HTML += "<a href='byond://?src=\ref[user];preference=flavor_text;task=feet'>Feet:</a> "
		HTML += TextPreview(flavor_texts["feet"])
		HTML += "<br>"
		HTML += "<hr />"
		HTML +="<a href='?src=\ref[user];preference=flavor_text;task=done'>\[Done\]</a>"
		HTML += "<tt>"
		user << browse(null, "window=preferences")
		user << browse(HTML, "window=flavor_text;size=430x300")
		return

	proc/SetJob(mob/user, role)
		var/datum/job/job = job_master.GetJob(role)
		if(!job)
			user << browse(null, "window=mob_occupation")
			ShowChoices(user)
			return

		if(role == "Unassigned")
			if(job_civilian_low & job.flag)
				job_civilian_low &= ~job.flag
			else
				job_civilian_low |= job.flag
			SetChoices(user)
			return 1

		if(GetJobDepartment(job, 1) & job.flag)
			SetJobDepartment(job, 1)
		else if(GetJobDepartment(job, 2) & job.flag)
			SetJobDepartment(job, 2)
		else if(GetJobDepartment(job, 3) & job.flag)
			SetJobDepartment(job, 3)
		else//job = Never
			SetJobDepartment(job, 4)

		SetChoices(user)
		user?.client?.GetHighJob()
		return 1

	proc/ResetJobs()
		job_civilian_high = 0
		job_civilian_med = 0
		job_civilian_low = 0

		job_medsci_high = 0
		job_medsci_med = 0
		job_medsci_low = 0

		job_engsec_high = 0
		job_engsec_med = 0
		job_engsec_low = 0
		usr?.client?.GetHighJob()


	proc/GetJobDepartment(var/datum/job/job, var/level)
		if(!job || !level)	return 0
		switch(job.department_flag)
			if(CIVILIAN)
				switch(level)
					if(1)
						return job_civilian_high
					if(2)
						return job_civilian_med
					if(3)
						return job_civilian_low
			if(MEDSCI)
				switch(level)
					if(1)
						return job_medsci_high
					if(2)
						return job_medsci_med
					if(3)
						return job_medsci_low
			if(ENGSEC)
				switch(level)
					if(1)
						return job_engsec_high
					if(2)
						return job_engsec_med
					if(3)
						return job_engsec_low
		return 0

	proc/SetJobDepartment(var/datum/job/job, var/level)
		if(!job || !level)	return 0
		switch(level)
			if(1)//Only one of these should ever be active at once so clear them all here
				job_civilian_high = 0
				job_medsci_high = 0
				job_engsec_high = 0
				return 1
			if(2)//Set current highs to med, then reset them
				job_civilian_med |= job_civilian_high
				job_medsci_med |= job_medsci_high
				job_engsec_med |= job_engsec_high
				job_civilian_high = 0
				job_medsci_high = 0
				job_engsec_high = 0

		switch(job.department_flag)
			if(CIVILIAN)
				switch(level)
					if(2)
						job_civilian_high = job.flag
						job_civilian_med &= ~job.flag
					if(3)
						job_civilian_med |= job.flag
						job_civilian_low &= ~job.flag
					else
						job_civilian_low |= job.flag
			if(MEDSCI)
				switch(level)
					if(2)
						job_medsci_high = job.flag
						job_medsci_med &= ~job.flag
					if(3)
						job_medsci_med |= job.flag
						job_medsci_low &= ~job.flag
					else
						job_medsci_low |= job.flag
			if(ENGSEC)
				switch(level)
					if(2)
						job_engsec_high = job.flag
						job_engsec_med &= ~job.flag
					if(3)
						job_engsec_med |= job.flag
						job_engsec_low &= ~job.flag
					else
						job_engsec_low |= job.flag
		return 1

	proc/process_link(mob/user, list/href_list)
		if(!user)	return
		var/mob/new_player/N = usr
		if(!istype(user, /mob/new_player))	return
		if(href_list["preference"] == "job")
			switch(href_list["task"])
				if("close")
					user << browse(null, "window=mob_occupation")
					ShowChoices(user)
					N?.client?.GetHighJob()
				if("reset")
					ResetJobs()
					SetChoices(user)
					N?.client?.GetHighJob()
				if("random")
					if(alternate_option == GET_RANDOM_JOB || alternate_option == BE_ASSISTANT)
						alternate_option += 1
					else if(alternate_option == RETURN_TO_LOBBY)
						alternate_option = 0
					else
						return 0
					SetChoices(user)
					N?.client?.GetHighJob()
				if("input")
					SetJob(user, href_list["text"])
					N?.client?.GetHighJob()
				else
					SetChoices(user)
					N?.client?.GetHighJob()
			return 1

		if(href_list["ready"])
			if(master_mode == "holywar" || master_mode == "minimig")
				to_chat(N, "Nobody is ready for war.")
				return
			else
				N.ready = !N.ready
				N?.client?.GetHighJob()
				N.AttemptLateSpawn(href_list["SelectedJob"])
/*			if(ticker)
				if(ticker.current_state == GAME_STATE_PREGAME)
					for(var/mob/new_player/PP in player_list)
						PP.updatelobbypiglet()*/

		if(href_list["late_join"])
			N.LateChoices()

		if(href_list["mini_war"])
			N.Joining_War()

		if(href_list["late_war"])
			if(ticker.current_state == GAME_STATE_PLAYING)
				if(ticker.migrants_inwave.Find(N.client))
					ticker.migrants_inwave.Remove(N.client)
					N.client.prefs.ShowChoices(N)
					N.ready = FALSE
				else
					ticker.migrants_inwave.Add(N.client)
					N.client.prefs.ShowChoices(N)
					N.ready = TRUE

		else if(href_list["preference"] == "flavor_text")
			switch(href_list["task"])
				if("open")
					SetFlavorText(user)
					return
				if("done")
					user << browse(null, "window=flavor_text")
					ShowChoices(user)
					return
				if("general")
					var/msg = sanitize_uni(input(usr,"Give a general description of your character. This will be shown regardless of clothing, and may include OOC notes and preferences.","Flavor Text",html_decode(flavor_texts[href_list["task"]])) as message)
					if(msg != null)
						msg = copytext(msg, 1, MAX_MESSAGE_LEN)
						msg = html_encode(msg)
					flavor_texts[href_list["task"]] = msg
				else
					var/msg = sanitize_uni(input(usr,"Set the flavor text for your [href_list["task"]].","Flavor Text",html_decode(flavor_texts[href_list["task"]])) as message)
					if(msg != null)
						msg = copytext(msg, 1, MAX_MESSAGE_LEN)
						msg = html_encode(msg)
					flavor_texts[href_list["task"]] = msg
			SetFlavorText(user)
			return

		else if(href_list["preference"] == "records")
			if(text2num(href_list["record"]) >= 1)
				SetRecords(user)
				return
			else
				user << browse(null, "window=records")
			if(href_list["task"] == "med_record")
				var/medmsg = input(usr,"Set your medical notes here.","Medical Records",html_decode(med_record)) as message

				if(medmsg != null)
					medmsg = copytext(medmsg, 1, MAX_PAPER_MESSAGE_LEN)
					medmsg = html_encode(medmsg)

					med_record = medmsg
					SetRecords(user)

			if(href_list["task"] == "sec_record")
				var/secmsg = input(usr,"Set your security notes here.","Security Records",html_decode(sec_record)) as message

				if(secmsg != null)
					secmsg = copytext(secmsg, 1, MAX_PAPER_MESSAGE_LEN)
					secmsg = html_encode(secmsg)

					sec_record = secmsg
					SetRecords(user)
			if(href_list["task"] == "gen_record")
				var/genmsg = input(usr,"Set your employment notes here.","Employment Records",html_decode(gen_record)) as message

				if(genmsg != null)
					genmsg = copytext(genmsg, 1, MAX_PAPER_MESSAGE_LEN)
					genmsg = html_encode(genmsg)

					gen_record = genmsg
					SetRecords(user)

		else if (href_list["preference"] == "antagoptions")
			if(text2num(href_list["active"]) == 0)
				SetAntagoptions(user)
				return
			if (href_list["antagtask"] == "uplinktype")
				if (uplinklocation == "PDA")
					uplinklocation = "Headset"
				else if(uplinklocation == "Headset")
					uplinklocation = "None"
				else
					uplinklocation = "PDA"
				SetAntagoptions(user)
			if (href_list["antagtask"] == "done")
				user << browse(null, "window=antagoptions")
				ShowChoices(user)
			return 1

		switch(href_list["task"])
			if("random")
				switch(href_list["preference"])
					if("name")
						real_name = random_name(gender, dwarven_name = dwarven)
					if("age")
						age = rand(AGE_MIN, AGE_MAX)
					if("d_style")
						d_style = random_hair_style(gender, species)
					if("hair")
						r_hair = rand(0,255)
						g_hair = rand(0,255)
						b_hair = rand(0,255)
					if("h_style")
						h_style = random_hair_style(gender, species)
					if("facial")
						r_facial = rand(0,255)
						g_facial = rand(0,255)
						b_facial = rand(0,255)
					if("f_style")
						f_style = random_facial_hair_style(gender, species)
					if("underwear")
						underwear = rand(1,underwear_m.len)
						ShowChoices(user)
					if("eyes")
						r_eyes = rand(0,255)
						g_eyes = rand(0,255)
						b_eyes = rand(0,255)
					if("s_tone")
						s_tone = random_skin_tone()
					if("bag")
						backbag = rand(1,4)
					/*if("skin_style")
						h_style = random_skin_style(gender)*/
					if("all")
						randomize_appearance_for()	//no params needed
			if("input")
				switch(href_list["preference"])
					if("name")
						var/new_name = reject_bad_name( input(user, "Choose your character's name:", "Character Preference")  as text|null )
						if(new_name)
							real_name = new_name
						else
							to_chat(user, "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and .</font>")

					if("age")
						var/new_age = input(user, "Choose your character's age:\n([AGE_MIN]-[AGE_MAX])", "Character Preference") as num|null
						if(new_age)
							age = max(min( round(text2num(new_age)), AGE_MAX),AGE_MIN)

					if("b_type")
						var/new_b_type = input(user, "Choose your character's blood-type:", "Character Preference") as null|anything in list( "A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-" )
						if(new_b_type)
							b_type = new_b_type

					if("hair")
						if(species == "Human" || species == "Unathi")
							var/new_hair = input(user, "Choose your character's hair colour:", "Character Preference") as color|null
							if(new_hair)
								r_hair = hex2num(copytext(new_hair, 2, 4))
								g_hair = hex2num(copytext(new_hair, 4, 6))
								b_hair = hex2num(copytext(new_hair, 6, 8))


					if("detail")
						if(species == "Human" || species == "Unathi")
							var/new_detail = input(user, "Choose your character's detail colour:", "Character Preference") as color|null
							if(new_detail)
								r_detail = hex2num(copytext(new_detail, 2, 4))
								g_detail = hex2num(copytext(new_detail, 4, 6))
								b_detail = hex2num(copytext(new_detail, 6, 8))


					if("h_style")
						var/list/valid_hairstyles = list()
						for(var/hairstyle in hair_styles_list)
							var/datum/sprite_accessory/S = hair_styles_list[hairstyle]
							if( !(species in S.species_allowed))
								continue

							valid_hairstyles[hairstyle] = hair_styles_list[hairstyle]

						var/new_h_style = input(user, "Choose your character's hair style:", "Character Preference")  as null|anything in valid_hairstyles
						if(new_h_style)
							h_style = new_h_style

					if("facial")
						var/new_facial = input(user, "Choose your character's facial-hair colour:", "Character Preference") as color|null
						if(new_facial)
							r_facial = hex2num(copytext(new_facial, 2, 4))
							g_facial = hex2num(copytext(new_facial, 4, 6))
							b_facial = hex2num(copytext(new_facial, 6, 8))

					if("f_style")
						var/list/valid_facialhairstyles = list()
						for(var/facialhairstyle in facial_hair_styles_list)
							var/datum/sprite_accessory/S = facial_hair_styles_list[facialhairstyle]
							if(gender == MALE && S.gender == FEMALE)
								continue
							if(gender == FEMALE && S.gender == MALE)
								continue
							if( !(species in S.species_allowed))
								continue

							valid_facialhairstyles[facialhairstyle] = facial_hair_styles_list[facialhairstyle]

						var/new_f_style = input(user, "Choose your character's facial-hair style:", "Character Preference")  as null|anything in valid_facialhairstyles
						if(new_f_style)
							f_style = new_f_style

					if("d_style")
						var/list/valid_details = list()
						for(var/facialdetail in facial_details_list)
							var/datum/sprite_accessory/S = facial_details_list[facialdetail]
							if( !(species in S.species_allowed))
								continue

							valid_details[facialdetail] = facial_details_list[facialdetail]

						var/new_d_style = input(user, "Choose your character's hair style:", "Character Preference")  as null|anything in valid_details
						if(new_d_style)
							d_style = new_d_style

					if("vice")
						var/list/Vices = vices.Copy()
						Vices.Add("Random")
						if(age < 18)
							Vices.Remove("Sexoholic")
							Vices.Remove("Necrophile")
							Vices.Remove("Voyeur")
						var/chosen_vice = input(user, "Выберите порок своего персонажа:", "Character Preference")  as null|anything in Vices
						if(chosen_vice)
							vice = chosen_vice
						ShowChoices(user)

					if("zodiac")
						var/list/zodiacs = list("Лисица","Скала","Монеты","Пчела","Лебедь","Сверчок","Мизгирь","Кентавр","Сизиф","Зарница","Фантом","Сова")

						var/chosen_zodiac = input(user, "Выберите знак зодиака вашего персонажа:", "Character Preference")  as null|anything in zodiacs
						if(chosen_zodiac)
							zodiac = chosen_zodiac
						ShowChoices(user)
						to_chat(user, "<b><font color='green'><u>[zodiac]</u></font></b>")
						switch(zodiac)
							if("Лисица")
								to_chat(user, "<b>Ruler:</b> <i>Св. Петиро Отрёкшийся </i>")
								to_chat(user, "Вспыльчивые и абсурдно храбрые, лисицы похожи на невинных уличных детей. Они редко планируют наперед или думают, прежде чем действовать, и с готовностью примут любой вызов. Импульсивность и потребность побеждать часто не идут им на пользу, и только безудержная энергия помогает им избежать своих проблем. Лисицы любят преодолевать трудности и выходить победителями. Проявляя компетентность, они никогда не отступают и не сдаются, даже если это может причинить им боль. Они редко мечтают, потому что, когда они чего-то хотят, они идут и получают это. Они совсем не похожи на избалованных нарциссов, потому что их эгоизм наивен и ребяческий. Каждый их поступок пронизан вопросом: А как же я? Хотя их гнев (и желание, и любовь, и любой импульс) вспыхивает быстро, он длится недолго. После короткой вспышки они могут обнаружить, что перевязывают раны человека, которого минуту назад пытались убить.")
							if("Скала")
								to_chat(user, "<b>Ruler:</b> <i>Св. Сайлар Пещерный  </i>")
								to_chat(user, "Всегда спокойные и медлительные, они несколько ленивы и не тратят свою энергию на бессмысленные вещи. Но как только они выбирают цель, они устанавливают распорядок дня и неуклонно следуют ему, а рутина - это то, что Рокки терпеть не могут нарушать. Вывести их из себя невозможно, и еще труднее изменить их мнение по какому-либо вопросу, как только оно принято. Они очень собственнически относятся к любой своей собственности и часто ведут себя как Скруджи. Они не терпят, когда их торопят. Им трудно выразить словами свои чувства. Рокки не могут устоять перед физическими удовольствиями, но очень предусмотрительны и склонны накапливать свои богатства. Они не стыдятся предъявлять требования и очень настойчивы в них. Они стремятся к комфорту, роскоши и, прежде всего, стабильности.")
							if("Монеты")
								to_chat(user, "<b>Ruler:</b> <i>Св. Джаметта  </i>")
								to_chat(user, "Люди этого знака беспокойны, как крутящиеся монеты, и некоторые могут обвинить их в двуличии. Одна из их сторон любит поднимать настроение и приносить радость, другая предпочитает жестоко издеваться надо всеми и распространять сплетни. Их речи звучат как звон серебра, и они могли бы подкупить своих слушателей простыми словами. Ложь и полуправда всегда помогают нумису оставаться безнаказанным. Они легко усваивают новые знания и с радостью делятся ими, но не могут надолго сосредоточиться на каком-то одном предмете и редко специализируются на чем-либо. Они очень любопытны и любят реагировать на окружающее, всегда стараясь сделать резкое замечание по наиболее ярким деталям того, что они видят и слышат.")
							if("Пчела")
								to_chat(user, "<b>Ruler:</b> <i>Св. Дрюэт Рыбак</i>")
								to_chat(user, "Обычно вы не увидите их во время шумного застолья - независимо от их любви к еде, они предпочли бы спрятаться в своем одиночестве от внимания и возможных душевных ран. Мужчины этого знака скрывают свою уязвимость под показной мужественностью и доблестью. Сторонники традиций и старого образа жизни, они часто становятся искренними патриотами, заботливыми супругами и родителями; хотя их забота часто может быть навязчивой и раздражающей, они даже слишком много заботятся о своих друзьях. Они почти никогда не бывают спокойны из-за своей чувствительности и склонности к чрезмерной реакции и обычно ставят свои чувства выше разума. Им не чужды слезы и тревоги, но когда кто-то из их близких попадает в беду, Апи могут проявить себя как бесстрашные защитники.")
							if("Лебедь")
								to_chat(user, "<b>Ruler:</b> <i>Св. Ийон </i>")
								to_chat(user, "Всегда готовые заплатить гостеприимством за внимание и похвалу, щедрые лебеди любят быть в центре внимания общества. В любой момент они готовы оказать свою помощь бедным и беспомощным: им льстит мысль о том, что они спасители; как правило, они драматичны. Люди, рожденные под знаком Лебедя, уверены в себе и горды, их самый большой страх - потерять свое достоинство. Лесть - лучший способ завоевать их расположение. Дети легко растопляют их и без того теплые сердца, а Cygni балует их океанами заботы и любви.")
							if("Сверчок")
								to_chat(user, "<b>Ruler:</b> <i>Св. Вилппу</i>")
								to_chat(user, "Их раздутый здравый смысл и трудолюбие напоминают педантичных роботов-слуг из древних сказок. Но роботы, по крайней мере, не сыплют критикой каждую минуту! Грилли все время поправляет других и указывает на их недостатки, ошибки, отклонения - разумеется, с наилучшими намерениями. Они считают, что их наблюдения полезны. Они просто пытаются все исправить. Обычно они придерживаются высоких моральных стандартов, изо всех сил стараются быть полезными окружающим и не боятся тяжелой работы. Они не скрытны и сдерживают свое слово. Они приземленные, и их речь проста и логична. Их пристальное внимание к деталям хорошо служит Грилли, но делает их одержимыми аккуратностью и порядком. Они стараются быть идеальными и всегда боятся стать бесполезными и ненужными.")
							if("Мизгирь")
								to_chat(user, "<b>Ruler:</b> <i>Св. Тамаш</i>")
								to_chat(user, "Скрытные и недоверчивые, аранеи предпочитают наблюдать и манипулировать из-за кулис. За их твердыми масками скрывается огромное мстительное эго. Аранеи способны на длительные, поистине маниакальные усилия, которые подпитываются их похотью и насилием. Они воспринимают ложь, включая лесть, как попытки контролировать их, и немедленно становятся агрессивными. Они наслаждаются местью, даже если это им дорого обходится. Обычно они лояльны и чрезвычайно зависимы от своего партнера, видя в нем единственного союзника в своей борьбе против всего мира. Они втайне страстны, и из-за страстей и пороков они бессознательно стремятся сжечь себя, умереть - по крайней мере, метафорически - чтобы возродиться из пепла. Они презирают слабовольных и пассивных людей и не будут тратить свое время на тех, кого считают бесполезными. Хотя они больше всего ценят власть и влияние, Арены не хотят быть королями. Они предпочли бы быть невидимыми кукловодами за троном.")
							if("Кентавр")
								to_chat(user, "<b>Ruler:</b> <i>Св. Сантьяго</i>")
								to_chat(user, "Оставаясь оптимистичными и жизнерадостными даже на Севере, центавриане влюблены в жизнь. Они всегда в движении, будь то физические путешествия или просто религиозные и философские поиски Истины. Их легко узнать по их прямолинейной честности, которая может быть резкой, и неспособности убедительно лгать. Увы, их любовь к истине не распространяется на их обещания, которые они часто забывают выполнять. У центавриан много друзей, но они избегают формирования долгосрочных романтических связей, поскольку им ненавистна мысль о потере своей свободы. Они прирожденные искатели приключений: чем больше ставки, тем ярче их азарт. Они часто идут на глупый риск и не учатся на своих ошибках. Будучи нечувствительными к чувствам других, они часто агрессивны и склонны становиться фанатичными в своих убеждениях. ")
							if("Сизиф")
								to_chat(user, "<b>Ruler:</b> <i>Св. Морте</i>")
								to_chat(user, "Бизнес на первом месте. Эти амбициозные упрямцы знают цену золоту и успеху, и они готовы упорно трудиться столько, сколько потребуется, чтобы достичь всего этого. Сизифини ценят надежность и практическую выгоду и часто неодобрительно относятся к фантазиям и развлечениям.Они преданы как людям, так и делу, но они не умеют прощать. Они скрывают свои эмоции и выражают свое остроумие с помощью сухого и саркастического юмора. Холодная самодисциплина только укрепляет их стальную хватку, которую они используют для управления людьми и ресурсами. Они ненавидят ненужные риски и непредсказуемость и никому не позволят нанести ущерб их общественному имиджу. Несмотря на свою целеустремленность и решительность, они склонны к пессимизму и у них много тяжелых мыслей. Их восхождение может быть долгим и мучительным, но в конце концов они неизбежно достигнут вершины своей горы.")
							if("Зарница")
								to_chat(user, "<b>Ruler:</b> <i>Св. Фаддьо</i>")
								to_chat(user, "Электро-заряженные, Фулгурри с искрящимся энтузиазмом воспринимает все новое и эксцентричное. Не повседневные дела, а высокие идеи и парадигмы озаряют их умы. Общепринятые мнения вызывают у них раздражение, поэтому они придерживаются причудливых концепций и любят нарушать табу. Они очень любят инструменты и механизмы - и часто скорбят по поводу нынешнего технологического коллапса. Они относятся к людям с отстраненным дружелюбием: все равны и одинаково удивительны, поэтому никто не выделяется. Холодность не мешает им быть альтруистами, идеалистически взирающими на остатки человечества, видящими его туманное будущее в ярко-розовых тонах. Они рады работать над тем, чтобы сделать мир лучше. Они склонны избегать эмоциональных ситуаций, но те, кто осмеливается не соглашаться с их идеями и мнениями или угрожать их свободе или свободомыслию, вскоре вызовут на себя настоящую бурю.")
							if("Фантом")
								to_chat(user, "<b>Ruler:</b> <i>Св. Глютта  </i>")
								to_chat(user, "Ускользающие и изменчивые, фантомы растворяются в мечтах и тревогах: им трудно отличить правду от лжи, реальность от вымысла. Они легко доверяют другим и верят в свою собственную ложь. У них печальное, безвольное сердце, но оно полно сострадания к каждому страдающему существу: боль и несчастье привлекают к ним прирожденных последователей, они редко отказывают в просьбе, даже когда знают, что их добротой пользуются. Им легко подчиняться, и они приспосабливаются к любым условиям, как газ, заполняющий форму контейнера. Обычно они добиваются желаемого, заставляя человека чувствовать себя виноватым из-за бесконечных жалоб и достойного сожаления поведения, или вызывая сочувствие и всеобщий гнев по отношению к кому-либо с помощью клеветы и слезливых историй об ужасном насилии - даже если они не совсем правдивы. Фантомы часто ставят себя в ситуации, когда они могли бы стать жертвой, и они топят себя в алкоголе и наркотиках после того, как это, наконец, происходит. Они верят, что только любовь может спасти их, но чувствуют себя слишком неуверенно, чтобы найти ее.")
							if("Сова")
								to_chat(user, "<b>Ruler:</b> <i>Св. Варомолей  </i>")
								to_chat(user, "Яростные борцы за справедливость, в невинные времена они ткут шелк легкого флирта и приятных манер.Ноктуа любят разрешать конфликты и давать советы. Они находят спокойное счастье в искусстве, эстетике и покое. Грубые люди, несправедливость и жестокость вызывают у них отвращение. Их вечная проблема - нерешительность: им приходится взвешивать каждую мелочь, прежде чем сделать свой выбор, что может довести других до белого каления. Они ненавидят причинять людям боль и постараются скрыть любую неприятную правду.")

					if("underwear")
						var/list/underwear_options
						if(gender == MALE)
							underwear_options = underwear_m
						else
							underwear_options = underwear_f

						var/new_underwear = input(user, "Choose your character's underwear:", "Character Preference")  as null|anything in underwear_options
						if(new_underwear)
							underwear = underwear_options.Find(new_underwear)
						ShowChoices(user)

					if("eyes")
						var/new_eyes = input(user, "Choose your character's eye colour:", "Character Preference") as color|null
						if(new_eyes)
							r_eyes = hex2num(copytext(new_eyes, 2, 4))
							g_eyes = hex2num(copytext(new_eyes, 4, 6))
							b_eyes = hex2num(copytext(new_eyes, 6, 8))

					if("s_tone")
						if(species != "Human")
							return
						var/new_s_tone = input(user, "Choose your character's skin-tone:\n(Light 1 - 255 Dark)", "Character Preference")  as num|null
						if(new_s_tone)
							s_tone = 35 - max(min( round(new_s_tone), 255),1)

					if("ooccolor")
						var/new_ooccolor = input(user, "Choose your OOC colour:", "Game Preference") as color|null
						if(new_ooccolor)
							ooccolor = new_ooccolor

					if("bag")
						var/new_backbag = input(user, "Choose your character's style of bag:", "Character Preference")  as null|anything in backbaglist
						if(new_backbag)
							backbag = backbaglist.Find(new_backbag)

					if("nt_relation")
						var/new_relation = input(user, "Choose your relation to NT. Note that this represents what others can find out about your character by researching your background, not what your character actually thinks.", "Character Preference")  as null|anything in list("Loyal", "Supportive", "Neutral", "Skeptical", "Opposed")
						if(new_relation)
							nanotrasen_relation = new_relation

					if("disabilities")
						if(text2num(href_list["disabilities"]) >= -1)
							if(text2num(href_list["disabilities"]) >= 0)
								disabilities ^= (1<<text2num(href_list["disabilities"])) //MAGIC
							SetDisabilities(user)
							return
						else
							user << browse(null, "window=disabil")

					if("limbs")
						var/limb_name = input(user, "Which limb do you want to change?") as null|anything in list("Left Leg","Right Leg","Left Arm","Right Arm","Left Foot","Right Foot","Left Hand","Right Hand")
						if(!limb_name) return

						var/limb = null
						var/second_limb = null // if you try to change the arm, the hand should also change
						var/third_limb = null  // if you try to unchange the hand, the arm should also change
						switch(limb_name)
							if("Left Leg")
								limb = "l_leg"
								second_limb = "l_foot"
							if("Right Leg")
								limb = "r_leg"
								second_limb = "r_foot"
							if("Left Arm")
								limb = "l_arm"
								second_limb = "l_hand"
							if("Right Arm")
								limb = "r_arm"
								second_limb = "r_hand"
							if("Left Foot")
								limb = "l_foot"
								third_limb = "l_leg"
							if("Right Foot")
								limb = "r_foot"
								third_limb = "r_leg"
							if("Left Hand")
								limb = "l_hand"
								third_limb = "l_arm"
							if("Right Hand")
								limb = "r_hand"
								third_limb = "r_arm"

						var/new_state = input(user, "What state do you wish the limb to be in?") as null|anything in list("Normal","Amputated","Prothesis")
						if(!new_state) return

						switch(new_state)
							if("Normal")
								organ_data[limb] = null
								if(third_limb)
									organ_data[third_limb] = null
							if("Amputated")
								organ_data[limb] = "amputated"
								if(second_limb)
									organ_data[second_limb] = "amputated"
							if("Prothesis")
								organ_data[limb] = "cyborg"
								if(second_limb)
									organ_data[second_limb] = "cyborg"

					if("organs")
						var/organ_name = input(user, "Which internal function do you want to change?") as null|anything in list("Heart", "Eyes")
						if(!organ_name) return

						var/organ = null
						switch(organ_name)
							if("Heart")
								organ = "heart"
							if("Eyes")
								organ = "eyes"

						var/new_state = input(user, "What state do you wish the organ to be in?") as null|anything in list("Normal","Assisted","Mechanical")
						if(!new_state) return

						switch(new_state)
							if("Normal")
								organ_data[organ] = null
							if("Assisted")
								organ_data[organ] = "assisted"
							if("Mechanical")
								organ_data[organ] = "mechanical"

					if("skin_style")
						var/skin_style_name = input(user, "Select a new skin style") as null|anything in list("default1", "default2", "default3")
						if(!skin_style_name) return

			else
				switch(href_list["preference"])
					if("gender")
						N.ready = FALSE
						if(gender == MALE)
							gender = FEMALE
						else
							gender = MALE
						user << browse(null, "window=latechoices")

					if("dwarven")
						dwarven = !dwarven

					if("fatness")
						fat = !fat

					if("religion")
						if(religion == LEGAL_RELIGION)
							religion = "Heresy"
						else
							religion = LEGAL_RELIGION

					if("family")
						family = !family

					if("lobbybe")
						var/foi = 0
						if(lobbyspecie == "Child")
							lobbyspecie = "Adult"
							foi = 1

						if(lobbyspecie == "Adult" && !foi)
							lobbyspecie = "Child"

					if("toggleLobbyScreen")
						toggleLobbyScreen = !toggleLobbyScreen

					if("inqui")
						//var/inquisidor_tipos = input(user, "Escolha o seu tipo de Inquisidor.") as null|anything in list("Velhos Tempos", "| O Fanatico |", "o Conhecedor o", "() Lobo Solitario ()", "- Respeitado -", "Ω \[Beberrao] Ω", "* Perspicaz *", " / Informado \\ ", "@ Espadachim @", "→ Investigador ←", "§ Lider §", "○ Corrupto ○")
						var/inquisidor_tipos = input(user, "Выберите свой тип инквизитора.") as null|anything in list("Standard", "Month's Inquisitor", "Holy War Veterans", "Master", "Corrupt", "Fanatic", "King's Favourite")
						if(inquisidor_tipos)
							InquisiPref = inquisidor_tipos
							to_chat(user, "<b><span class='passivebold'>[InquisiPref]</span></b>")
							switch(InquisiPref)
								if("Standard")
									to_chat(user, "Недавно вас отправили в крепость Фаэторн для расследования утверждений о местной отколовшейся ячейке танати.")
								if("Month's Inquisitor")
									to_chat(user, "Отличник, который произвел неизгладимое впечатление на НКВД. Его выдающиеся достижения были признаны его начальством, и они возлагали на него большие надежды.")
									to_chat(user, "<b>Соберите 6 признаний с помощью вашего автомата для исповеди и получите вознаграждение.</b>")
								if("Holy War Veterans")
									to_chat(user, "Однажды вы провели санкционированное подразделение религиозных воинов через Зеленый ад во время ушедшей Священной войны. Все, что сегодня осталось от вашего отряда, - это несколько товарищей, которых вы теперь называете своими практиками. Те дни остались позади, и вы больше не пользуетесь грубыми инструментами и архаичными методами допроса.")
									to_chat(user, "<b>Наши клинки остры.</b>")
								if("Master")
									to_chat(user, "Неунывающий мастер оружия, прошедший специальную подготовку в Аракбо; боевое искусство, когда-то разработанное для борьбы с пользователями переносных щитов из-за их относительно высокой скорости проникновения.")
									to_chat(user, "<b>Предпочитая работать в одиночку, он доказал, что способен действовать в одиночку в качестве сотрудника НКВД по делу Фаэторна.</b>")
								if("Corrupt")
									to_chat(user, "Шантаж и взяточничество для вас не в новинку; вы совершали чудовищные преступления в качестве инквизитора НКВД и подставляли другую щеку вместо выполнения своих священных обязанностей за 30 сребреников. Начальник знает о ваших проступках - к счастью, тот, у кого на руках все карты, хуже вас.")
									to_chat(user, "<b>За каждое признание, вырванное у дворянина, полагается награда.</b>")
								if("Fanatic")
									to_chat(user, "Те, кто вас окружает, быстро замечают ваше безошибочно неумолимое рвение, а те, кто этого не делает, еще быстрее понимают, почему они должны это делать.")
									to_chat(user, "<b>Вы всегда чувствовали, что Бог улыбается вам за то, что вы его духовный мученик, и Святые алтари не оскверняются при использовании.</b>")
								if("King's Favourite")
									to_chat(user, "Король считал его безжалостным спасителем душ.")
									to_chat(user, "<b>Архиепископ инквизиции наградил вас несколькими особыми дарами, включая расширенный арсенал.</b>")

					if("gatekeeper")
						var/gatekeeper_tipos = input(user, "Выберите свой тип привратника.") as null|anything in list("Monk", "Chariot")
						if(gatekeeper_tipos)
							GatekeeperPref = gatekeeper_tipos
							to_chat(user, "<b><span class ='passivebold'>[GatekeeperPref]</span></b>")
							switch(GatekeeperPref)
								if("Monk")
									to_chat(user, "Слишком набожный и богобоязненный для Тимоти Гаррисона. Монах - неэффективный боец, но в битвах с танати им нет равных.")
									to_chat(user, "Вы предпочитаете искусство уничтожать своих врагов с большого расстояния. <b> Вы вооружены законным гравитационным импульсом.</b>")
								if("Chariot")
									to_chat(user, "Одержимый фанатик, который лично очищает пещеры от танати, примитивный ветеран какого-то давно минувшего конфликта.")
									to_chat(user, "Вы предпочитаете сближение на личном уровне. <b>Вы вооружены плитой.</b>")


					if("baron")
						//var/inquisidor_tipos = input(user, "Escolha o seu tipo de Inquisidor.") as null|anything in list("Velhos Tempos", "| O Fanatico |", "o Conhecedor o", "() Lobo Solitario ()", "- Respeitado -", "Ω \[Beberrao] Ω", "* Perspicaz *", " / Informado \\ ", "@ Espadachim @", "→ Investigador ←", "§ Lider §", "○ Corrupto ○")
						var/baron_tipos = input(user, "Выбери мотив для тирана, которым ты станешь. Это ответ на вопрос: 'Почему люди ненавидят тебя?' без механического воздействия.") as null|anything in list("Paranoia","Sadism","Greed", "Stability", "Idealism", "Self-Indulgence (None)")
						if(baron_tipos)
							BaronPref = baron_tipos
							var/Title = "None"
							var/toChatBegin = "None"
							var/Enemies = "None"
							switch(baron_tipos)
								if("Paranoia")
									Title = "Паранойя"
									toChatBegin = "Ты - мишень в короне. Самый могущественный, но и самый запуганный человек в крепости. Вы не можете доверять никому, кроме своих собственных мер предосторожности."
									Enemies = "Твои охранники. Твоя семья. Ваши подданные."
								if("Sadism")
									Title = "Садизм"
									toChatBegin = "Разве это не здорово - причинять боль? Душевная боль - это самое лучшее, и ужас в их глазах. Чтобы сокрушить и унизить!"
									Enemies = "Вас осуждают за то, что вы сделали, но только шепотом. Те, в ком еще теплится хоть капля морали, были бы счастливы увидеть тебя повешенным."
								if("Greed")
									Title = "Жадность"
									toChatBegin = "Никто не обвинит вас в расточительности. Нельзя владеть всем, не экономя на всем."
									Enemies = "Одни ненавидят вас за вашу алчность, другие просто завидуют вашим богатствам и мечтают прибрать их к своим рукам."
								if("Stability")
									Title = "Стабильность"
									toChatBegin = "Как было, так и будет. Перемены приносят беспокойство и осложнения всем, от подданных до самого великого барона."
									Enemies = "Молодые люди и идеалисты особенно презирают вас за ваше косное мышление"
								if("Idealism")
									Title = "Идеализм"
									toChatBegin = "Вы строите лучший мир для своих людей, заботясь о них, даже когда они этого не хотят. "
									Enemies = "Не всем нравится новый порядок, потому что раньше он всегда был лучше."
							if(baron_tipos != "Self-Indulgence (None)")
								to_chat(user, "\n<div class='firstdivmood'><div class='moodbox'><span class='bname'><p style='font-size:20px'>[Title]</p></span>[toChatBegin]</span>\n<span class='bname'>Enemies:</span>\n [Enemies]</div></div>")
							user << 'special_toggle.ogg'

					if("province")
						//var/inquisidor_tipos = input(user, "Escolha o seu tipo de Inquisidor.") as null|anything in list("Velhos Tempos", "| O Fanatico |", "o Conhecedor o", "() Lobo Solitario ()", "- Respeitado -", "Ω \[Beberrao] Ω", "* Perspicaz *", " / Informado \\ ", "@ Espadachim @", "→ Investigador ←", "§ Lider §", "○ Corrupto ○")
						var/provinces = input(user, "Выберите место, откуда родом ваш персонаж (Затрагивает только мигрантов)") as null|anything in list("Ravenheart","Wei Ji Burrows", "Salar","Savo","Wanderer")
						if(provinces)
							MigProvince = provinces
							to_chat(user, "<b>Province:</b> <i>[MigProvince]</i>")
							var/dat = {"<HTML><META http-equiv="X-UA-Compatible" content="IE=edge" charset="UTF-8"><style type="text/css"> body {font-family: Times; cursor: url('http://lfwb.ru/Icons/pointer.cur'), auto;} a {text-decoration:none;outline: none;border: none;margin:-1px;} a:focus{outline:none;} a:hover {color:#0d0d0d;background:#505055;outline: none;border: none;} a.active { text-decoration:none; color:#533333;} a.inactive:hover {color:#0d0d0d;background:#bb0000} a.active:hover {color:#bb0000;background:#0f0f0f} a.inactive:hover { text-decoration:none; color:#0d0d0d; background:#bb0000}</style> <body background bgColor=#0d0d0d text=#862525 alink=#777777 vlink=#777777 link=#777777><HEAD><TITLE>[MigProvince]</TITLE></HEAD><BODY>"}
							dat += "<h1>[MigProvince]</h1><br>"
							switch(MigProvince)
								if("Ravenheart")
									dat += "<h3><b>Правитель:</b> <i>Никто (Left for Leviathan)</i></h3>"
									dat += "<br>Равенхарт расположен на севере планетарного королевства Эвергрин. Своим возникновением он обязан древним высокотехнологичным руинам, на которых был построен; здесь можно найти сложные машины и оборудование такого же масштаба, как и в столице планеты. Эта некогда богатая вотчина теперь прозябает из-за ошибок нынешнего правителя. Однако есть некоторая передышка в бедствиях, которые преследовали последние годы, в виде надежды: беженцы с юга массово мигрируют на Север. Дешевая рабочая сила и экономическое процветание приходят в виде этих мигрантов, поскольку старые охотничьи угодья и древние рудники в этом районе почти полностью нетронуты и ждут, когда их начнут эксплуатировать. Воронье Сердце было оставлено гнить после того, как барон отправился на Левиафан, а попытка продать крепость с аукциона провалилась."
								if("Wei Ji Burrows")
									dat += "<h3><b>Правитель:</b> <i>Неизвестный</i></h3>"
									dat += "<br>Норы Вэй Цзи - самый густонаселенный регион Эвергрина, обширная система туннелей и выдолбленных пещер, где без конца происходят торговля, промышленность и сельское хозяйство. Известно, что гинки гордятся своей продуктивной натурой и гордятся как великим проектом Берроузов, так и своими собственными династиями. И все же величайшей династией из всех является династия Цзи, которая планирует окончательный уход Бога-короля Шерольда и его людей. Герцог Восточный строит козни за контроль над Эвергрином, заключая союзы и внедряя преданных агентов при дворах других дворян. Он знает, что что-то надвигается на Эвергрин, и планирует его защиту. В то время как значительная часть населения занимается сельским хозяйством, чтобы прокормить город, ухаживая за террасами на берегу реки, постоянная армия следит за кварталами размером с город, собирая налоги и обеспечивая мир. Иметь семью в Нефритовой армии - знак великой чести для династии, и хотя ИНКВД называет практику поклонения предкам Гинков ересью, они обычно не осмеливаются заходить в Норы."
								if("Deadeye")
									dat += "<h3><b>Правитель:</b> <i>Доротея Проклятая, баронесса-разбойница</i></h3>"
									dat += "<br>Этим городом полностью правят преступники, но не в традиционном смысле, когда лорд ворует у своего народа и использует силу, чтобы получить то, что они хотят. Нет, бандиты штурмовали этот город и захватили его как свой собственный, а их лидер силой заставил нынешнего лидера передать им власть. Большая часть богатств города “перепрофилируется” из проходящих караванов или других деревень, которыми командуют бандитские армии криминального лорда с обильной долей добычи. Тем не менее, это очень упорядоченно, поскольку, хотя бандиты будут грабить и разорять других, они придерживаются правил босса дома. Даже если вы простой землекоп или кузнец из Deadeye, каждый может почерпнуть там какие-нибудь хитрости или советы. Жители известны как диабетики."
									dat += "<br><p style='color:#cccfcd'><i>Small chances of you being wanted. Bandits recognize your homeland, but that doesn't make them friendly.</i></p>"
								if("Savo")
									dat += "<h3><b>Правитель:</b> <i>Сэр Джейкоб Недостойный</i></h3>"
									dat += "<br>Рыбацкая деревушка, приютившаяся глубоко в пещерной системе близ Равенхарта, воздух здесь влажный, а рыба, выловленная из рек, теплая на ощупь, лепечет и поет причудливую чепуху. Рыцарь, опозоренный своими потерями в крестовых походах, получил власть над этим маленьким поселением, а правление его землей и его титул были дарованы Северному Ворону. Жители Саво странно приветливы к чужакам, и многие, кто покидает их гостеприимство, уносят эту доброту с собой. Ходят слухи, что это территория танати, со скрытыми конспиративными квартирами для их агентов и всех людей, преданных их делу. Даже те, кто остается верен свету косметики, тронуты дарами дышащих потоков, когда спокойные уловы безмятежно плывут к их приманкам."
								if("Salar")
									dat += "<h3><b>Правитель:</b> <i>Владимир Сталино</i></h3>"
									dat += "<br>Вы родом из провинции Салара."
								if("Wanderer")
									dat += "<h3><b>Правитель:</b> <i>Никто</i></h3>"
									dat += "<br>У тебя нет родины, ты никто."
									dat += "<br><p style='color:#cccfcd'><i>Default.</i></p>"
							dat += "</BODY></HTML>"
							user << browse(dat, "window=province;size=450x500;can_resize=0;")

					if("disabilities")				//please note: current code only allows nearsightedness as a disability
						disabilities = !disabilities//if you want to add actual disabilities, code that selects them should be here

					if("hear_adminhelps")
						toggles ^= SOUND_ADMINHELP

					if("ui")
						switch(UI_type)
							if("Luna") //"Orange"
								UI_type = "Luna"
								UI_style = "Luna"
							if("Retro")
								UI_type = "Retro"
								UI_style = "Luna"
							else
								UI_type = "Luna"//"Midnight"
								UI_style = "Luna"
					if("uistyle")
						if(UI_type == "Luna")
							switch(UI_style)
								if("Luna") //"Orange"
									UI_style = "Orange"
								else
									UI_style = "Luna"
  // I don't need this bay12 shit

					if("be_special")
						be_special = 1

					if("name")
						be_random_name = !be_random_name

					if("hear_midis")
						toggles ^= SOUND_MIDI

					if("lobby_music")
						toggles ^= SOUND_LOBBY
						if(toggles & SOUND_LOBBY)
							user << sound(ticker.login_music, repeat = 0, wait = 0, volume = 70, channel = 1)
						else
							user << sound(null, repeat = 0, wait = 0, volume = 85, channel = 1)

					if("ghost_ears")
						toggles ^= CHAT_GHOSTEARS

					if("ghost_sight")
						toggles ^= CHAT_GHOSTSIGHT

					if("ghost_radio")
						toggles ^= CHAT_GHOSTRADIO

					if("save")
						save_preferences()
						save_character()

					if("reload")
						load_preferences()
						load_character()

					if("open_load_dialog")
						if(!IsGuestKey(user.key))
							open_load_dialog(user)

					if("close_load_dialog")
						close_load_dialog(user)

					if("changeslot")
						user << browse(null, "window=latechoices")
						load_character(text2num(href_list["num"]))
						close_load_dialog(user)

		ShowChoices(user)
		return 1

	proc/copy_to(mob/living/carbon/human/character, safety = 0)
		if(be_random_name)
			real_name = random_name(gender, dwarven_name = dwarven)

		var/firstspace = findtext(real_name, " ")
		var/name_length = length(real_name)
		if(!firstspace)	//we need a surname
			real_name += " [pick(last_names)]"
		else if(firstspace == name_length)
			real_name += "[pick(last_names)]"

		for(var/mob/living/carbon/namecheck in mob_list)
			if(namecheck.real_name == real_name)
				real_name = random_name(gender, dwarven_name = dwarven)
				break

		character.real_name = real_name
		character.name = character.real_name
		if(character.dna)
			character.dna.real_name = character.real_name

		character.flavor_texts["general"] = flavor_texts["general"]
		character.flavor_texts["head"] = flavor_texts["head"]
		character.flavor_texts["face"] = flavor_texts["face"]
		character.flavor_texts["eyes"] = flavor_texts["eyes"]
		character.flavor_texts["torso"] = flavor_texts["torso"]
		character.flavor_texts["arms"] = flavor_texts["arms"]
		character.flavor_texts["hands"] = flavor_texts["hands"]
		character.flavor_texts["legs"] = flavor_texts["legs"]
		character.flavor_texts["feet"] = flavor_texts["feet"]

		character.med_record = med_record
		character.sec_record = sec_record
		character.gen_record = gen_record

		character.gender = gender
		character.age = age
		character.b_type = b_type
		character.religion = religion

		character.r_eyes = r_eyes
		character.g_eyes = g_eyes
		character.b_eyes = b_eyes

		character.r_detail = r_detail
		character.g_detail = g_detail
		character.b_detail = b_detail

		character.r_hair = r_hair
		character.g_hair = g_hair
		character.b_hair = b_hair

		character.r_facial = r_facial
		character.g_facial = g_facial
		character.b_facial = b_facial

		character.s_tone = s_tone

		character.h_style = h_style
		character.f_style = f_style
		character.d_style = d_style

		character.applyVice(vice)
		character.province = MigProvince
		character.applyProvince()
		if(vice == "Random")
			if(prob(60))
				vice = pick(VicesList)
			else
				vice = null
			character.vice = vice
		character.favorite_beverage = pick("Water","Rum","Beer","Wine")
		character.zodiac = zodiac
		switch(character.zodiac)
			if("Лисица")
				if(prob(25))
					character.my_stats.dx += 1
			if("Сверчок")
				if(prob(25))
					character.my_skills.ADD_SKILL(SKILL_PARTY, rand(1,2))
			if("Сизиф")
				if(prob(25))
					//character.jewish = TRUE
					character.add_perk(/datum/perk/ref/value)
			if("Мизгирь")
				if(prob(25))
					//character.jewish = TRUE
					character.add_perk(/datum/perk/sexaddict)
			if("Лебедь")
				if(prob(25))
					character.add_event("nobleblood", /datum/happiness_event/noble_blood)
			if("Кентавр")
				if(prob(25))
					character.my_stats.ht += 1
			if("Сова")
				if(prob(25))
					character.add_perk(/datum/perk/likeart)
			if("Фантом")
				if(prob(50))
					character.my_skills.ADD_SKILL(SKILL_PARTY, rand(2,3))
				else
					character.my_skills.ADD_SKILL(SKILL_SNEAK, rand(2,3))
		if(character.job == "Heir" || character.job == "Successor" || character.job == "Treasurer")
			if(lobbyspecie != "Adult")
				character.set_species("Child")
				character.species.handle_post_spawn(character)
				character.my_stats.st -= rand(3,5)
				character.my_stats.ht -= rand(3,5)
				character.vice = null
		if(character.job == "Jester")
			if(lobbyspecie == "Adult")
				character.set_species("Midget")
		if(character.job == "Inquisitor" && InquisiPref)
			Inquisitor_Type = InquisiPref
		if(character.job == "Incarn" && GatekeeperPref)
			Gatekeeper_Type = GatekeeperPref
/*		if(character.client.married)
			for(var/mob/living/carbon/human/H in player_list)
				if(H.client.married == character.key)
					if(character.client.married == character.key)
						var/I = image('icons/mob/mob.dmi', loc = H, icon_state = "love")
						character.client.images += I
*/
		// Destroy/cyborgize organs

		for(var/name in organ_data)
			var/datum/organ/external/O = character.organs_by_name[name]
			var/datum/organ/internal/I = character.internal_organs_by_name[name]
			var/status = organ_data[name]

			if(status == "amputated")
				O.amputated = 1
				O.status |= ORGAN_DESTROYED
				O.destspawn = 1
			if(status == "cyborg")
				O.status |= ORGAN_ROBOT
			if(status == "assisted")
				I.mechassist()
			else if(status == "mechanical")
				I.mechanize()

			else continue

		if(underwear > underwear_m.len || underwear < 1)
			underwear = 0 //I'm sure this is 100% unnecessary, but I'm paranoid... sue me. //HAH NOW NO MORE MAGIC CLONING UNDIES
		character.underwear = underwear

		if(backbag > 4 || backbag < 1)
			backbag = 1 //Same as above
		character.backbag = backbag
		if(thirtycm.Find(character.ckey) && character.has_penis())
			character.potenzia = 30
		if(baliset.Find(character.ckey))
			character.my_skills.CHANGE_SKILL(SKILL_MUSIC, rand(13,15))
		if(singer.Find(character.ckey))
			character.add_perk(/datum/perk/singer)
			character.verbs += /mob/living/carbon/human/proc/remembersong
			character.verbs += /mob/living/carbon/human/proc/sing
		//Debugging report to track down a bug, which randomly assigned the plural gender to people.
		if(character.gender in list(PLURAL, NEUTER))
			if(isliving(src)) //Ghosts get neuter by default
				message_admins("[character] ([character.ckey]) has spawned with their gender as plural or neuter. Please notify coders.")
				character.gender = MALE

		if(fat)
			if(character.species.name != "Child")
				character.mutations += FAT

	proc/open_load_dialog(mob/user)
		var/dat = "<head><META http-equiv='X-UA-Compatible' content='IE=edge' charset='UTF-8'><Title>Farweb</title><style type='text/css'>"
		dat += "cursor: url('pointer.cur'), auto;body {font-family: Times;}a {text-decoration:none;outline: none;border: none;margin:-1px;}a:focus{outline:none;}a:hover {color:#0d0d0d;background:#505055;outline: none;border: none;}a.active { text-decoration:none; color:#533333;}a.inactive:hover {color:#0d0d0d;background:#bb0000}a.active:hover {color:#bb0000;background:#0f0f0f}a.inactive:hover { text-decoration:none; color:#0d0d0d; background:#bb0000}</style>"
		dat += "</head><body background bgColor=#0d0d0d text=#555555 alink=#777777 vlink=#777777 link=#777777>"
		dat += "<tt><center>"

		var/savefile/S = new /savefile(path)
		if(S)
			var/name
			var/age
			for(var/i=1, i<=MAX_SAVE_SLOTS, i++)
				S.cd = "/character[i]"
				S["real_name"] >> name
				S["age"] >> age
				if(!name)	name = "Create"
				if(!age)    age = 0
				if(i==default_slot)
					name = "[i]. <b>[name]</b>, [age]"
				dat += "<a href='?_src_=prefs;preference=changeslot;num=[i];'>[name]</a><br>"
		dat += "<br><br>"
		dat += "<a href='byond://?src=\ref[user];preference=close_load_dialog'>Close</a><br>"
		dat += "</center></tt>"
		user << browse(dat, "window=saves;size=300x390")

	proc/close_load_dialog(mob/user)
		user << browse(null, "window=saves")

client/var/fullscreen = 0

client/New()
	..()
	FullscreenLoad()
	LoadGraphics()
	show_popup_menus = 0

/client/verb/set_spouse()
	set hidden = 0
	set category = "OOC"
	set name = "Set Spouse"
	set desc="Choose your spouse!"
	var/list/keys = list()
	for(var/mob/M in player_list)
		keys += M.client
	var/selection = input("Selecione um par!", "setspouse", null, null) as null|anything in sortKey(keys)
	if(!selection)
		return
	if(selection == src.key)
		return

	if(master_mode == "holywar")
		var/mob/M = selection:mob
		to_chat(src,"[selection] received your death request.")
		to_chat(M,"<span class='highlighttext'>[src] wants to drink your blood from your skull. You must give your consent.</span>")
		return
	else
		var/mob/M = selection:mob
		if(M.client == src)
			to_chat(src, "<span class='combatbold'>FAIL!</span><span class=combat'>You can't fuck yourself!</span>")
			return
		for(var/datum/set_spouse/D in pending_set_spouse)
			if(M.client == D.sender && D.target != src)
				to_chat(src, "[selection] уже отправил запрос другому лицу.")
				return

			if((M.client == D.target || M.client == D.sender) && D.accepted == TRUE)
				to_chat(src, "[selection] уже состоит в отношениях.")
				return

			if(src == D.sender && M.client == D.target)
				to_chat(src, "Вы отменяете установленный запрос супруга [selection].")
				to_chat(M,"[src] больше не хочет быть вашим супругом.")
				D.sender = null
				D.target = null
				qdel(D)
				return

			if(M.client == D.sender && src == D.target)
				to_chat(M.client, "[src] принимает ваш запрос.")
				to_chat(src,"Вы принимаете [selection]'s запрос")
				D.accepted = TRUE
				return

			if(src == D.sender)
				to_chat(src, "Отмените свой старый запрос, если вы хотите сделать новый.")
				return

		to_chat(src,"[selection] получен ваш запрос о выборе супруга.")
		to_chat(M,"[src] выбирает вас в качестве супруга. Вы должны дать свое согласие <i>(F11, введите setspouse и выберите их имя, чтобы принять запрос стать вашим супругом)</i>")
		var/datum/set_spouse/D = new()
		D.sender = src
		D.target = M.client
		set_spoused |= src
		set_spoused |= M.client
		pending_set_spouse |= D
		return

var/global/lovedepletion = 0

/client/verb/sendlove()
	set hidden = 0
	set category = "OOC"
	set name = "Love"
	set desc="Send Love!"
	var/list/keys = list()
	if(lovedepletion >= 3)
		to_chat(src,"<font color='#fc0fc0'><b>FAIL!</b> All love was wasted.</font>")
		return
	for(var/mob/M in player_list)
		keys += M.client
	var/selection = input("Пошлите кому-нибудь любовь!", "sendlove", null, null) as null|anything in sortKey(keys)
	if(!selection)
		return
	if(findtext(selection, src.key))
		to_chat(src,"<font color='#fc0fc0'><b>FAIL!</b> Ты эгоистичная сучка.</font>")
		return
	if (ticker.current_state == GAME_STATE_PLAYING)
		return
	var/mob/M = selection:mob
	if(master_mode == "holywar")
		var/action = pick("stabs","cuts","tortures","bashes","shoots")
		to_chat(world,"<font color='#fa2605'><b>[src.key]</b> [action] <b>[M.client.key]!</b></font>")
	else
		to_chat(world,"<font color='#fc0fc0'><b>[src.key]</b> посылает любовь <b>[M.client.key]!</b></font>")
	lovedepletion++
	return

client/verb/ToggleRightClick()
	set name = "Toggle-RightClick(NO.)"
	set category = "OOC"
	show_popup_menus = !show_popup_menus

client/verb/FullscreenLoad()
	set name = ".toggleload"
	set category = "OOC"
	if(src.prefs.fullscreenSetting)
		ToggleFullscreen()

client/verb/ToggleFullscreen()
	set name = ".togglefullscreen"
	set category = "OOC"
	src.prefs.fullscreenSetting = !src.prefs.fullscreenSetting
	if(src.prefs.fullscreenSetting)
		winset(src, "mainwindow", "is-maximized=false;can-resize=false;titlebar=false;menu=")
		winset(src, "mainwindow", "is-maximized=true")
	else
		winset(src, "mainwindow", "is-maximized=false;can-resize=true;titlebar=true;menu=menu")
	src.prefs.save_preferences()

client/verb/LoadGraphics()
	set name = ".loadgraphics"
	set category = "OOC"
	if(src.prefs.graphicsSetting)
		winset(src, "mapwindow.map", "zoom-mode=distort")
	else
		winset(src, "mapwindow.map", "zoom-mode=normal")

client/verb/ToggleGraphics()
	set name = ".togglegraphics"
	set category = "OOC"
	src.prefs.graphicsSetting = !src.prefs.graphicsSetting
	if(src.prefs.graphicsSetting)
		winset(src, "mapwindow.map", "zoom-mode=distort")
	else
		winset(src, "mapwindow.map", "zoom-mode=normal")
	src.prefs.save_preferences()

client/verb/addEffects()
	set name = ".addeffects"
	set category = "OOC"
	for(var/obj/I in src?.usingPlanes)
		if(istype(I, /obj/blur_planemaster)) continue
		if(istype(I, /obj/lighting_plane)) continue
		var/filter = I.get_filter("cur")
		if(filter)
			I?.remove_filter("cur")
		else
			I.add_filter("cur", 1, list("type" = "blur", size = 0.4))

/client/verb/fit_viewport()
	set name = "Fit Viewport"
	set category = "OOC"
	set desc = "Fit the width of the map window to match the viewport"
	set hidden = 1 //Nope.

	// Fetch aspect ratio
	var/view_size = getviewsize(view)
	var/aspect_ratio = view_size[1] / view_size[2]

	// Calculate desired pixel width using window size and aspect ratio
	var/sizes = params2list(winget(src, "mainwindow.mainvsplit;mapwindow", "size"))
	var/map_size = splittext(sizes["mapwindow.size"], "x")
	var/height = text2num(map_size[2])
	var/desired_width = round(height * aspect_ratio)
	if (text2num(map_size[1]) == desired_width)
		// Nothing to do
		return

	var/split_size = splittext(sizes["mainwindow.mainvsplit.size"], "x")
	var/split_width = text2num(split_size[1])

	// Calculate and apply a best estimate
	// +4 pixels are for the width of the splitter's handle
	var/pct = 200 * (desired_width + 4) / split_width
	winset(src, "mainwindow.mainvsplit", "splitter=71.7")
	winset(src, "rpane.rpanewindow", "splitter=30")

	// Apply an ever-lowering offset until we finish or fail
	var/delta
	for(var/safety in 1 to 10)
		var/after_size = winget(src, "mapwindow", "size")
		map_size = splittext(after_size, "x")
		//var/got_width = text2num(map_size[1])

		//if (got_width == desired_width)
			// success
			//return
/*
		else if (isnull(delta))
			// calculate a probable delta value based on the difference
			delta = 100 * (desired_width - got_width) / split_width
		else if ((delta > 0 && got_width > desired_width) || (delta < 0 && got_width < desired_width))
			// if we overshot, halve the delta and reverse direction
			delta = -delta/2
*/

		pct += delta
		winset(src, "mainwindow.mainvsplit", "splitter=75")
