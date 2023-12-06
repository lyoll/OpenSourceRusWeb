datum/job/ordinator
	title = "Marduk"
	titlebr = "Marduk"
	flag = HOS
	department_head = list("meister")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Baron."
	selection_color = "#ccccff"
	idtype = /obj/item/weapon/card/id/hos
	access = list(meistery,sanctuary,garrison,keep,hump,courtroom,soilery,lifeweb, baronquarter, marduk, innkeep, hand_access)
	minimal_access = list(meistery,sanctuary,garrison,keep,hump,courtroom,soilery,lifeweb, baronquarter, marduk, innkeep, hand_access)
	minimal_player_age = 14
	latejoin_locked = TRUE
	jobdesc = "Будучи человеком сильной воли, героической силы и невероятного боевого мастерства, Мардук является одним из самых ужасающих людей, с которыми когда-либо приходилось сталкиваться в бою. Его выдающиеся навыки признаны по всей провинции Салариан. Чемпион барона Фаэторна, его иногда посылают принять участие в спешке и боевых играх среди более богатой знати. Многие более влиятельные дворяне предложили ему место среди своих могущественных людей, но его преданность своему господину бессмертна."
	sex_lock = MALE
	money = 66
	thanati_chance = 1
	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		H.voicetype = "strong"
		H.height = rand(210,240)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/security(H), slot_w_uniform)
		/*		if(prob(20))
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/security/marduk_alt(H), slot_wear_suit)
		else
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/security/marduk(H), slot_wear_suit) */ //missing female sprite
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/security/marduk(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/jackboots(H), slot_shoes)
		H.set_dir(NORTH)
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/security/censor(H), slot_wrist_r)
		H.equip_to_slot_or_del(new /obj/item/combatsheath/Censor(H), slot_wrist_l)
		H.equip_to_slot_or_del(new /obj/item/weapon/gun/energy/taser/leet/sparq(H), slot_belt)
		H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/sechelm/veteran(H), slot_r_hand)
		if(prob(60))
			H.virgin = FALSE
		H.add_perk(/datum/perk/ref/strongback)
		H.terriblethings = TRUE
		H.add_perk(/datum/perk/heroiceffort)
		H.add_perk(/datum/perk/morestamina)
		H.verbs += /mob/living/carbon/human/verb/BaronRiot
		H.create_kg()
		return 1

/datum/job/enforcer
	title = "Tiamat"
	titlebr = "Tiamat"
	flag = OFFICER
	department_head = list("Captain")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 5
	spawn_positions = 5
	supervisors = "the Baron and the Marduk"
	selection_color = "#ffeeee"
	idtype = /obj/item/weapon/card/id/sec
	access = list(garrison,keep,courtroom)
	minimal_access = list(garrison,keep,courtroom)
	minimal_player_age = 3
	sex_lock = MALE
	money = 25
	jobdesc = "Также неофициально называемые драконами, тиаматы являются личной охраной барона. Искусные в бою, их главным приоритетом является защита своего господина, его семьи и исполнение его воли. До тех пор, пока им платят, это так."
	latejoin_locked = TRUE
	thanati_chance = 1
	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		H.voicetype = "strong"
		H.add_perk(/datum/perk/ref/strongback)
		H.add_perk(/datum/perk/heroiceffort)
		H.add_perk(/datum/perk/morestamina)
		if(prob(50))
			H.virgin = FALSE
		H.equip_to_slot_or_del(new /obj/item/daggerssheath/iron(H), slot_wrist_l)
		H.terriblethings = TRUE
		if(pigpluslist?.Find(ckey(H?.client?.key)))
			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/security(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/jackboots(H), slot_shoes)
			H.set_dir(NORTH)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/sechelm(H), slot_r_hand)
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/security(H), slot_wear_suit)
			H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/security(H), slot_wrist_r)
			H.equip_to_slot_or_del(new /obj/item/weapon/gun/energy/taser/leet/sparq(H), slot_belt)
			H.my_skills.CHANGE_SKILL(SKILL_MELEE, 12)
			H.my_skills.CHANGE_SKILL(SKILL_RANGE, 11)
		else if(comradelist?.Find(ckey(H?.client?.key)))
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/jackboots(H), slot_shoes)
			H.set_dir(NORTH)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/sechelm/trusted(H), slot_r_hand)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/security(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/security/comrade(H), slot_wear_suit)
			H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/security(H), slot_wrist_r)
			H.equip_to_slot_or_del(new /obj/item/weapon/gun/energy/taser/leet/sparq(H), slot_belt)
			H.my_skills.CHANGE_SKILL(SKILL_MELEE, 12)
			H.my_skills.CHANGE_SKILL(SKILL_RANGE, 11)
		else if(villainlist?.Find(ckey(H?.client?.key)))
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/jackboots(H), slot_shoes)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/security(H), slot_w_uniform)
			H.set_dir(NORTH)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/sechelm/trusted(H), slot_r_hand)
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/security/villain(H), slot_wear_suit)
			H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/security(H), slot_wrist_r)
			H.equip_to_slot_or_del(new /obj/item/weapon/gun/energy/taser/leet/sparq(H), slot_belt)
			H.my_skills.CHANGE_SKILL(SKILL_MELEE, 12)
			H.my_skills.CHANGE_SKILL(SKILL_RANGE, 11)
		else
			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/security(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/jackboots(H), slot_shoes)
			H.set_dir(NORTH)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/sechelm(H), slot_r_hand)
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/iron_cuirass(H), slot_wear_suit)
			H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/security(H), slot_wrist_r)
			H.equip_to_slot_or_del(new /obj/item/weapon/gun/energy/taser/leet/sparq(H), slot_belt)
			H.my_skills.CHANGE_SKILL(SKILL_MELEE, rand(10,11))
			H.my_skills.CHANGE_SKILL(SKILL_RANGE, rand(10,11))
			H.my_stats.st = 11
			H.my_stats.ht = rand(10,11)
			H.my_stats.dx = rand(9,10)
			H.my_stats.it = rand(9,10)

		H.create_kg()
		return 1

