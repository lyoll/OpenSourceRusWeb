//Due to how large this one is it gets its own file
var/global/Inquisitor_Points = 15 //HAHAHAHAHHAHAHAHAHAHHAHAH AAAAAAAAAAAAAAHAHAHAHAHAHAHAHHAHAHAHAHAHAHHAHAHAHAHHAHAHAHHA
var/global/Inquisitor_Type = "Null"

/datum/job/chaplain
	title = "Bishop"
	titlebr = "Bispo"
	flag = CHAPLAIN
	department_head = list("The God")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the god king"
	selection_color = "#dddddd"
	idtype = /obj/item/weapon/card/id/chaplain
	access = list(church, access_morgue, access_chapel_office, access_maint_tunnels)
	minimal_access = list(church, access_morgue, access_chapel_office)
	sex_lock = MALE
	jobdesc = "Глава местной церкви в Фаэторне. Он благословляет тех, кто отдает свою десятину и стремится отделиться от Него. Пастырь овец, он направляет людей, сбившихся с пути, обратно на правильный путь либо через исповедь, либо через эпитемию. К отлучению от Церкви нельзя относиться легкомысленно, и оно применяется только за совершение серьезной, нераскаянной ереси."
	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		var/obj/item/weapon/storage/bible/B = new /obj/item/weapon/storage/bible(H) //BS12 EDIT
		H.equip_to_slot_or_del(B, slot_l_hand)
		H.voicetype = "noble"
		H.religion = "Gray Church"
		H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/chaplain(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/bishop(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/brown(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/eng(H), slot_wrist_r)
		H.equip_to_slot_or_del(new /obj/item/clothing/head/amulet/epitrachelion(H), slot_amulet)
		H.verbs += /mob/living/carbon/human/proc/excommunicate
		H.verbs += /mob/living/carbon/human/proc/callmeeting
		H.verbs += /mob/living/carbon/human/proc/marriage
		H.verbs += /mob/living/carbon/human/proc/banish
		H.verbs += /mob/living/carbon/human/proc/undeadead
		H.verbs += /mob/living/carbon/human/proc/sins
		H.verbs += /mob/living/carbon/human/proc/coronation
		H.verbs += /mob/living/carbon/human/proc/reward
		H.verbs += /mob/living/carbon/human/proc/eucharisty
		H.verbs += /mob/living/carbon/human/proc/ClearName
		H.verbs += /mob/living/carbon/human/proc/epitemia
		H.updatePig()
		H.create_kg()
		//H << sound('sound/music/train_music.ogg', repeat = 0, wait = 0, volume = 20, channel = 3)
		return 1

/mob/living/carbon/human/proc/excommunicate()
	set hidden = 0
	set category = "Power of Faith"
	set name = "Отлучить от церкви"
	set desc="Отлучает кого-либо от церкви, предает анафеме!"
	var/input = sanitize_uni(input(usr, "Enter the name of the excommunicated member.", "What?", "") as text|null)
	if(!input)
		return
	if(stat) return
	var/mob/living/carbon/human/H = usr
	H.qualarea()
	if(H.lastarea && istype(lastarea, /area/dunwell/station/church))
		world << sound('sound/AI/bell_toll_02_lp.ogg')
		to_chat(world, "<span class='ravenheartfortress'>Крепость Фаэторн</span>")
		to_chat(world, "<span class='excomm'>Епископ [src.real_name] отлучает от церкви [input]!</span>")
		world << sound('sound/AI/bell_toll.ogg')
		to_chat(world, "<br>")
		to_chat(world, "<span class='decree'>Анафема!</span>")
		to_chat(world, "<br>")
		for(var/mob/living/carbon/human/HH in mob_list)
			if(ticker.eof.id == "godwill" && (HH.real_name == input || HH.name == input))
				bans.Add(HH.ckey)
				if(HH.client)
					qdel(HH.client)
			var/isValidPerson = 0
			if(HH.name == input && HH.religion == "Gray Church")
				HH.add_event("excom", /datum/happiness_event/excom)
				HH.rotate_plane()
				HH.excomunicated = TRUE
				isValidPerson = 1
			if(HH.name == input && HH.religion == "Thanati")
				HH.add_event("excom", /datum/happiness_event/excomthanati)
				HH.excomunicated = TRUE
				isValidPerson = 1
			if(HH.name != input && HH.religion == "Gray Church" && isValidPerson)
				var/datum/happiness_event/excomothers/E = new()
				E.description = "<span class='badmood'>• Я ДОЛЖЕН УБИТЬ [uppertext(input)]!</span>\n"
				HH.add_precreated_event("[uppertext(input)]excom", E)

		log_admin("[key_name(src)] has excommunicated someone: [input]")
		message_admins("[key_name_admin(src)] has created a excomm report", 1)

	else
		to_chat(H, "<span class='excomm'>[pick(nao_consigoen)] Я не могу. Я должен пойти в церковь.</span>")

/mob/living/carbon/human/proc/epitemia()
	set hidden = 0
	set category = "Power of Faith"
	set name = "Эпитемия"
	set desc="Эпитемия, Анафема!"
	var/input = sanitize_uni(input(usr, "Введите имя грешника.", "Кто?", "") as text|null)
	if(!input)
		return
	var/list/epitemia_list = EPITEMIA_LIST
	var/epitemia_c = sanitize_uni(input(usr, "Какую эпитемию мне следует выбрать?", "Какую?", "") in epitemia_list)
	if(stat || !epitemia_c) return
	var/mob/living/carbon/human/H = usr
	H.qualarea()
	if(H.lastarea && istype(lastarea, /area/dunwell/station/church))
		world << sound('sound/AI/bell_toll_02_lp.ogg')
		to_chat(world, "<span class='ravenheartfortress'>Крепость Фаэторн</span>")
		to_chat(world, "<span class='excomm'>За совершенные грехи, [src.real_name] накладывает эпитемию на [input]: /'[epitemia_c]/'!</span>")
		world << sound('sound/AI/bell_toll.ogg')
		to_chat(world, "<br>")
		to_chat(world, "<span class='decree'>Anathema!</span>")
		to_chat(world, "<br>")
		for(var/mob/living/carbon/human/HH in mob_list)
			if(HH.real_name == input && HH.religion == "Gray Church")
				HH.add_epitemia(epitemia_list[epitemia_c])

/mob/living/carbon/human/proc/free_sins()
	clear_event("epitemia")
	to_chat(src, "<span class='passive'>Наконец-то я освободился от своих грехов!</span>")
	gainWP(TRUE, 3)
	return

/mob/living/carbon/human/proc/banish()
	set hidden = 0
	set category = "Power of Faith"
	set name = "Изгнать нежить"
	set desc="Изгоняет немертвых существ!"

	if(stamina_loss >= 100)
		return

	if(stat) return

	playsound(src.loc, 'sound/lfwbsounds/bishop_banish.ogg', 100, 1)

	for(var/mob/living/carbon/human/H in view(world.view, src))
		if(iszombie(H) || isVampire(H))
			var/turf/target = get_turf(H.loc)
			var/range = rand(4,5)
			var/throw_dir = get_dir(usr, H)
			for(var/i = 1; i < range; i++)
				var/turf/new_turf = get_step(target, throw_dir)
				target = new_turf
				if(new_turf.density)
					break
			H.throw_at(target, rand(4,5), src.throw_speed)
			H.Weaken(2)
			src.adjustStaminaLoss(10)

/mob/living/carbon/human/proc/sins()
	set hidden = 0
	set category = "Power of Faith"
	set name = "Очисти от грехов"
	set desc="Избавься от грехов"

	if(stat) return

	if(istype(src.get_active_hand(), /obj/item/weapon/grab/wrench) && src.zone_sel.selecting == BP_HEAD)
		var/obj/item/weapon/grab/wrench/W = get_active_hand()
		var/mob/living/carbon/human/H = W.affecting
		H.clear_event("sin")
		to_chat(H, "Вы были избавлены от своих грехов.")

var/rewarded = 0

/mob/living/carbon/human/proc/reward()
	set hidden = 0
	set category = "Power of Faith"
	set name = "Наградить инквизитора"
	set desc="Наградить инквизитора"

	if(stat) return
	if(rewarded) return

	var/input = sanitize_uni(input(usr, "Why you should reward?", "Reward", "") as message|null)
	if(!input)
		return

	to_chat(world, "<span class='ravenheartfortress'>Firethorn Fortress</span>")
	if(src.job == "Bishop")
		to_chat(world, "<span class='excomm'>По воле епископа Инквизитор был вознагражден! Его героические заслуги: [input]</span>")
	else
		to_chat(world, "<span class='excomm'>По воле священника Инквизитор был вознагражден! Его героические заслуги: [input]</span>")
	world << sound('sound/AI/bell_toll.ogg')
	to_chat(world, "<span class='decree'>Santa Felicidade!</span>")
	to_chat(world, "<br>")

	for(var/mob/living/carbon/human/H in player_list)
		if(H.job == "Inquisitor" && H.mind)
			rewarded = 1
			Inquisitor_Points += 9
			H.verbs -= /mob/living/carbon/human/proc/reward

/mob/living/carbon/human/proc/coronation()
	set hidden = 0
	set category = "Power of Faith"
	set name = "Коронация"
	set desc="Коронация"

	if(stat) return
	src.qualarea()
	for(var/mob/living/carbon/human/H in view(1, src))
		if(H.head && istype(H.head, /obj/item/clothing/head/caphat) && src.bloody_hands)
			if(H.lastarea && istype(lastarea, /area/dunwell/station/church) || H.lastarea && istype(lastarea, /area/dunwell/station/bridge))
				if(src.lastarea && istype(lastarea, /area/dunwell/station/church) || src.lastarea && istype(lastarea, /area/dunwell/station/bridge))
					src.visible_message("<font color ='#649568'><b>[src]</b> рисует кровавый крест на [H.real_name]'s лбу")
					if(do_after(src, 15))
						H?.client?.ChromieWinorLoose(src.client, 1)
						world << sound('sound/AI/bell_toll_02_lp.ogg')
						to_chat(world, "<h1 class='ravenheartfortress'>Крепость Фаэторн</span>")
						to_chat(world, "<span class='excomm'>По воле крови и креста [H.real_name] коронован новый барон!</span>")
						world << sound('sound/AI/bell_toll.ogg')
						to_chat(world, "<br>")
						to_chat(world, "<span class='decree'>Да будет спасен Бог!</span>")
						to_chat(world, "<br>")
						H.job = "Baron"
						H.add_event("coronation", /datum/happiness_event/misc/coronated)


/mob/living/carbon/human/proc/eucharisty()
	set hidden = 0
	set hidden = 0
	set category = "Power of Faith"
	set name = "Евхаристия"
	set desc="Преврати свою плоть в оружие."

	if(src.get_active_hand() == /obj/item/weapon/organ)
		var/obj/item/weapon/organ/O = src.get_active_hand()
		if(O.blood_DNA == src.dna.unique_enzymes)
			var/list/frasestosay = list("Наконец, укрепитесь в Господе и его сильной силе. Носите все Доспехи Бога, чтобы вы могли стоять против ловушек Дьявола, потому что наша борьба идет не против людей, а против сил и властей, против властителей этого мира тьмы, против духовных сил зла в небесных областях. Поэтому надевайте все Доспехи Бога, чтобы вы могли сопротивляться в плохой день и оставаться непоколебимыми после того, как все сделали.",\
			"Благословен Господь, скала моя, которая тренирует руки мои к войне и пальцы мои к битве. Он мой верный союзник, моя крепость, моя башня защиты и мой освободитель; это мой щит, тот, в котором я укрываюсь. Он подчиняет мне народы.",
			"Ибо, хотя мы живем как люди, мы не боремся по человеческим стандартам. Оружие, с которым мы сражаемся, не является человеческим; скорее, они сильны в Боге, чтобы разрушать крепости. Мы уничтожаем Аргументы и все притязания, которые восстают против Знания Бога, и берем в плен каждую мысль, чтобы сделать ее послушной Христу.",
			"Сражайтесь с доброй борьбой веры. Овладейте вечной жизнью, к которой Вы были призваны и сделали доброе признание в присутствии многих свидетелей.",
			"Неси со мной мои страдания, как добрый воин Христа Иисуса. Ни один солдат не увлекается делами гражданской жизни, так как он хочет угодить тому, кто его завербовал.",
			"Я боролся в хорошем бою, я закончил гонку, я сохранил веру. Теперь мне зарезервирован венец праведности, который Господь, праведный судья, даст мне в тот день; и не только мне, но и всем любящим пришествие Его.",
			"Господь-сила моя и песня Моя; он-спасение мое! Он мой Бог, и я буду восхвалять Его; Он Бог Отца Моего, и я возвеличу его! Господь-воин, его имя-Господь."
			)
			src.say(pick(frasestosay))
			if(do_after(src, 30))
				O.force += 50
				playsound(src.loc, 'sound/lfwbsounds/bishop_banish.ogg', 100, 1)


/mob/living/carbon/human/proc/undeadead()
	set hidden = 0
	set category = "Power of Faith"
	set name = "Изгнать духов"
	set desc="Изгоняет призрачных существ!"

	if(stamina_loss >= 100)
		return

	if(stat) return

	playsound(src.loc, 'sound/lfwbsounds/bishop_banish.ogg', 100, 1)

	for(var/mob/dead/observer/H in view(world.view, src))
		if(iszombie(H))
			var/turf/target = get_turf(H.loc)
			var/range = H.throw_range
			var/throw_dir = get_dir(usr, H)
			for(var/i = 1; i < range; i++)
				var/turf/new_turf = get_step(target, throw_dir)
				target = new_turf
				if(new_turf.density)
					break
			H.throw_at(target, rand(2,4), src.throw_speed)


/mob/living/carbon/human/proc/callmeeting()
	set hidden = 0
	set category = "Power of Faith"
	set name = "Призыв к церковному собранию"
	set desc="Приглашает крепость на встречу!"
	var/mob/living/carbon/human/H = usr

	if(stat) return
	if(!churchexpanded) return
	H.qualarea()
	if(H.lastarea && istype(lastarea, /area/dunwell/station/church))
		if(src.ischurchmeeting == 1)
			to_chat(world, "<span class='ravenheartfortress'>Крепость Фаэторн</span>")
			to_chat(world, "<span class='excomm'>[src] завершает встречу!</span>")
			world << sound('sound/AI/bell_toll.ogg')
			to_chat(world, "<br>")
			to_chat(world, "<span class='decree'>Святой Реюньон!</span>")
			to_chat(world, "<br>")
			src.ischurchmeeting = 0
		else
			to_chat(world, "<span class='ravenheartfortress'>Крепость Фаэторн</span>")
			to_chat(world, "<span class='excomm'>Bishop [src] призывает к церковному собранию!</span>")
			world << sound('sound/AI/bell_toll.ogg')
			to_chat(world, "<br>")
			to_chat(world, "<span class='decree'>Святой Реюньон!</span>")
			to_chat(world, "<br>")
			src.ischurchmeeting = 1

			for(var/mob/living/carbon/human/HH in player_list)
				if(HH.outsider)
					continue
				if(HH.lastarea && !istype(HH.lastarea, /area/dunwell/station/church) && HH.religion == "Gray Church")
					HH.rotate_plane() // ficarem loucos loucos da cabeça...
					HH.emote("scream")
					for(var/x = 0, x<=3, x++)
						sleep(7)
						to_chat(HH, "Я ДОЛЖЕН ПОЙТИ В ЦЕРКОВЬ!!")

		world << sound('sound/AI/bell_toll_02_lp.ogg')
		log_admin("[key_name(src)] has called for a meeting at the church")
		message_admins("[key_name_admin(src)] has called for a meeting at the church", 1)
	else
		to_chat(H, "<span class='excomm'>[pick(nao_consigoen)] Я не могу. Я должен пойти в церковь.</span>")

/mob/living/carbon/human/proc/marriage()
	set hidden = 0
	set category = "Power of Faith"
	set name = "Брак"
	set desc="Соберите всех на свадьбу!"
	var/list/keys = list()
	var/mob/living/carbon/human/MM = usr

	if(stat) return

	MM.qualarea()

	if(MM.lastarea && istype(lastarea, /area/dunwell/station/church))
		var/list/areas = get_areas(/area/dunwell/station/church)
		for(var/area/A in areas)
			for(var/mob/living/carbon/human/H in A)
				if(H.stat) continue
				if(H?.client?.married == null)
					keys += H.real_name
		var/married1 = input("Select a pair!", "setspouse") as null|anything in keys
		var/married2 = input("Select another pair!", "setspouse") as null|anything in keys
		if(!married1 || !married2)
			return
		var/mob/living/carbon/human/M1
		var/mob/living/carbon/human/M2
		for(var/mob/living/carbon/human/H in mob_list)
			var/married1key
			var/married2key
			if(H.real_name == married1)
				married1key = H.client.ckey
				H.client.ChromieWinorLoose(H.client, 1)
				H.client.married = married2key
				for(var/mob/living/carbon/human/H1 in mob_list)
					if(H.client.married == H1.client.ckey)
						var/I = image('icons/mob/mob.dmi', loc = M1, icon_state = "love")
						H.client.images += I
				if(ticker.mode.config_tag == "siege")
					M1 = H
			if(H.real_name == married2key)
				married2key = H.client.ckey
				H.client.ChromieWinorLoose(H.client, 1)
				H.client.married = married1key
				for(var/mob/living/carbon/human/H2 in mob_list)
					if(H.client.married == H2.client.ckey)
						var/I = image('icons/mob/mob.dmi', loc = M2, icon_state = "love")
						H.client.images += I
				if(ticker.mode.config_tag == "siege")
					M2 = H

		to_chat(world, "<span class='ravenheartfortress'>Крепость Фаэторн</span>")
		to_chat(world, "<span class='excomm'>Клянусь узами Креста, [married1] и [married2] соединены до своей смерти! Поздравляем!</span>")
		world << sound('sound/AI/bell_toll.ogg')
		to_chat(world, "<br>")
		to_chat(world, "<span class='decree'>Священное венчание!</span>")
		to_chat(world, "<br>")

		world << sound('sound/AI/bell_toll_02_lp.ogg')
		log_admin("[key_name(src)] объявил о заключении брака между [married1] и [married2]")
		message_admins("[key_name_admin(src)] объявил о заключении брака между [married1] и [married2]", 1)
		if(M1 && M2)
			var/datum/game_mode/siege/S = ticker.mode
			var/list/marrige_M = list(M1, M2)
			if(S.hascountheir in marrige_M)
				marrige_M.Remove(S.hascountheir)
				var/mob/living/carbon/human/M3 = marrige_M[1]
				if((S.hascountheir.gender == MALE && M3.job == "Successor") || (S.hascountheir.gender == FEMALE && M3.job == "Heir"))
					if(!roundendready)
						S.result = SIEGE_DRAW_MARRIAGE
						roundendready = TRUE
	else
		to_chat(MM, "<span class='excomm'>[pick(nao_consigoen)] Я не могу. Я должен пойти в церковь.</span>")

/mob/living/carbon/human/proc/ClearName()
	set hidden = 0
	set category = "Power of Faith"
	set name = "Очистить имя"
	set desc="Очистить имя"

	if(stat) return
	var/list/list_M = list()

	for(var/mob/M in view(7))
		list_M.Add(M)

	list_M.Add("(CANCEL)")
	var/who_name = input(usr, "Who?", "Who?") in list_M

	if(istype(who_name, /mob))
		var/mob/M = who_name
		if(M.nickname)
			visible_message("[src.name] очищает [M.real_name]'s имя!")
			M.nickname = FALSE
			return
		else
			to_chat(src, "<span class='combat'>Его имя очищено</span>")
			return

/datum/job/inquisitor
	title = "Inquisitor"
	titlebr = "Inquisidor"
	flag = INQUISITOR
	department_head = list("Church")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the bishop"
	selection_color = "#dddddd"
	idtype = /obj/item/weapon/card/id/churchkeeper
	access = list(church, access_morgue, access_chapel_office, access_maint_tunnels)
	minimal_access = list(church, access_morgue, access_chapel_office)
//	sex_lock = MALE
	latejoin_locked = FALSE
//	no_trapoc = FALSE

	jobdesc = "Слухи среди разведчиков НКВД привели к полномасштабному расследованию глубоко в Саларской провинции - большинство людей в этом регионе никогда не видели настоящего присутствия НКВД, не говоря уже об инквизиторе. Утверждения о том, что на юге зреет более мощная, чем антитеррористическая ячейка, еще не подтвердились, но говорят, что отколовшаяся от центральной ячейки группа находится в Фаэторне. Вы были выбраны для руководства расследованием, и давление растет. Ваше начальство требует, чтобы квота была заполнена, и вы собираетесь предоставить ее им. Интересно, что каждый, кого вы ненавидите, каким-то образом оказывается еретиком."
	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		if(Inquisitor_Type == "Month's Inquisitor")
			H.voicetype = "sketchy"
			H.religion = "Gray Church"

			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/chaplain(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/general_inquisitor/alt1(H), slot_wear_suit)
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/boots(H), slot_shoes)
			H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/eng(H), 	slot_wrist_r)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/amulet/holy/cross/old(H), slot_amulet)

			H.add_perk(/datum/perk/interrogate)
			H.add_perk(/datum/perk/morestamina)
			H.terriblethings = TRUE
			H.add_perk(/datum/perk/ref/strongback)
			H.add_perk(/datum/perk/heroiceffort)
			H.verbs += /mob/living/carbon/human/proc/interrogate
			H.create_kg()
		if(Inquisitor_Type == "Holy War Veterans")
			H.voicetype = "sketchy"
			H.religion = "Gray Church"

			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/chaplain(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/general_inquisitor/alt1(H), slot_wear_suit)
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/boots(H), slot_shoes)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/inquisihat(H), slot_head)
			H.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/church/veteran(H), slot_r_hand)
			H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/eng(H), 	slot_wrist_r)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/amulet/holy/cross/old(H), slot_amulet)

			H.add_perk(/datum/perk/interrogate)
			H.add_perk(/datum/perk/morestamina)
			H.terriblethings = TRUE
			H.add_perk(/datum/perk/ref/strongback)
			H.add_perk(/datum/perk/heroiceffort)
			H.verbs += /mob/living/carbon/human/proc/interrogate
			H.create_kg()
			H.my_stats.st += rand(0,1)
			H.my_skills.ADD_SKILL(SKILL_MELEE, 1)
			H.my_skills.ADD_SKILL(SKILL_CLIMB, rand(1,2))
		if(Inquisitor_Type == "Master")
			H.voicetype = "sketchy"
			H.religion = "Gray Church"

			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/chaplain(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/general_inquisitor/alt2(H), slot_wear_suit)
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/boots(H), slot_shoes)
			H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/eng(H), 	slot_wrist_r)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/amulet/holy/cross/gcopper(H), slot_amulet)
			H.equip_to_slot_or_del(new /obj/item/sheath/sabre(H), slot_belt)

			H.add_perk(/datum/perk/interrogate)
			H.add_perk(/datum/perk/morestamina)
			H.terriblethings = TRUE
			H.add_perk(/datum/perk/ref/strongback)
			H.add_perk(/datum/perk/heroiceffort)
			H.add_perk(/datum/perk/ancitech)
			H.add_perk(/datum/perk/chemical)
			H.my_stats.it += 2
			H.my_skills.ADD_SKILL(SKILL_MASON, rand(2,3))
			H.my_skills.ADD_SKILL(SKILL_MEDIC, rand(2,3))
			H.my_skills.ADD_SKILL(SKILL_SURG, rand(2,3))
			H.my_skills.ADD_SKILL(SKILL_CRAFT, rand(2,3))
			H.my_skills.ADD_SKILL(SKILL_RANGE, -5)
			H.my_skills.ADD_SKILL(SKILL_MELEE, 5)
			H.verbs += /mob/living/carbon/human/proc/interrogate
			H.create_kg()
		if(Inquisitor_Type == "Fanatic")
			H.voicetype = "sketchy"
			H.religion = "Gray Church"

			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/chaplain(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/general_inquisitor(H), slot_wear_suit)
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/boots(H), slot_shoes)
			H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/eng(H), 	slot_wrist_r)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/amulet/holy/cross/old(H), slot_amulet)

			H.add_perk(/datum/perk/interrogate)
			H.add_perk(/datum/perk/morestamina)
			H.terriblethings = TRUE
			H.add_perk(/datum/perk/ref/strongback)
			H.add_perk(/datum/perk/heroiceffort)
			H.verbs += /mob/living/carbon/human/proc/interrogate

			for(var/datum/organ/external/E in H.organs)
				E.pain_disability_threshold += E.pain_disability_threshold * 2

			H.my_stats.st += rand(1,1)
			H.my_stats.ht += rand(3,4)

			H.create_kg()
		else

			if(Inquisitor_Type == "King's Favourite")
				Inquisitor_Points += 15

			H.voicetype = "sketchy"
			H.religion = "Gray Church"

			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/chaplain(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/inquisition(H), slot_wear_suit)
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/boots(H), slot_shoes)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/inquisihat(H), slot_head)
			H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/eng(H), 	slot_wrist_r)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/amulet/holy/cross/old(H), slot_amulet)

			H.add_perk(/datum/perk/interrogate)
			H.add_perk(/datum/perk/morestamina)
			H.terriblethings = TRUE
			H.add_perk(/datum/perk/ref/strongback)
			H.add_perk(/datum/perk/heroiceffort)
			H.verbs += /mob/living/carbon/human/proc/interrogate
			H.create_kg()

		spawn(30)
			if(currentmaprotation == "Stoneburrow (Map 4)")
				for(var/x = 0; x <= 89; x++)
					sleep(4)
					var/value = 1
					if(x == 89)
						value = 2
					for(var/obj/O in inquisitrainparts)
						O.trainMove(NORTH, value)
			else
				for(var/x = 0; x <= 62; x++)
					sleep(4)
					var/value = 1
					if(x == 62)
						value = 2
					for(var/obj/O in inquisitrainparts)
						O.trainMove(NORTH, value)

		//H << sound('sound/music/train_music.ogg', repeat = 0, wait = 0, volume = 20, channel = 3)
		return 1


