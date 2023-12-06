var/fortHand = null

/datum/job/captain
	title = "Baron"
	titlebr = "Барон"
	flag = CAPTAIN
	department_head = list("Centcom")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "The God King."
	selection_color = "#ccccff"
	idtype = /obj/item/weapon/card/id/lord
	access = list(meistery,smith,treasury,esculap,sanctuary,innkeep,merchant,garrison,keep,baronquarter,hump,courtroom,soilery,lifeweb,geschef, marduk, hand_access)
	minimal_access = list(meistery,smith,treasury,esculap,sanctuary,innkeep,merchant,garrison,keep,baronquarter,hump,courtroom,soilery,lifeweb,geschef, marduk, hand_access)
	minimal_player_age = 14
	sex_lock = MALE
	jobdesc = "Самый милостивый, хитрый и красивый правитель крепости Фаэторн. По крайней мере, это то, что все продолжают вам говорить. И кто они такие, чтобы утверждать обратное?"
	jobdescbr = "Самый милостивый, хитрый и красивый правитель крепости Фаэторн. По крайней мере, это то, что все продолжают вам говорить. И кто они такие, чтобы утверждать обратное??"
	latejoin_locked = FALSE
	minimal_character_age = 40
	thanati_chance = 100
	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		H.royalty = 1
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/captain(H), slot_wrist_r)
		H.voicetype = "noble"
		H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/captain(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/jackboots(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/clothing/head/caphat(H), slot_head)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/baron(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/daggerssheath(H), slot_wrist_l)
		H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/lord(H), slot_back)
		H.equip_to_slot_or_del(new /obj/item/sheath/sabre(H), slot_belt)
		H.equip_to_slot_or_del(new /obj/item/weapon/shield/generator(H), slot_s_store)
		H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/coinbag(H), slot_amulet)
		H.equip_to_slot_or_del(new /obj/item/weapon/staffoflaw(H), slot_r_hand)
		H.add_perk(/datum/perk/lessstamina)
		H.add_event("nobleblood", /datum/happiness_event/noble_blood)
		H.create_kg()
		if(H.gender == FEMALE)
			to_chat(world, "<span class='baron'>\n † Баронесса </span> <span class='bname'>[H.real_name]</span> <span class='baron'> это женщина, которая правит крепостью Фаэторн. † </span>")
			to_chat(world, "<br>")
		else
			to_chat(world, "<span class='baron'>\n † Барон</span> <span class='bname'>[H.real_name]</span> <span class='baron'> это мужчина, который правит крепостью Фаэторн. † </span>")//asd
			to_chat(world, "<br>")
		//H << sound('sound/music/sherold.ogg', repeat = 0, wait = 0, volume = 12, channel = 3)
		return 1
/*
	get_access()
		return get_all_accesses()
*/

/obj/item/device/baron_device
	name = "ULTIMATE TNC THRONE CONTROLLER"
	icon_state = "Pipboy"
	item_state = "analyzer"
	desc = "A hand-held throne controller."
	flags = FPRINT | TABLEPASS | CONDUCT
	slot_flags = SLOT_BELT
	throwforce = 3
	w_class = 1.0
	throw_speed = 5
	throw_range = 10
	m_amt = 200
	origin_tech = "magnets=1;biotech=1"