/datum/job/sheriff
	title = "Sheriff"
	titlebr = "Xerife"
	flag = SHERIFF
	department_head = list("Captain")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Baron and the Marduk"
	selection_color = "#ffeeee"
	idtype = /obj/item/weapon/card/id/other
	access = list(garrison,keep,courtroom)
	minimal_access = list(garrison,keep,courtroom)
	minimal_player_age = 3
	jobdesc = "Выступая одновременно в роли внешнего сторожа и представителя закона, вы - первый человек, который узнает о любой надвигающейся угрозе Фаэторну. Большую часть ваших дней вы проводите, лениво наблюдая за мигрантами, проходящими через деревню, но вы не можете не чувствовать, что некогда тихое пение ересей пещеры становится все ближе. И теперь они стучатся в вашу дверь."
	sex_lock = MALE
	money = 25
	latejoin_locked = TRUE
	thanati_chance = 10
	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		H.voicetype = "sketchy"
		H.outsider = TRUE
		H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/security(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/vest/sheriff(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/clothing/head/papakha(H), slot_head)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/bastard(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/security(H), slot_wrist_r)
		H.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses(H), slot_glasses)
		H.terriblethings = TRUE
		H.add_perk(/datum/perk/morestamina)
		if(prob(30))
			H.virgin = FALSE
		H.create_kg()
		//H << sound('sound/music/sherold.ogg', repeat = 0, wait = 0, volume = 12, channel = 3)
		return 1