/mob/living/carbon/human/proc/interrogate()
	set category = "Inquisition"
	set name = "Допрос"
	if(stat) return
	var/turf/T = get_step(src, dir)
	if(src?.mind?.cooldown_interrogate > world.time)
		to_chat(src, "<span class='jogtowalk'>Давайте дадим им немного времени на размышление...</span>")
		return
	src?.mind?.cooldown_interrogate = world.time + 100
	for(var/mob/living/carbon/human/H in T.contents)
		if(!H.buckled)
			continue
		if(H.stat)
			continue
		if(H == src)
			continue
		if(istype(H, /mob/living/carbon/human/monster))
			continue
		if(H.bot)
			continue

		var/mod_interro
		mod_interro += src.my_stats.wp
		var/mod_H
		mod_H -= (H.get_pain() / 10)
		mod_H += H.my_stats.wp
		var/list/roll_interro = roll3d6(src, (src.my_stats.it - 5), mod_interro, TRUE,TRUE)
		var/list/roll_H = roll3d6(H, src.my_stats.wp, mod_H, TRUE,TRUE)

		if(roll_interro[GP_RESULT] > roll_H[GP_RESULT])
			H.emote("torturescream",1, null, 0)
			H.reveal_self()
			if(prob(50) && !H.religion_is_legal())
				return
			H.reveal_others()
		else if((roll_H[GP_RESULT] + 5) > roll_interro[GP_RESULT])
			H.emote("torturescream",1, null, 0)
			H.reveal_lie()
		else
			to_chat(src, "<span class='jogtowalk'>[pick("Они все еще сопротивляются","Они игнорируют мои вопросы")]...</span>")
			return
		return

