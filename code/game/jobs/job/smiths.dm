/datum/job/weaponsmith
	title = "Weaponsmith"
	titlebr = "Ferreiro de Armas"
	flag = WEAPONSMITH
	department_head = null
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "The merchant and yourself."
	selection_color = "#ae00ff"
	idtype = /obj/item/weapon/card/id/ltgrey
	access = list(smith)
	minimal_access = list(smith)
	jobdesc = "Специализированный изготовитель оружия, разбирающийся в копировании вооружений более ранних периодов. Барон часто покупает напрямую у вас и ваших коллег, поскольку импортные пошлины обходятся дороже. Ваше оружие самое острое, а ваша сталь самая чистая - вы сами так говорите!"
	jobdescbr = "Ferreiro especializado em tudo o que a forja pode fazer."
	thanati_chance = 75
	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		H.voicetype = "sketchy"
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet(H), slot_wrist_r)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/common/smith(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/apron(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/brown(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/weapon/alicate(H), slot_belt)
		H.equip_to_slot_or_del(new /obj/item/weapon/carverhammer(H), slot_l_hand)
		H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/satchel/smith(H), slot_back)
		H.create_kg()
		return 1

/datum/job/armorsmith
	title = "Armorsmith"
	titlebr = "Ferreiro de Armaduras"
	flag = ARMORSMITH
	department_head = null
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "The merchant and yourself."
	selection_color = "#ae00ff"
	idtype = /obj/item/weapon/card/id/ltgrey
	access = list(smith)
	minimal_access = list(smith)
	jobdesc = "Кузнец, специализирующийся на изготовлении доспехов. Ваше внимание к деталям беспрецедентно - все говорят вам об этом, особенно в гарнизоне. Ваша значимость для них как главного местного поставщика защитных приспособлений Барона означает, что они высоко ценят вашу торговлю, и это справедливо."
	jobdescbr = "Ferreiro especializado em tudo o que a forja pode fazer."
	thanati_chance = 75
	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		H.voicetype = "sketchy"
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet(H), slot_wrist_r)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/common/smith(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/apron(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/brown(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/weapon/alicate(H), slot_belt)
		H.equip_to_slot_or_del(new /obj/item/weapon/carverhammer(H), slot_l_hand)
		H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/satchel/smith(H), slot_back)
		H.create_kg()
		return 1


/datum/job/metalsmith
	title = "Metalsmith"
	titlebr = "Ferreiro de Utensilios"
	flag = METALSMITH
	department_head = null
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "The merchant and yourself."
	selection_color = "#ae00ff"
	idtype = /obj/item/weapon/card/id/ltgrey
	access = list(smith)
	minimal_access = list(smith)
	jobdesc = "Мастер по металлу изготавливает украшения изысканного дизайна. Вы считаете это истинным мастерством. Превращать железо в кусок металла, который вы можете носить на теле или в руке, - это одно, но создавать настоящие произведения искусства - измельчать нагретый металл в утилитарных или художественных целях, чтобы продавать жителям крепости и заставлять их ценить ваши изысканные проекты, - это совсем другое."
	jobdescbr = "Ferreiro especializado em tudo o que a forja pode fazer."
	thanati_chance = 75
	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		H.voicetype = "sketchy"
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet(H), slot_wrist_r)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/common/smith(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/apron(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/brown(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/weapon/alicate(H), slot_belt)
		H.equip_to_slot_or_del(new /obj/item/weapon/carverhammer(H), slot_l_hand)
		H.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack/satchel/smith(H), slot_back)
		H.create_kg()
		return 1


/datum/job/apprentice
	title = "Apprentice"
	titlebr = "Aprendiz"
	flag = APPRENTICE
	department_head = list("Captain")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 3
	spawn_positions = 3
	supervisors = "the Blacksmith."
	selection_color = "#ddddff"
	minimal_player_age = 10
	jobdesc = "Молодой ученик, заключивший контракт на обучение у местного кузнеца. Обычно это дети родителей, которые отдают их работать под началом ремесленника. Их многолетнее служение своему хозяину позволяет им учиться на практике и потенциально стать их преемниками."
	idtype = /obj/item/weapon/card/id/ltgrey
	access = list(smith)
	minimal_access = list(smith)
	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		H.set_species("Child")
		H.equip_to_slot_or_del(new /obj/item/clothing/under/child_jumpsuit(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/cheap(H), slot_wrist_r)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/child/shoes(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/yapron(H), slot_wear_suit)
		H.vice = null
		H.religion = "Gray Church"
		H.height = rand(130,150)
		H.create_kg()
		return 1