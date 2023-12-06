/datum/job/cmo
	title = "Esculap"
	titlebr = "Esculápio"
	flag = CMO
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	department_flag = MEDSCI
	supervisors = "the captain"
	jobdesc = "Быть достаточно удачливым, чтобы носить титул эскулапа, - немалый подвиг. Пройдя многолетнюю строгую формальную и академическую медицинскую подготовку, эти медицинские работники являются одними из лучших и ярчайших специалистов, которых может предложить Evergreen. Обычно они являются вторыми сыновьями богатых купцов, но некоторые лживые шарлатаны используют монеты, чтобы купить себе этот почетный титул."
	jobdescbr = "Serpentes sussurram que você não é um curandeiro gênio, mas um charlatão que conseguiu essa tarefa por meio das conexões de seus pais. Você deve fingir que não é verdade."
	selection_color = "#ffddf0"
	idtype = /obj/item/weapon/card/id/cmo
	access = list(sanctuary,keep,esculap)
	minimal_access = list(sanctuary,keep,esculap)
	minimal_player_age = 10
	thanati_chance = 50
	money = 25
	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/esculap(H), slot_wrist_r)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/common/smith(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/boots(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/esculap(H), slot_wear_suit)
		H.add_event("nobleblood", /datum/happiness_event/noble_blood)
		H.add_perk(/datum/perk/chemical)
		H.terriblethings = TRUE
		H.create_kg()
		return 1


/datum/job/doctor
	title = "Serpent"
	titlebr = "Serpente"
	flag = DOCTOR
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 3
	spawn_positions = 3
	supervisors = "the Esculap"
	selection_color = "#ffeef0"
	jobdesc = "Серпент - опытный практик, проходящий обучение у своего наставника, эскулапа. В отличие от вашего наставника, вам никогда не везло настолько, чтобы позволить себе более формальное медицинское образование. К счастью для вас, ваш великодушный учитель предложил обучать вас самостоятельно и предоставил вам место в ордене змееносцев в обмен на ваше продолжительное служение. Да здравствует Гиппократ!"
	idtype = /obj/item/weapon/card/id/med
	access = list(sanctuary)
	minimal_access = list(sanctuary)
	sex_lock = MALE
	money = 9
	thanati_chance = 50
	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/cheap(H), slot_wrist_r)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/common(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/serpent(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/brown(H), slot_shoes)
		H.h_style = "Shaved"
		H.add_perk(/datum/perk/chemical)
		H.terriblethings = TRUE
		H.create_kg()
		return 1


/datum/job/chemsister
	title = "Chemsister"
	titlebr = "Chemsister"
	flag = CHEMSIS
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 3
	spawn_positions = 3
	supervisors = "the Esculap"
	selection_color = "#ffeef0"
	idtype = /obj/item/weapon/card/id/med
	access = list(sanctuary)
	minimal_access = list(sanctuary)
	sex_lock = FEMALE
	no_trapoc = TRUE
	jobdesc = "Хотя змеиный орден - это тесное братство медицинских работников, сестры-химики совсем не такие. Этим женщинам поручено готовить необходимые анестетики для рутинных операций змей. Обеспечение надлежащего ухода за пациентом, ваше пристрастие к химическим веществам и разумные предписания различных регентов сделали вас достаточно уважаемым, чтобы вас терпимо относились к персоналу святилища."
	thanati_chance = 30
	money = 7
	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/cheap(H), slot_wrist_r)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/common(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/chemsis(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/brown(H), slot_shoes)
		H.add_perk(/datum/perk/chemical)
		H.terriblethings = TRUE
		H.create_kg()
		return 1



//Chemist is a medical job damnit	//YEAH FUCK YOU SCIENCE	-Pete	//Guys, behave -Erro
/*
/datum/job/geneticist
	title = "Counselor"
	flag = GENETICIST
	department_head = list("Chief Medical Officer", "Research Director")
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the Esculap"
	selection_color = "#ffeef0"
	idtype = /obj/item/weapon/card/id/gene
	access = list(access_medical, access_morgue, access_surgery, access_chemistry, access_virology, access_genetics, access_research)
	minimal_access = list(access_medical, access_morgue, access_genetics, access_research)


	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/headset_medsci(H), slot_l_ear)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/geneticist(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/brown(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/device/pda/geneticist(H), slot_belt)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/labcoat/genetics(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/device/flashlight/pen(H), slot_s_store)
		return 1
*/