/mob/living/carbon/human/proc/religion_is_legal()
	if(religion == "Gray Church")
		return TRUE
	else
		return FALSE

/mob/living/carbon/human/proc/reveal_self()
	src.rotate_plane()
	sleep(20)
	if (religion_is_legal())  //Non-heretics will still deny
		var/list/msg
		msg = list("Я ХОЧУ К СВОЕЙ МАМЕ!", "Я НИЧЕГО НЕ ЗНАЮ!!", "ВЫПУСТИТЕ МЕНЯ!", "ПОЖАЛУЙСТА, ОТПУСТИ МЕНЯ!", "КЛЯНУСЬ, Я НЕ ЗНАЮ!", "Я НЕ СДЕЛАЛ НИЧЕГО ПЛОХОГО!")

		say(pick(msg))
		emote("cry",1, null, 0)
	else
		emote("praise",1, null, 0)
		sleep(20)
		emote("praise",1, null, 0)
		sleep(20)
		emote("praise",1, null, 0)

/mob/living/carbon/human/proc/reveal_lie()
	src.rotate_plane()
	sleep(20)
	if(prob(50))
		var/list/msg
		msg = list("Я ХОЧУ К СВОЕЙ МАМЕ!", "Я НИЧЕГО НЕ ЗНАЮ!!", "ВЫПУСТИТЕ МЕНЯ!", "ПОЖАЛУЙСТА, ОТПУСТИ МЕНЯ!", "КЛЯНУСЬ, Я НЕ ЗНАЮ!", "Я НЕ СДЕЛАЛ НИЧЕГО ПЛОХОГО!")

		say(pick(msg))
		emote("cry",1, null, 0)
	else
		var/list/whom
		for(var/mob/living/carbon/human/H in mob_list)
			if(H.religion_is_legal())
				whom.Add(H.real_name)
		if(whom.len)
			say("[pick("Я ДУМАЮ, ЧТО ЭТО", "ЭТО", "Я КЛЯНУСЬ, ЧТО ЭТО")] [uppertext(pick(whom))]!")
		else
			say("Я НЕ ЗНАЮ, КТО ЭТО!")
		emote("cry",1, null, 0)