/datum/job/squire
	title = "Squire"
	titlebr = "Escudeiro"
	flag = SQUIRE
	department_head = list("Captain")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 4
	spawn_positions = 4
	supervisors = "the Cerberii"
	selection_color = "#ddddff"
	minimal_player_age = 10
	idtype = /obj/item/weapon/card/id/other
	access = list(garrison,keep)
	minimal_access = list(garrison,keep)
	sex_lock = MALE
	money = 5
	jobdesc = "Все еще юные оруженосцы еще не заслужили права называть себя Тиаматами. Хорошо служи своему хозяину. Наденьте на него доспехи, заточите его клинок, и он научит вас, как стать мужчиной. И однажды ты тоже будешь иметь честь служить непосредственно под началом самого Господа среди своих братьев. Это честь для всех молодых людей."
	latejoin_locked = FALSE
	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		if((adultsquire.Find(H.ckey) && H.client.prefs.toggle_squire) || H.special == "squireadult")
			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/security(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/security/squireadult(H), slot_wear_suit)
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/jackboots(H), slot_shoes)
			H.set_dir(NORTH)
			H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/cheap/sec(H), slot_wrist_r)
			H.my_skills.CHANGE_SKILL(SKILL_MELEE,rand(9,9))
			H.my_skills.CHANGE_SKILL(SKILL_RANGE,rand(9,9))
			H.my_skills.CHANGE_SKILL(SKILL_FARM,rand(0,0))
			H.my_skills.CHANGE_SKILL(SKILL_COOK,rand(0,0))
			H.my_skills.CHANGE_SKILL(SKILL_UNARM,rand(0,1))
			H.my_skills.CHANGE_SKILL(SKILL_ENGINE,rand(0,0))
			H.my_skills.CHANGE_SKILL(SKILL_SURG,rand(0,0))
			H.my_skills.CHANGE_SKILL(SKILL_MEDIC,rand(0,0))
			H.my_skills.CHANGE_SKILL(SKILL_CLEAN,rand(0,0))
			H.my_skills.CHANGE_SKILL(SKILL_CLIMB,rand(10,11))
			H.my_skills.CHANGE_SKILL(SKILL_STEAL,rand(0,0))
			H.my_skills.CHANGE_SKILL(SKILL_SWIM,rand(9,10))
			H.my_skills.CHANGE_SKILL(SKILL_OBSERV, rand(8,9))
			H.my_stats.st = 11
			H.my_stats.ht = rand(10,10)
			H.my_stats.dx = rand(9,10)
			H.my_stats.it = rand(9,10)
			H.add_perk(/datum/perk/heroiceffort)
			H.add_perk(/datum/perk/morestamina)
			if(H.gender == FEMALE && !H.has_penis())
				H.my_stats.st -=1
			var/weaponreal = pick("axe","sword")
			switch(weaponreal)
				if("axe")
					H.equip_to_slot_or_del(new /obj/item/weapon/hatchet(H), slot_l_hand)
				if("sword")
					H.equip_to_slot_or_del(new /obj/item/weapon/claymore(H), slot_l_hand)
			H.equip_to_slot_or_del(new /obj/item/weapon/shield/fort(H), slot_r_hand)
		else
			H.set_species("Child")
			H.equip_to_slot_or_del(new /obj/item/clothing/under/child_jumpsuit(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/child/shoes(H), slot_shoes)
			H.set_dir(NORTH)
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/squire(H), slot_wear_suit)
			H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/cheap/sec(H), slot_wrist_r)
			H.vice = null
			H.religion = "Gray Church"
			H.add_perk(/datum/perk/heroiceffort)
			H.add_perk(/datum/perk/morestamina)
			H.height = rand(130,150)
			H.create_kg()
		return 1

var/global/Gatekeeper_Type = "Null"

/datum/job/gatekeeper
	title = "Incarn"
	titlebr = "Incarn"
	flag = GATEKEEPER
	department_head = list("Duke")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Baron and the Marduk"
	selection_color = "#ffeeee"
	idtype = /obj/item/weapon/card/id/other
	access = list(garrison,keep,courtroom)
	minimal_access = list(garrison,keep,courtroom)
	minimal_player_age = 3
	sex_lock = MALE
	money = 13
	thanati_chance = 1
	jobdesc = "Фанатичный воин-монах, который стремился очистить еретиков, но дал неосмотрительный обет. Теперь его обязанность - следить за воротами крепости, регистрировать мигрантов и сбрасывать негодяев в магму. "
	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		if(Gatekeeper_Type == "Monk")
			H.voicetype = "sketchy"
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/security/incarn(H), slot_wear_suit)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/security(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/sechelm/incarn(H), slot_head)
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/jackboots(H), slot_shoes)
			H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/security(H), slot_wrist_r)
			H.equip_to_slot_or_del(new /obj/item/weapon/crossbow(H), slot_back)
			H.equip_to_slot_or_del(new /obj/item/weapon/gun/energy/taser/leet/legax(H), slot_belt)
			H.my_skills.CHANGE_SKILL(SKILL_MELEE, 9)
			H.my_skills.CHANGE_SKILL(SKILL_RANGE, 13)
			H.my_stats.st = 11
			H.my_stats.ht = rand(10,11)
			H.my_stats.dx = rand(9,10)
			H.my_stats.it = rand(9,10)
			H.my_stats.pr = 12
			H.terriblethings = TRUE
			H.add_perk(/datum/perk/morestamina)
			H.religion = "Gray Church"
			if(prob(40))
				H.virgin = FALSE
			H.create_kg()
			return 1
		else if(Gatekeeper_Type == "Chariot")
			H.voicetype = "sketchy"
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/security/chariot(H), slot_wear_suit)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/security(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/sechelm/chariot(H), slot_head)
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/jackboots(H), slot_shoes)
			H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/security(H), slot_wrist_r)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/amulet/holy/cross/old(H), slot_amulet)
			H.equip_to_slot_or_del(new /obj/item/weapon/melee/classic_baton/slab(H), slot_l_hand)
			H.my_skills.CHANGE_SKILL(SKILL_MELEE, 13)
			H.my_skills.CHANGE_SKILL(SKILL_RANGE, 9)
			H.my_skills.CHANGE_SKILL(SKILL_CRAFT, 12)
			H.my_skills.CHANGE_SKILL(SKILL_SWIM, 12)
			H.my_skills.CHANGE_SKILL(SKILL_SWING,rand(1,3))
			H.my_stats.st = 11
			H.my_stats.ht = rand(15,16)
			H.my_stats.dx = rand(9,10)
			H.my_stats.it = rand(9,10)
			H.my_stats.pr = rand(9,10)
			H.terriblethings = TRUE
			H.add_perk(/datum/perk/morestamina)
			H.add_perk(/datum/perk/ref/strongback)
			H.religion = "Gray Church"
			if(prob(40))
				H.virgin = FALSE
			H.create_kg()
			return 1