/datum/job/hand
	title = "Hand"
	titlebr = "Десница"
	flag = HAND
	department_head = list("Centcom")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "The God King."
	selection_color = "#ccccff"
	idtype = /obj/item/weapon/card/id/gold
	access = list(meistery,smith,treasury,esculap,sanctuary,innkeep,merchant,garrison,keep,baronquarter,hump,courtroom,soilery,lifeweb,geschef, marduk, hand_access)
	minimal_access = list(meistery,smith,treasury,esculap,sanctuary,innkeep,merchant,garrison,keep,baronquarter,hump,courtroom,soilery,lifeweb,geschef, marduk, hand_access)
	minimal_player_age = 14
	sex_lock = MALE
	jobdesc = "Очень близкий друг барона и их самый доверенный советник. Ваш статус лорда-регента дает вам почти равную власть с самим бароном в их присутствии и равную власть в их отсутствие. Ожидается, что Десница проследит за исполнением воли барона и оставит за собой редкое право возглавить силы гарнизона для этого."
	jobdescbr = "Очень близкий друг барона и их самый доверенный советник. Ваш статус лорда-регента дает вам почти равную власть с самим бароном в их присутствии и равную власть в их отсутствие. Ожидается, что Десница проследит за исполнением воли барона и оставит за собой редкое право возглавить силы гарнизона для этого"
	latejoin_locked = TRUE
	thanati_chance = 75
	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		H.royalty = 1
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/captain(H), slot_wrist_r)
		H.voicetype = "noble"
		H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/captain(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/jackboots(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/hand(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/sheath/sabre(H), slot_belt)
		H.add_perk(/datum/perk/ref/value)
		H.add_perk(/datum/perk/lessstamina)
		H.add_event("nobleblood", /datum/happiness_event/noble_blood)
		fortHand = H
		H.create_kg()
		to_chat(world, "<span class='baron'>† Десница</span> <span class='bname'>[H.real_name]</span> <span class='baron'>это правая рука Барона. † </span>\n")
		//H << sound('sound/music/sherold.ogg', repeat = 0, wait = 0, volume = 12, channel = 3)
		return 1
/*
	get_access()
		return get_all_accesses()
*/
/datum/job/heir
	title = "Heir"
	titlebr = "Наследник"
	flag = HEIR
	department_head = list("Captain")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "Your father and mother"
	selection_color = "#ddddff"
	idtype = /obj/item/weapon/card/id/heir
	minimal_player_age = 10
	latejoin_locked = TRUE
	sex_lock = MALE
	jobdesc = "Наследник трона Фаэторна. Всю вашу жизнь вас учили руководить, но, похоже, до сих пор никто не воспринимает ваши слова всерьез. Однако однажды от тебя будут ожидать, что ты пойдешь по стопам своего отца - к лучшему это или к худшему."
	jobdescbr = "Наследник трона Фаэторна. Всю вашу жизнь вас учили руководить, но, похоже, до сих пор никто не воспринимает ваши слова всерьез. Однако однажды от тебя будут ожидать, что ты пойдешь по стопам своего отца - к лучшему это или к худшему."
	thanati_chance = 75
	access = list(keep,baronquarter)
	minimal_access = list(keep,baronquarter)


	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		if(H.isChild())
			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/captain/child(H), slot_w_uniform)
			H.royalty = 1
			H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/captain(H), slot_wrist_r)
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/child/miner(H), slot_shoes)
			H.voicetype = "noble"
			H.add_event("nobleblood", /datum/happiness_event/noble_blood)
			H.height = rand(130,150)
			return 1
		H.royalty = 1
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/captain(H), slot_wrist_r)
		H.voicetype = "noble"
		H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/captain(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/jackboots(H), slot_shoes)
		H.add_event("nobleblood", /datum/happiness_event/noble_blood)
		H.create_kg()
		return 1