/mob/living/carbon/human/proc/reveal_others()
	src.rotate_plane()
	sleep(20)
	if (religion_is_legal())  //Non-heretics will still deny
		var/list/whom
		for(var/mob/living/carbon/human/H in mob_list)
			if(H.religion_is_legal())
				whom.Add(H.real_name)
		if(whom.len)
			say("[pick("Я ДУМАЮ, ЧТО ЭТО", "ЭТО", "Я КЛЯНУСЬ, ЧТО ЭТО")] [uppertext(pick(whom))]!")
		else
			say("Я НЕ ЗНАЮ, КТО ЭТО!")
	else
		var/list/whom
		for(var/mob/living/carbon/human/H in mob_list)
			if(H.religion_is_legal())
				if(prob(15))
					whom.Add(H.real_name)
			else
				if(prob(50))
					whom.Add(H.real_name)
		if(whom.len)
			say("[pick("Я ДУМАЮ, ЧТО ЭТО", "ЭТО", "Я КЛЯНУСЬ, ЧТО ЭТО")] [uppertext(pick(whom))]!")
		else
			say("Я НЕ ЗНАЮ, КТО ЭТО!")
		emote("cry",1, null, 0)

/datum/job/practicus
	title = "Practicus"
	titlebr = "Prático"
	flag = PRACTICUS
	department_head = list("Bishop and the Holy Inquisition")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	jobdesc = "Вряд ли вы столь же обаятельны и хорошо владеете речью, как ваш наставник, но вы - мощный инструмент в его арсенале. Все детали вашей цели в Фаэторне до сих пор неясны. Ваше начальство сказало вам, что это было простое расследование неопределенных заявлений, но вы не можете не чувствовать, что они что-то от вас скрывают. Возможно, вы еще не понимаете, как разговаривать через раздвоенный язык змеи, но вы определенно знаете, как его отрезать. И это именно то, для чего вы здесь находитесь."
	jobdescbr = "Hardly as charming and well spoken as your mentor, you&#8217;re a powerful tool in his arsenal. The entire details of your purpose in Firethorn is still unclear. Your superiors told you it was a simple investigation into uncertain claims, but you can&#8217;t help but feel they&#8217;re holding something back from you. You may not yet understand how to talk past the forked tongue of the snake, but you certainly know how to cut it off. And that&#8217;s exactly what you&#8217;re here to do."
	supervisors = "the bishop and the inquisitor"
	selection_color = "#dddddd"
	idtype = /obj/item/weapon/card/id/churchkeeper
	access = list(church, access_morgue, access_chapel_office, access_maint_tunnels)
	minimal_access = list(church, access_morgue, access_chapel_office)
	sex_lock = MALE
	latejoin_locked = TRUE
	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		if(Inquisitor_Type == "Old Guard")
			H.voicetype = pick("sketchy","strong")
			H.religion = "Gray Church"
			//H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/chaplain(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/practicus(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/boots(H), slot_shoes)
			H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/eng(H), slot_wrist_r)
			H.add_perk(/datum/perk/ref/strongback)
			H.add_perk(/datum/perk/morestamina)
			H.terriblethings = TRUE
			H.create_kg()
		if(Inquisitor_Type == "Holy War Veterans")
			H.voicetype = pick("sketchy","strong")
			H.religion = "Gray Church"
			//H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/chaplain(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/practicus(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/eng(H), slot_wrist_r)
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/boots(H), slot_shoes)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/inkvdhat(H), slot_head)
			H.equip_to_slot_or_del(new /obj/item/clothing/mask/halfmask(H), slot_wear_mask)
			H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/eng(H), slot_wrist_r)
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/inquisition(H), slot_wear_suit)
			H.equip_to_slot_or_del(new /obj/item/weapon/melee/telebaton(H), slot_r_store)
			H.add_perk(/datum/perk/ref/strongback)
			H.add_perk(/datum/perk/morestamina)
			H.terriblethings = TRUE
			H.my_stats.st += rand(1,2)
			H.my_stats.ht += rand(1,2)
			H.my_skills.ADD_SKILL(SKILL_MELEE, 2)
			H.my_skills.ADD_SKILL(SKILL_RANGE, 2)
			H.my_skills.ADD_SKILL(SKILL_CLIMB, rand(1,2))
			H.create_kg()
		else
			H.voicetype = pick("sketchy","strong")
			H.religion = "Gray Church"
			//H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/chaplain(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/practicus(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/boots(H), slot_shoes)
			H.equip_to_slot_or_del(new /obj/item/clothing/mask/halfmask(H), slot_wear_mask)
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/comissar(H), slot_wear_suit)
			H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/eng(H), slot_wrist_r)
			H.add_perk(/datum/perk/ref/strongback)
			H.add_perk(/datum/perk/morestamina)
			H.terriblethings = TRUE
			H.create_kg()
		//H << sound('sound/music/train_music.ogg', repeat = 0, wait = 0, volume = 20, channel = 3)
		return 1