/datum/job/tribmig
	title = "Ordinator"
	titlebr = "Ordinator"
	flag = MIGRANT
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = -1
	spawn_positions = -1
	supervisors = "No one, yet"
	selection_color = "#dddddd"
	idtype = null
	thanati_chance = 0
	latejoin_locked = TRUE // RIN YOU FOOL - riotmigrant
	access = list()
	minimal_access = list()

	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		to_chat(H, "<span class='objectivesbig'>Вы - координатор трибунала</span>")
		to_chat(H, "<span class='objectives'>Ты направляешься к ближайшему пристанищу, Фаэторн.</span>")
		to_chat(H, "<span class='objectives'>Надеюсь, там ты сможешь перегруппироваться с остальными членами своего взвода.</span>")
		H.job = "Ordinator"
		H.terriblethings = TRUE
		H.voicetype = "strong"
		H.religion = "Gray Church"
		var/syndicate_commando_rank = pick("Pvt.", "Pfc.", "LCpl.", "Cpl.", "Sgt.")
		H.real_name = "[syndicate_commando_rank] [H.real_name]"
		H.equip_to_slot_or_del(new /obj/item/clothing/under/ordinator(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/vest/flakjacket(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/lw/ordinator(H), slot_head)
		H.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/automatic/grinder(H), slot_back)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/infantry(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/external/grinder(H), slot_r_store)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/external/grinder(H), slot_l_store)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/external/grinder(H), slot_s_store)
		H.equip_to_slot_or_del(new /obj/item/device/flashlight(H), slot_l_hand)
		var/obj/item/device/radio/R = new /obj/item/device/radio/headset/syndicate(H)
		R.set_frequency(SYND_FREQ)
		H.equip_to_slot_or_del(R, slot_l_ear)
		H.add_perk(/datum/perk/ref/strongback)
		H.add_perk(/datum/perk/morestamina)
		H.my_stats.st = rand(12,13)
		H.my_stats.ht = rand(13,14)
		H.my_stats.dx = rand(9,10)
		H.my_stats.it = rand(9,10)
		H.my_stats.pr = rand(11,13)
		H.my_skills.CHANGE_SKILL(SKILL_MELEE,rand(12,12))
		H.my_skills.CHANGE_SKILL(SKILL_RANGE,rand(12,15))
		H.my_skills.CHANGE_SKILL(SKILL_UNARM,rand(0,3))
		H.my_skills.CHANGE_SKILL(SKILL_FARM,rand(0,0))
		H.my_skills.CHANGE_SKILL(SKILL_COOK,rand(0,0))
		H.my_skills.CHANGE_SKILL(SKILL_ENGINE,rand(0,0))
		H.my_skills.CHANGE_SKILL(SKILL_SURG,rand(9,9))
		H.my_skills.CHANGE_SKILL(SKILL_MASON, 8)
		H.my_skills.CHANGE_SKILL(SKILL_CRAFT, 8)
		H.my_skills.CHANGE_SKILL(SKILL_MEDIC,rand(9,9))
		H.my_skills.CHANGE_SKILL(SKILL_CLEAN,rand(0,0))
		H.my_skills.CHANGE_SKILL(SKILL_CLIMB,rand(13,13))
		H.my_skills.CHANGE_SKILL(SKILL_SWIM,rand(11,12))
		H.my_skills.CHANGE_SKILL(SKILL_OBSERV, rand(11,11))
		H.my_skills.CHANGE_SKILL(SKILL_BOAT, rand(0,0))
		H.my_skills.CHANGE_SKILL(SKILL_SURVIV, rand(11,14))
		H.create_kg()
		H.outsider = TRUE
		return 1