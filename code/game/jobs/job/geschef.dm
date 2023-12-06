/datum/job/factorykid
	title = "Minor Worker"
	titlebr = "Crianca da FEBEM"
	flag = FACKID
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "Your parents."
	selection_color = "#ddddff"
	jobdesc = "Вы - ребенок, работающий на местной фабрике Фаэторна, и вам поручено выполнять ручной труд. Доставляйте грузы продавцу, убирайте помои с пола и следите за тем, чтобы шестерни продолжали скрежетать. Вы дешевая рабочая сила, и никто ни капельки не возражает."
	idtype = /obj/item/weapon/card/id/other
	minimal_player_age = 10
	latejoin_locked = FALSE
	children = TRUE
	access = list(geschef)
	minimal_access = list(geschef, merchant)
	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		H.set_species("Child")
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/cheap(H), slot_wrist_r)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/child_jumpsuit(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/eye(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/child/shoes(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/clothing/head/cap(H), slot_head)
		H.vice = null
		H.add_perk(/datum/perk/shoemaking)
		H.add_perk(/datum/perk/illiterate)
		H.height = rand(155,165)
		H.Altista()
		H.religion = "Gray Church"
		return 1