/datum/job/nun
	title = "Nun"
	titlebr = "Freira"
	flag = NUN
	department_head = list("Bishop and the Holy Inquisition")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	jobdesc = "Как сестра церкви, вы являетесь символом чистоты. Вы помогаете больным и обездоленным, и вам доверяют все жители крепости. Вы используете это доверие, чтобы получать информацию от тех, о ком вы заботитесь, и сообщать Святому Отцу о грешниках и злодеях. Доверие и забота - это ваша информация."
	jobdescbr = "Cuide dos feridos, alimente os famintos e não se esqueça de punir os maus costumes."
	supervisors = "the bishop and the inquisitor"
	selection_color = "#dddddd"
	idtype = /obj/item/weapon/card/id/churchkeeper
	access = list(church, access_morgue, access_chapel_office, access_maint_tunnels)
	minimal_access = list(church, access_morgue, access_chapel_office)
	sex_lock = FEMALE
	latejoin_locked = FALSE
	equip(var/mob/living/carbon/human/H)
		if(!H)
			return 0
		..()
		H.religion = "Gray Church"
		H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/chaplain(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/nundress(H), slot_wear_suit)
		H.equip_to_slot_or_del(new /obj/item/clothing/head/nun_hood(H), slot_head)
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/bracelet/cheap(H), slot_wrist_r)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/boots(H), slot_shoes)
		H.create_kg()
		//H << sound('sound/music/train_music.ogg', repeat = 0, wait = 0, volume = 20, channel = 3)
		return 1