/datum/job/successor
	title = "Successor"
	titlebr = "Наследница"
	flag = SUCCESSOR
	department_head = list("Captain")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	jobdesc = "Ваши семейные отношения более сложны по сравнению с большинством других. Ожидается, что ты будешь вести себя достойно, чтить свою семью и, в конечном счете, выйдешь замуж за более могущественного аристократа, который будет поддерживать дом твоего отца, но за пределами центра внимания ты устанавливаешь свои собственные правила."
	jobdescbr = "Ваши семейные отношения более сложны по сравнению с большинством других. Ожидается, что ты будешь вести себя достойно, чтить свою семью и, в конечном счете, выйдешь замуж за более могущественного аристократа, который будет поддерживать дом твоего отца, но за пределами центра внимания ты устанавливаешь свои собственные правила."
	supervisors = "Your father and mother"
	selection_color = "#ddddff"
	idtype = /obj/item/weapon/card/id/successor
	minimal_player_age = 10
	latejoin_locked = TRUE
	sex_lock = FEMALE
	thanati_chance = 75
	no_trapoc = TRUE
	access = list(keep,baronquarter)
	minimal_access = list(keep,baronquarter)


	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()

		if(H.isChild())
			H.royalty = 1
			H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/captain(H), slot_wrist_r)
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/child/shoes(H), slot_shoes)
			H.voicetype = "noble"
			H.add_event("nobleblood", /datum/happiness_event/noble_blood)
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/succdress/child(H), slot_wear_suit)
			H.height = rand(130,150)
			return 1

		H.royalty = 1
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/captain(H), slot_wrist_r)
		H.voicetype = "noble"
		H.equip_to_slot_or_del(new /obj/item/clothing/under/common(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/brown(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/succdress(H), slot_wear_suit)
		H.add_event("nobleblood", /datum/happiness_event/noble_blood)
		H.create_kg()
		return 1

/datum/job/baroness
	title = "Baroness"
	titlebr = "Baronesa"
	flag = BARONESS
	department_head = list("Captain")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "Your husband and life."
	selection_color = "#ddddff"
	idtype = /obj/item/weapon/card/id/baroness
	minimal_player_age = 10
	latejoin_locked = FALSE
	sex_lock = FEMALE
	thanati_chance = 75
	jobdesc = "Жена самого барона. Ваша личная жизнь часто беззаботна и наполнена роскошью. Вам повезло, что красота и элегантность - это сила, которую уважают все мужчины. И они уважают тебя."
	minimal_character_age = 30
	jobdescbr = "Жена самого барона. Ваша личная жизнь часто беззаботна и наполнена роскошью. Вам повезло, что красота и элегантность - это сила, которую уважают все мужчины. И они уважают тебя."
	access = list(treasury,meistery,keep,baronquarter)
	minimal_access = list(treasury,meistery,keep,baronquarter)

	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		H.royalty = 1
		H.voicetype = "noble"
		H.add_event("nobleblood", /datum/happiness_event/noble_blood)
		if(H.gender == MALE)
			H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/captain(H), slot_wrist_r)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/captain(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/jackboots(H), slot_shoes)
			H.add_event("nobleblood", /datum/happiness_event/noble_blood)
			H.create_kg()
			return 1
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/captain(H), slot_wrist_r)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/migrant/baroness(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/baronessdress(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/brown(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/clothing/head/sunhat(H), slot_head)
		H.equip_to_slot_or_del(new /obj/item/clothing/gloves/evening(H), slot_gloves)
		H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/minisatchelchurch2(H), slot_back)
		if(H.back)
			H.equip_to_slot_or_del(new /obj/item/weapon/reagent_containers/glass/bottle/lifeweb/widowtear(H.back), slot_in_backpack)
		H.add_event("nobleblood", /datum/happiness_event/noble_blood)
		H.add_perk(/datum/perk/lessstamina)
		H.create_kg()

		return 1

/datum/job/baroness/set_runtime_title(var/mob/living/carbon/human/H)
	for(var/datum/relation/family/R in H.mind.relations)
		if(R.relation_holder.current.job == "Baron")
			return "Baron's [R.connected_relation.name]"
	return "Baron's Consociate"

/datum/job/baronessbguard
	title = "Baroness Bodyguard"
	titlebr = "Guarda Costas"
	flag = BGUARD
	department_head = list("Captain")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the Baron and the Baroness"
	selection_color = "#ffeeee"
	idtype = /obj/item/weapon/card/id/sec
	minimal_player_age = 3
	access = list(garrison,keep)
	minimal_access = list(garrison,keep)
	latejoin_locked = TRUE
	thanati_chance = 1
	jobdesc = "Работая когда-то личной охраной вашей леди, она в конце концов вышла замуж за барона Фаэторна. Либо благодаря обаянию, либо образцовому служению, ныне баронесса убедила лорда восстановить вас в качестве ее личного защитника."
	jobdescbr = "Работая когда-то личной охраной вашей леди, она в конце концов вышла замуж за барона Фаэторна. Либо благодаря обаянию, либо образцовому служению, ныне баронесса убедила лорда восстановить вас в качестве ее личного защитника."
	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		H.royalty = 1
		H.voicetype = pick("strong","noble","sketchy")
		H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/security(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/jackboots(H), slot_shoes)
		H.set_dir(EAST)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/security/bodyguard(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/security(H), slot_wrist_r)
		H.equip_to_slot_or_del(new /obj/item/weapon/shield/generator/wrist(H), slot_wrist_l)
		H.add_event("nobleblood", /datum/happiness_event/noble_blood)
		H.add_perk(/datum/perk/ref/strongback)
		H.add_perk(/datum/perk/morestamina)
		H.terriblethings = TRUE
		H.add_perk(/datum/perk/heroiceffort)
		var/swordtype = pick("claymore","sabre","bardiche","spear")
		switch(swordtype)
			if("claymore")
				H.equip_to_slot_or_del(new /obj/item/sheath/claymore(H), slot_belt)
				H.my_skills.CHANGE_SKILL(SKILL_SWORD, 5)
			if("sabre")
				H.equip_to_slot_or_del(new /obj/item/sheath/sabre(H), slot_belt)
				H.my_skills.CHANGE_SKILL(SKILL_SWORD, 5)
			if("bardiche")
				H.equip_to_slot_or_del(new /obj/item/weapon/claymore/bardiche(H), slot_l_hand)
				H.my_skills.CHANGE_SKILL(SKILL_STAFF, 5)
			if("spear")
				H.equip_to_slot_or_del(new /obj/item/weapon/claymore/spear(H), slot_l_hand)
				H.my_skills.CHANGE_SKILL(SKILL_STAFF, 5)
		H.create_kg()
		//H << sound(&#8217;sound/music/sherold.ogg&#8217;, repeat = 0, wait = 0, volume = 12, channel = 3)
		return 1

/datum/job/maid
	title = "Maid"
	titlebr = "Empregada"
	flag = MAID
	department_head = list("Captain")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 3
	spawn_positions = 3
	supervisors = "The keep"
	selection_color = "#ddddff"
	idtype = /obj/item/weapon/card/id/ltgrey
	minimal_player_age = 10
	latejoin_locked = FALSE
	sex_lock = FEMALE
	thanati_chance = 70
	access = list(keep)
	minimal_access = list(keep)
	jobdesc = "Ты одна из тех девушек, которые должны вести себя тихо и облегчать жизнь своему хозяину и любовнице."
	jobdescbr = "Ты одна из тех девушек, которые должны вести себя тихо и облегчать жизнь своему хозяину и любовнице"

	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/cheap(H), slot_wrist_r)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/common(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/maiddress(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/boots(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/weapon/rag(H), slot_r_store)
		H.add_perk(/datum/perk/lessstamina)
		H.create_kg()
		return 1

/datum/job/guest
	title = "Guest"
	titlebr = "Convidado"
	flag = GUEST
	department_head = list("Captain")
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "The keep"
	selection_color = "#ddddff"
	idtype = /obj/item/weapon/card/id/ltgrey
	minimal_player_age = 10
	latejoin_locked = FALSE
	thanati_chance = 80
	access = list(keep)
	minimal_access = list(keep, baronquarter)
	jobdesc = "Друг барона, дворянин, временно остановившийся в Фаэторне. Будем надеяться, что его пребывание не продлится бесконечно."
	jobdescbr ="Друг барона, дворянин, временно остановившийся в Фаэторне. Будем надеяться, что его пребывание не продлится бесконечно."

	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet(H), slot_wrist_r)
		H.voicetype = "noble"
		H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/captain(H), slot_w_uniform)
		H.add_event("nobleblood", /datum/happiness_event/noble_blood)
		H.equip_to_slot_or_del(new /obj/item/sheath/sabre(H), slot_belt)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/guest(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/boots(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/coinbag/guest(H), slot_amulet)
		H.create_kg()
		return 1
/*
/datum/job/servant
	title = "Servant"
	flag = SERVANT
	department_head = list("Captain")
	department_flag = OFFICER
	faction = "Station"
	total_positions = 3
	spawn_positions = 3
	supervisors = "the Baron and everyone"
	selection_color = "#ddddff"
	minimal_player_age = 10
	idtype = /obj/item/weapon/card/id/ltgrey
	access = list()
	minimal_access = list()

	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		H.set_species("Child")
		H.equip_to_slot_or_del(new /obj/item/clothing/under/child_jumpsuit(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/child/shoes(H), slot_shoes)
		return 1
*/

/datum/job/Servant
	title = "Servant"
	titlebr = "Servo"
	flag = SERVANT
	department_head = list("Captain")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 3
	spawn_positions = 3
	supervisors = "Everyone"
	selection_color = "#ddddff"
	idtype = /obj/item/weapon/card/id/other
	minimal_player_age = 10
	latejoin_locked = FALSE
	access = list(keep)
	minimal_access = list(keep)
	children = TRUE
	jobdesc = "Один из личных детей-слуг барона. Они чрезвычайно ловко забираются в маленькие щели, до которых горничные просто не могут дотянуться, и являются отличными уборщиками! По крайней мере, так вам сказали."
	jobdescbr = "Один из личных детей-слуг барона. Они чрезвычайно ловко забираются в маленькие щели, до которых горничные просто не могут дотянуться, и являются отличными уборщиками! По крайней мере, так вам сказали."
	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		H.set_species("Child")
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/cheap(H), slot_wrist_r)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/child_jumpsuit(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/child/miner(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/weapon/rag(H), slot_r_store)
		H.vice = null
		H.religion = "Gray Church"
		H.create_kg()
		return 1

/datum/job/meister
	title = "Meister"
	titlebr = "Meister"
	flag = HOP
	department_head = list("Captain")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	jobdesc = "Архивариус и советник барона. У мейстеров нет семейного происхождения или политической преданности. Происходя из эгалитарного ордена, расположенного в Гане, они приписаны к вотчинам аристократов, связанных клятвами служить своему суверену. Их часто считают самыми умными и начитанными людьми в округе, обладающими обширной областью знаний, тщательно разработанной в соответствии с потребностями их Господина."
	jobdescbr = "Архивариус и советник барона. У мейстеров нет семейного происхождения или политической преданности. Происходя из эгалитарного ордена, расположенного в Гане, они приписаны к вотчинам аристократов, связанных клятвами служить своему суверену. Их часто считают самыми умными и начитанными людьми в округе, обладающими обширной областью знаний, тщательно разработанной в соответствии с потребностями их Господина."
	supervisors = "the Baron"
	selection_color = "#ddddff"
	idtype = /obj/item/weapon/card/id/hop
	minimal_character_age = 70
	minimal_player_age = 10
	//sex_lock = MALE
	thanati_chance = 25
	latejoin_locked = TRUE
	access = list(keep,meistery,treasury)
	minimal_access = list(keep,meistery,treasury)

	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		H.royalty = 1
		H.voicetype = "noble"
		H.equip_to_slot_or_del(new /obj/item/clothing/head/ushanka/soviet(H), slot_head)
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/captain(H), slot_wrist_r)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/common(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/brown(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/meister(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/clothing/glasses/monocle(H), slot_glasses)
		H.add_event("nobleblood", /datum/happiness_event/noble_blood)
		H.add_perk(/datum/perk/ancitech)
		H.add_perk(/datum/perk/lessstamina)
		H.add_perk(/datum/perk/ref/value)
		H.create_kg()
		return 1

/datum/job/meisterdisciple
	title = "Treasurer"
	titlebr = "Tesoureiro"
	flag = MEISTERDISC
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Meister."
	selection_color = "#ddddff"
	thanati_chance = 80
	jobdesc = "Им поручено заниматься всеми аспектами финансового управления в крепости Фаэторн, и их церемониальная позолоченная кираса выдается им в знак их важности и для того, чтобы подчеркнуть богатство самого барона."
	jobdescbr = "Им поручено заниматься всеми аспектами финансового управления в крепости Фаэторн, и их церемониальная позолоченная кираса выдается им в знак их важности и для того, чтобы подчеркнуть богатство самого барона"
	latejoin_locked = TRUE
	idtype = /obj/item/weapon/card/id/ltgrey
	access = list(keep,meistery,treasury)
	minimal_access = list(keep,meistery,treasury)

	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		if(H.isChild())
			H.equip_to_slot_or_del(new /obj/item/clothing/under/child_jumpsuit(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/ushanka(H), slot_head)
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/child/miner(H), slot_shoes)
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/disciple(H), slot_wear_suit)
			H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/captain(H), slot_wrist_r)
			H.height = rand(130,150)
			H.job = "Meister Disciple"
			H.old_job = "Meister Disciple"
			H.add_perk(/datum/perk/ancitech)
			H.create_kg()
			return 1
		H.equip_to_slot_or_del(new /obj/item/clothing/under/common(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/brown(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/clothing/head/treasurerhat(H), slot_head)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/gold_breastplate(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/daggerssheath/iron(H), slot_wrist_l)
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/captain(H), slot_wrist_r)
		H.add_perk(/datum/perk/ancitech)
		H.create_kg()
		return 1