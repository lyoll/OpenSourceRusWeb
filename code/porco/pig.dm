/client/
	var/scrollbarready = 0

/client/proc/loadDataPig()
	var/datum/asset/stuff = get_asset_datum(/datum/asset/pig)
	stuff.register()
	stuff.send(src)

/client/verb/ready()
	set hidden = 1
	set name = "doneRsc"

	pigReady = 1

/client/verb/unready()
	set hidden = 1
	set name = "notdoneRsc"

	pigReady = 0

/mob/new_player/proc/updateTimeToStart()
	if(!client)
		return
	if(!client.pigReady)
		return
	client << output(list2params(list("#timestart", "[ticker?.pregame_timeleft]")), "outputwindow.browser:change")

/mob/new_player/Login()
	..()
	spawn while(client)
		sleep(35)
		updateTimeToStart()
		updatePig()

/mob/new_player/Life()
	..()
	updateTimeToStart()
	updatePig()

/mob/living/carbon/human/proc/updateSpider()
	if(!client)
		return

	var/list/text = list()
	var/fulltext = ""

	if(reflectneed >= 750)
		text += "<a href='#' id='ReflectExperience'>Подумайте о своём опыте!<br></a>"
	if(src?.mind?.succubus)
		text += "<a href='#' id='teleportSlaves'>Teleport Slaves<br></a><a href='#' id='punishSlave'>Накажи раба<br></a> <a href='#' id='killSlave'>Убей раба<br></a>"
	if(src.verbs.Find(/mob/living/carbon/human/proc/plantEgg))
		text += "<a href='#' id='plantEgg'>Отложи яйцо<br></a>"
	if(src.verbs.Find(/mob/living/carbon/human/proc/plantWeeds))
		text += "<a href='#' id='plantWeeds'>Сажайте сорняки<br></a>"
	switch(job)
		if("Bishop")
			text += "<a href='#'' id='Excommunicate'>Отлучить от церкви<br></a><a href='#'' id='BannishtheUndead'>Изгнать нежить</a><a href='#'' id='RobofSins'><br>Избавься от грехов<br></a><a href='#' id='Epitemia''>Эпитемия<br></a><a href='#'' id='RewardtheInquisitor'>Вознаградите инквизитора</a><a href='#'' id='Coronation'><br>Коронация</a><a href='#'' id='Eucharisty'><br>Евхаристия<br></a><a href='#'' id='BannishSpirits'>Изгнать духов<br></a><a href='#'' id='CallforChurchMeeting'>Созвать церковное собрание<br></a><a href='#' id='Marriage''>Брак!<br></a><a href='#' id='ClearName''>Очистить имя<br></a>"
		if("Priest")
			text += "<a href='#'' id='Excommunicate'>Отлучить от церкви<br></a><a href='#'' id='BannishtheUndead'>Изгнать нежить</a><a href='#'' id='RobofSins'><br>Избавься от грехов<br></a><a href='#' id='Epitemia''>Эпитемия<br></a><a href='#'' id='RewardtheInquisitor'>Вознаградите инквизитора</a><a href='#'' id='Coronation'><br>Коронация</a><a href='#'' id='Eucharisty'><br>Евхаристия<br></a><a href='#'' id='BannishSpirits'>Изгнать духов<br></a><a href='#'' id='CallforChurchMeeting'>Созвать церковное собрание<br></a><a href='#' id='Marriage''>Брак!<br></a><a href='#' id='ClearName''>Очистить имя<br></a>"
		if("Monk")
			text += "<a href='#'' id='BannishtheUndead'>Изгнать нежить</a><a href='#'' id='RobofSins'><br>Избавься от грехов<br></a><a href='#'' id='Eucharisty'><br>Евхаристия<br></a><a href='#'' id='BannishSpirits'>Изгнать духов<br></a><a href='#' id='Marriage!''>Брак!<br></a>"
		if("Expedition Leader")
			text += "<a href='#' id='SetMigSpawn'>Установить место прибытия мигранта<br></a><a href='#' id='announceEx'>Объявить (14 TILES)<br></a>"
		if("Bum")
			text += "<a href='#' id='tellTheTruth'>Сказать правду<br></a>"
		if("Urchin")
			text += "<a href='#' id='tellTheTruth'>Сказать правду<br></a>"
		if("Migrant")
			if(!migclass)
				if(ckey in outlaw)
					text += "<a href='#' id='ChoosemigrantClass'>Выберите класс мигрантов!<br></a><a href='#' id='ToggleOutlaw'>Переключить преступников!<br></a>"
				else
					text += "<a href='#' id='ChoosemigrantClass'>Выберите класс мигрантов!<br></a>"
		if("Count")
			text += "<a href='#' id='Reinforcement'>Изменить тип поддержки<br></a><a href='#' id='Command'>Команда<br></a><a href='#' id='SpecialReinforcement'>Вызовите специальное подкрепление!<br></a><a href='#' id='Recruit'>Рекрутировать<br></a><a href='#' id='CaptureThrone'>Захватить трон<br></a>"
		if("Count Hand")
			text += "<a href='#' id='Command'>Команда<br></a><a href='#' id='SpecialReinforcement'>Вызовите специальное подкрепление!<br></a><a href='#' id='Recruit'>Рекрутировать<br></a>"
		if("Count Heir")
			text += "<a href='#' id='SpecialReinforcement'>Вызовите специальное подкрепление!<br></a>"
		if("Sieger")
			if(!migclass)
				text += "<a href='#' id='ChoosesiegerClass'>Выберите осаждающий класс!<br></a>"
		if("Mercenary")
			if(!migclass)
				text += "<a href='#' id='PegaclasseMerc'>Выберите класс наемника!<br></a>"
	if(src.consyte)
		text += "<a href='#' id='Choir'>Choir<br></a><a href='#' id='respark'>Разжечь искру<br></a>"
	if(src.job == "Jester")
		text += "<a href='#' id='Choir'>Choir<br></a><a href='#' id='nickname'>Дать имя!<br></a>"
		text += "<a href='#' id='Choir'>Choir<br></a><a href='#' id='juggle'>Жонглировать!<br></a>"
		text += "<a href='#' id='Choir'>Choir<br></a><a href='#' id='rememberjoke'>Вспомнить шутку!<br></a>"
		text += "<a href='#' id='Choir'>Choir<br></a><a href='#' id='joke'>Шутка!<br></a>"
	if(check_perk(/datum/perk/pathfinder))
		text += "<a href='#' id='TrackSomeonePathfinder'>Выслеживать кого-то<br></a><a href='#' id='TrackselfPathfinder'>Следите за собой<br></a>"

	if(check_perk(/datum/perk/singer))
		text += "<a href='#' id='RememberSong'>Вспомнить песню<br></a><a href='#' id='Sing'>Петь<br></a>"

	for(var/T in text)
		fulltext += "[T]"


/mob/living/carbon/human/proc/updateSmalltext()
	if(!client)
		return

	var/list/text = list()
	var/fulltext = ""

	if(job == "Pusher")
		if(mind)
			text += "ВРЕМЯ ПЛАТИТЬ: <span id='timepusher'>[secondsToMintues(mind.time_to_pay)]</span>"
	if(job == "Inquisitor")
		if(mind && Inquisitor_Type == "Month's Inquisitor")
			text += "Признания в виновности отправлены: (<span id='timepusher'>[secondsToMintues(mind.avowals_of_guilt_sent)] / 6)</span>"
		text += "Пункты поддержки: <span id='timepusher'>[Inquisitor_Points]</span>"
	if(old_ways.god)
		if(old_ways.god == "Xom")
			text += "ТЫ - ИГРУШКА КСОМА"

	if(src?.mind?.succubus)
		text += "Рабы : [src.mind.succubus.succubusSlaves.len]"
	if(ticker.mode.config_tag == "siege" && siegesoldier)
		var/datum/game_mode/siege/S = ticker.mode
		text += "Потери: [S.losses]/[S.max_losses]"
	else if(ticker.mode.config_tag == "miniwar" && mini_war)
		var/datum/game_mode/miniwar/M = ticker.mode
		switch(mini_war)
			if("Northner")
				text += "Потери: [M.north_count]/[M.max_count]"
			if("Southner")
				text += "Потери: [M.south_count]/[M.max_count]"

	for(var/T in text)
		fulltext += "[T]<br>"

	return fulltext

/proc/generateVerbHtml(var/verbname = "", var/displayname = "", var/number = 1)
	if(number % 2)
		return {"<a href='#' class='verb dim' onclick='window.location = "byond://winset?command=[verbname]"'>[displayname]</a>"}
	return {"<a href='#' class='verb' onclick='window.location = "byond://winset?command=[verbname]"'>[displayname]</a>"}

/proc/generateVerbList(var/list/verbs = list(), var/count = 1)
	var/html = ""
	var/counter = count
	for(var/list/L in verbs)
		counter++
		html += generateVerbHtml(L[1], L[2], counter) + "$"

	return html

/client/proc/newtext(var/newcontent = "")
	src << output(list2params(list("[newcontent]")), "outputwindow.browser:InputMsg")

/client/proc/changebuttoncontent(var/idcontent = "", var/newcontent = "")
	src << output(list2params(list("[newcontent]", "[idcontent]")), "outputwindow.browser:changel")

/client/proc/addbutton(var/newcontent = "", var/selector = "")
	src << output(list2params(list("[newcontent]", "[selector]")), "outputwindow.browser:addel")

/mob/proc/updatePig()
	set waitfor = 0
	if(!client)
		return
	if(!client.pigReady)
		return

	var/pixelDistancing = 46
	var/buttonTimes = 1

	var/buttonHTML = ""
	defaultButton()

	buttonHTML += {"<a href="#"><div style="background-image: url(\'Verbs.png\'); margin-right: 8px;" id="Verb" class="button" /></div></a>"}

	if(isobserver(src) || istype(src, /mob/living/carbon/brain))
		buttonHTML += "<a href=\"#\"><div style=\"background-image: url(\'Dead.png\'); margin-top: -50px; margin-left:[pixelDistancing * buttonTimes]px; \" id=\"DeadGhost\" class=\"button\" /></div></a>"

	if(istype(src, /mob/living/carbon/alien) && src.stat == DEAD)
		buttonHTML += "<a href=\"#\"><div style=\"background-image: url(\'Dead.png\'); margin-top: -50px; margin-left:[pixelDistancing * buttonTimes]px; \" id=\"DeadGhost\" class=\"button\" /></div></a>"

	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		buttonHTML += "<a href=\"#\"><div style=\"background-image: url(\'Emotes.png\'); margin-top: -50px; margin-left: [pixelDistancing * buttonTimes]px; \" id=\"Emotes\" class=\"button\" /></div></a>"
		buttonTimes++;
		buttonHTML += "<a href=\"#\"><div style=\"background-image: url(\'Craft.png\'); margin-top: -50px; margin-left:[pixelDistancing * buttonTimes]px; \" id=\"Craft\" class=\"button\" /></div></a>"
		buttonTimes++;
		buttonHTML += "<a href=\"#\"><div style=\"background-image: url(\'GPC.png\'); margin-top: -50px; margin-left:[pixelDistancing * buttonTimes]px; \" id=\"GPC\" class=\"button\" /></div></a>"

		if(H.isVampire)
			buttonTimes++;
			buttonHTML += "<a href=\"#\"><div style=\"background-image: url(\'Fangs.png\'); margin-top: -50px; margin-left:[pixelDistancing * buttonTimes]px; \" id=\"Vampire\" class=\"button\" /></div></a>"
		if(H.job == "Francisco's Advisor")
			buttonTimes++;
			buttonHTML += "<a href=\"#\"><div style=\"background-image: url(\'Plot.png\'); margin-top: -50px; margin-left:[pixelDistancing * buttonTimes]px; \" id=\"Advisor\" class=\"button\" /></div></a>"
		if(H.job == "Francisco's Bodyguard")
			buttonTimes++;
			buttonHTML += "<a href=\"#\"><div style=\"background-image: url(\'Plot.png\'); margin-top: -50px; margin-left:[pixelDistancing * buttonTimes]px; \" id=\"Bodyguard\" class=\"button\" /></div></a>"
		if(H?.mind)
			if(H?.mind?.changeling)
				buttonTimes++
				buttonHTML += "<a href=\"#\"><div style=\"background-image: url(\'Villain.png\'); margin-top: -50px; margin-left:[pixelDistancing * buttonTimes]px; \" id=\"They\" class=\"button\" /></div></a>"
			if(H.mind.special_role == "Head Revolutionary")
				buttonTimes++
				buttonHTML += "<a href=\"#\"><div style=\"background-image: url(\'Epsilon.png\'); margin-top: -50px; margin-left:[pixelDistancing * buttonTimes]px; \" id=\"Integralist\" class=\"button\" /></div></a>"
		if(H?.religion == "Thanati")
			buttonTimes++
			buttonHTML += "<a href=\"#\"><div style=\"background-image: url(\'Thanati.png\'); margin-top: -50px; margin-left:[pixelDistancing * buttonTimes]px; \" id=\"Thanati\" class=\"button\" /></div></a>"
		if(H.anchored && istype(H.anchored, /obj/structure/stool/bed/chair/ThroneMid) && H.head && istype(H.head, /obj/item/clothing/head/caphat))
			buttonTimes++
			buttonHTML += "<a href=\"#\"><div style=\"background-image: url(\'Crown.png\'); margin-top: -50px; margin-left:[pixelDistancing * buttonTimes]px; \" id=\"Crown\" class=\"button\" /></div></a>"
		if(H.anchored && istype(H.anchored, /obj/structure/stool/bed/chair/comfy/judge) && H.job == "Patriarch")
			buttonTimes++
			buttonHTML += "<a href=\"#\"><div style=\"background-image: url(\'Crown.png\'); margin-top: -50px; margin-left:[pixelDistancing * buttonTimes]px; \" id=\"Patriarch\" class=\"button\" /></div></a>"
		if((H.stat == DEAD || H.death_door) && (!(H.status_flags & FAKEDEATH)))
			if((H.health < 0 && H.health > -95.0) || H.death_door || iszombie(H))
				buttonTimes++
				buttonHTML += "<a href=\"#\"><div style=\"background-image: url(\'Dead.png\'); margin-top: -50px; margin-left:[pixelDistancing * buttonTimes]px; \" id=\"Dead\" class=\"button\" /></div></a>"

	client.addbutton(buttonHTML, "#dynamicpanel")
	updateButtons()

/mob/proc/noteUpdate()
	var/newHTML = ""

	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		newHTML += "<span style='white-space: nowrap' class='segment1 ST'>ST: <span id='st'>[H.my_stats.st]</span>$HT: <span id='ht'>[H.my_stats.ht]</span>$IN: <span id='int'>[H.my_stats.it]</span>$DX: <span id='dx'>[H.my_stats.dx]</span></span><span style='word-break:keep-all;white-space: nowrap; position:absolute; margin-right: 35%;' class='segment2 ST MINOR'>CR: <span id='cr'>[client.info?.chromosomes]</span>$PR: <span id='pr'>[H.my_stats.pr]</span>$IM: <span id='im'>[H.my_stats.im]</span>$WP: <span id='wp'>[H.my_stats.wp]</span></span>$$$$$$$$$"
		newHTML += "<span class='smallstat'>[H.updateSmalltext()]</span>"

	return newHTML

/mob/proc/updateButtons()
	set waitfor = 0
	if(!client)
		return
	if(!client.pigReady)
		return

	client.changebuttoncontent("#note", noteUpdate())
	client.changebuttoncontent("#Verb", verbUpdate())
	client.changebuttoncontent("#GPC", spiderUpdate())
	client.changebuttoncontent("#Emotes", {"<span class='segment1'>[generateVerbList(list(list("slap", "Шлепок"), list("Nod", "Кивнуть"), list(".praiselord", "Креститься"), list("Hug", "Обнять"), list("Bow", "Поклониться"), list("Scream", "Кричать"), list("Whimper", "Хныкать"), list("Laugh", "Смеяться"), list("Sigh", "Вздохнуть"), list("Clearthroat", "Прочистить горло"), list("mob_rest", "Рухнуть")))]</span>"} + {"<span class='segment2'>[generateVerbList(list(list("Kiss", "Поцеловать"), list("LickLips", "Облизать губы"), list("Cough", "Кашлять"), list("SpitonSomeone", "Плюнь на кого-нибудь"), list("Yawn", "Зевнуть"), list("Wink", "Подмигивать"), list("Grumble", "Ворчать"), list("Cry", "Плакать"), list("Hem", "Хмыкнуть"), list("Smile", "Улыбнуться")), 2)]</span>"})
	client.changebuttoncontent("#Craft", {"<span class='segment1'>[generateVerbList(list(list("Furniture", "Мебель"), list("Cult", "Культ"), list("Items", "Вещи"), list("Leather", "Кожа"), list("Mason", "Строительство"), list("Tanning", "Кожевничество"), list("Signs", "Знаки")))]</span><span class='segment2'>[generateVerbList(list(list("Weapons", "Оружие"), list("Other", "Остальное")), 2)]</span>"})

	client.changebuttoncontent("#DeadGhost", {"<span class='segment1'>[generateVerbList(list(list("Wraith", "Призрак"), list("Ascend", "Восхождение"), list("LateParty", "Поздняя вечеринка"), list("ToggleDarkness", "Плотность завесы"), list("GotoHell", "Отправиться в ад"), list("Jaunt", "(5) Прогулка"), list("GrueSpawn", "(15) Гру"), list("Ignition", "(30) Поджог"), list("InterveneDreams", "Вмешаться в сон"), list("ReenterCorpse", "Вернуться в тело")))]</span>"})
	client.changebuttoncontent("#Dead", {"<span class='segment1'>[generateVerbList(list(list("Wraith", "Призрак")))]</span>"})

	client.changebuttoncontent("#Vampire", {"<span class='segment1'>[generateVerbList(list(list("ExposeFangs", "Обнажить клыки"), list("BloodStrength", "Сила крови (50cl)"), list("Fortitude", "Сила духа (50cl)"), list("Heal", "Лечение (150cl)"), list("Celerety", "Быстрота (250cl)"), list("DeadEyes", "Мёртвые глаза")))]</span>"})
	client.changebuttoncontent("#Advisor", {"<span class='segment1'>[generateVerbList(list(list("gradeHygiene", "Оценить уровень чистоплотности"), list("gradePeople", "Оценить человека"), list("gradeFortress", "Оценить крепость")))]</span>"})
	client.changebuttoncontent("#Bodyguard", {"<span class='segment1'>[generateVerbList(list(list("localizeAdvisor", "Защитить инспектора")))]</span>"})
	client.changebuttoncontent("#They", {"<span class='segment1'>[generateVerbList(list(list("ExtendTentacles", "Вытягивать щупальца"), list("AbsorbDNA", "Поглощать ДНК жертвы"), list("Hunt", "Охотиться"), list("infest", "Заразить паутину жизни"), list("Lump", "Сбежать"), list("Learnch", "Учится у своих коллег"), list("RegenerativeStasis", "Регенеративная кома")))]</span>"})
	client.changebuttoncontent("#Crown", {"<span class='segment1'>[generateVerbList(list(list("DecretodoBarao", "Указ барона"), list("Abrirtrapdoors", "Открыть ловушки"), list("ColocarTaxas", "Установить налоги"), list("Declararalerta", "Объявить чрезвычайное положение"), list("VendadeDrogas", "Продажа наркотиков"), list("VendadeArmas", "Продажа оружия"), list("Expandirpoderesdaigreja", "Расширить полномочия церкви"), list("SetHands", "Назначить Десницу")))]</span>"})
	client.changebuttoncontent("#Integralist", {"<span class='segment1'>[generateVerbList(list(list("RevConvert", "Конвертировать гражданина")))]</span>"})
	client.changebuttoncontent("#Thanati", {"<span class='segment1'>[generateVerbList(list(list("praisethelord", "Воззвание к Господу"), list("getWords", "Запомни эти слова"), list("getBrothers", "Вспомните своих коллег")))]</span>"})

/mob/proc/verbUpdate()
	var/newHTML = ""
	if(istype(src, /mob/new_player))
		var/lobby = ""
		if(ticker.current_state == GAME_STATE_PREGAME)
			lobby += "Пора начинать: <span id='timestart'>[ticker.pregame_timeleft]</span>$"
			lobby += "Хромосомы: [client.info?.chromosomes]$"
		if(ticker.current_state == GAME_STATE_PLAYING)
			if(ticker.mode.config_tag == "siege")
				var/datum/game_mode/siege/S = ticker.mode
				lobby += "Потери: [S.losses]/[S.max_losses]$"
				lobby += "Следующая волна усиления: [ticker.migwave_timeleft]s$"
				lobby += "Подкрепление: [ticker.migrants_inwave.len]/[ticker.migrant_req]$"
			else
				lobby += "Следующая волна мигрантов: [ticker.migwave_timeleft]s$"
				lobby += "Мигрантов: [ticker.migrants_inwave.len]/[ticker.migrant_req]$"
			lobby += "Хромосомы: [client.info?.chromosomes]$"
			for(var/client/C in ticker.migrants_inwave)
				var/religioncheck = ""
				var/gendercheck = "M"
				var/familycheck = ""

				if(C.prefs.religion != LEGAL_RELIGION)
					religioncheck = "!"
				if(C.prefs.family)
					familycheck = "*"
				if(C.prefs.gender != MALE)
					gendercheck = "F"

				lobby += "<b>[C.ckey]</b> ([C.prefs.age] [gendercheck]) [familycheck][religioncheck]$"
			lobby += "$$<i>! - Pagan </i>$<i>* - Family</i>"
			newHTML += {"<span style='color:#600; font-weight:bold;'>[lobby]</span>"}
	if(ishuman(src))
		newHTML += {"<span class='segment1'>[generateVerbList(list(list("DisguiseVoice", "Замаскировать голос"), list("Dance", "Танцевать"), list("vomit", "Попробовать вызвать рвоту"), list("Pee", "Писать"), list(".asktostop", "Стой")))]</span>"} + {"<span class='segment2'>[generateVerbList(list(list("Notes", "Воспоминания"), list("AddNote", "Добавь воспоминаний"), list("Pray", "Молиться"), list("Clean", "Чистить"), list("Masturbate", "Мастурбировать"), list("Poo", "Наложить")), 2)]</span>"}
	return newHTML

/mob/proc/spiderUpdate()
	var/newOption = ""
	var/list/verbs = list()
	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		verbs += list(list("RememberTheTerrain", "Вспомните местность"))

		if(is_dreamer(H))
			verbs += list(list("Wonders", "Чудеса"))
		if(H.reflectneed >= 750)
			verbs += list(list("ReflectExperience", "Подумайте о своём опыте!"))
		if(H?.mind?.succubus)
			verbs += list(list("teleportSlaves", "Телепортировать рабов"), list("killSlave", "Убить раба"))
		if(istype(H?.species, /datum/species/human/alien))
			verbs += list(list("plantWeeds", "Сажайте сорняки"), list("plantEgg", "Отложите яйцо"))

		if(H.job == "Bishop" || H.old_job == "Bishop")
			verbs += list(list("Excommunicate", "Отлучить от церкви"), list("BannishtheUndead", "Изгонять нежить"), list("RobofSins", "Избавься от грехов"), list("Epitemia", "Эпитемия"), list("RewardtheInquisitor", "Вознаградите инквизитора"), list("Coronation", "Коронация"), list("Eucharisty", "Евхаристия"), list("BannishSpirits", "Изгонять духов"), list("CallforChurchMeeting", "Призвать церковное собрание"), list("Marriage", "Брак!"), list("ClearName", "Очистить имя"))
		if(H.job == "Priest" || H.old_job == "Priest")
			verbs += list(list("Excommunicate", "Отлучить от церкви"), list("BannishtheUndead", "Изгонять нежить"), list("RobofSins", "Избавься от грехов"), list("Epitemia", "Эпитемия"), list("RewardtheInquisitor", "Вознаградите инквизитора"), list("Coronation", "Коронация"), list("Eucharisty", "Евхаристия"), list("BannishSpirits", "Изгонять духов"), list("CallforChurchMeeting", "Призвать церковное собрание"), list("Marriage", "Брак!"), list("ClearName", "Очистить имя"))
		if(H.job == "Monk" || H.old_job == "Monk")
			verbs += list(list("BannishtheUndead", "Изгонять нежить"), list("RobofSins", "Избавься от грехов"), list("Eucharisty", "Евхаристия"), list("BannishSpirits", "Изгонять духов"), list("Marriage", "Брак"))
		if(H.job == "Expedition Leader" || H.old_job == "Expedition Leader")
			verbs += list(list("SetMigSpawn", "Установить место прибытия мигранта"), list("announceEx", "Обьявить (14 TILES)"))

		if(H.job == "Bum" || H.old_job == "Bum")
			verbs += list(list("tellTheTruth", "Сказать правду"))

		if(H.job == "Urchin" || H.old_job == "Urchin")
			verbs += list(list("tellTheTruth", "Сказать правду"))

		if(H.job == "Migrant" || H.old_job == "Migrant")
			if(!H.migclass)
				verbs += list(list("ChoosemigrantClass", "Выберите класс мигрантов!"))
				if(ckey in outlaw)
					verbs += list(list("ToggleOutlaw", "Переключить преступников!"))

		if(H.job == "Count" || H.old_job == "Count")
			verbs += list(list("Reinforcement" , "Изменить тип подкрепления"), list("Command", "Приказать"), list("SpecialReinforcement", "Вызовите специальное подкрепление!"), list("Recruit", "Призвать"), list("CaptureThrone", "Захватить трон"))

		if(H.job == "Count Hand" || H.old_job == "Count Hand")
			verbs += list(list("Command", "Приказать"), list("SpecialReinforcement", "Вызовите специальное подкрепление!"), list("Recruit", "Призвать"))

		if(H.job == "Count Heir" || H.old_job == "Count Heir")
			verbs += list(list("SpecialReinforcement", "Вызовите специальное подкрепление!"))

		if(H.job == "Sieger" || H.old_job == "Sieger")
			if(!H.migclass)
				verbs += list(list("ChoosesiegerClass", "Выберите класс осаждающего!"))

		if(H.job == "Mercenary" || H.old_job == "Mercenary")
			if(!H.migclass)
				verbs += list(list("PegaclasseMerc", "Выберите класс наемника!"))

		if(H.consyte)
			verbs += list(list("Choir", "Хор"), list("Respark", "Зажечь искру"))
		if(H.job == "Jester")
			verbs += list(list("joke", "Шутка"), list("rememberjoke", "Вспомнить шутку"),list("apelidar", "Дайте прозвище!"), list("malabares", "Жонглировать!"))
		if(H.check_perk(/datum/perk/pathfinder))
			verbs += list(list("TrackSomeonePathFinder", "Выслеживать кого-то"), list("TrackselfPathfinder", "Следить за собой"))
		if(H.check_perk(/datum/perk/singer))
			verbs += list(list("RememberSong", "Вспомнить песню"), list("Sing", "Петь"))

		if(H.verbs.Find(/mob/living/carbon/human/proc/interrogate))
			verbs += list(list("Interrogate", "Допрашивать"))

	newOption = generateVerbList(verbs)
	return {"<span class='segment1'>[newOption]</span>"}

/client/proc/lobbyPig()
	src << browse('code/porco/html/pig.html', "window=outputwindow.browser; size=411x330;")

/mob/proc/defaultButton()
	client.changebuttoncontent("#options", "<span class='segment1'>" + generateVerbList(list(list("OOC", "OOC"), list("Adminhelp", "Admin Help"), list(".togglegraphics", "Настройки графики"), list(".addeffects", "(EXPERIMENTAL) Добавление эффектов"), list(".togglefullscreen", "Переключение полноэкранного режима"), list("LobbyMusic", "Переключить музыку в лобби"), list("Midis", "Переключение Midis"), list("AmbiVolume", "Громкость окружения (0-255)"), list("MusicVolume", "Громкость музыки (0, 255)"))) + "</span>")
	if(istype(src, /mob/new_player) && ticker.current_state == GAME_STATE_PREGAME)
		client.changebuttoncontent("#chrome", "<span class='segment1'>" + generateVerbList(list(list("MigracaodeTodos", "(100) Всемиграция"), list("LimparCromossomos", "(100) Обнулить хромосомы"), list("ForceAspect", "(10) Продвинуть Аспект"), list("EscondercargoCustom", "(10) Скрыть особую роль"), list("Escondercargo", "(2)Скрыть роль"), list("ReRolarSpecial", "(2) Сменить особенность"), list("silencePigs", "(2) Молчание свиней"), list("Trapokalipsis", "(15) Трапокалипсис"))) + "</span>")
	else if(istype(src, /mob/living/carbon/human) && ticker.current_state == GAME_STATE_PLAYING)
		client.changebuttoncontent("#chrome", "<span class='segment1'>" + generateVerbList(list(list("LimparCromossomos", "(100) Обнулить хромосомы"), list("ChamarCharon", "(10) Вызвать Харон"), list("ForcePadla", "(7) Продвинуть  Падлу"), list("ReceiveObols", "(1) Получить оболы"), list("RetirarVice", "(1) Удалить недостаток"))) + "</span>")
	else
		client.changebuttoncontent("#chrome", "<span class='segment1'>" + generateVerbList(list(list("LimparCromossomos", "(100) Обнулить хромосомы"), list("ChamarCharon", "(10) Вызвать Харон"), list("ForcePadla", "(7) Продвинуть  Падлу"), list("ReRolarSpecial", "(2) Сменить особенность"))) + "</span>")

/client/proc/setDefaultButtons()
	changebuttoncontent("#Verb", {"<span class='segment1'>[generateVerbList(list(list("DisguiseVoice", "Замаскировать голос"), list("Dance", "Танцевать"), list("vomit", "Попробовать вызвать рвоту"), list("Pee", "Писать"), list(".asktostop", "Стой")))]</span>"} + {"<span class='segment2'>[generateVerbList(list(list("Notes", "Воспоминания"), list("Pray", "Молиться"), list("AddNote", "Добавь воспоминаний"), list("Clean", "Чистить"), list("Masturbate", "Мастурбировать"), list("Poo", "Наложить")))]</span>"})

/client/New()
	..()
	loadDataPig()
	lobbyPig()

	if(!holder)
		return
	winset(src, "outputwindow.csay", "is-visible=true")

/mob/new_player/say(message)
	if(!client)
		return

	client.ooc(message)

/mob/verb/soundbutton()
	set hidden = 1
	set name = "button"

	client << 'sound/uibutton.ogg'

/mob/verb/heartporcao()
	set hidden = 1
	set name = "heartpig"

	soundbutton()

/mob/proc/updateStatPig()
	if(!client)
		return
	if(!client.pigReady)
		return

	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		client << output(list2params(list("#st", "[H.my_stats.st]")), "outputwindow.browser:change")
		client << output(list2params(list("#ht", "[H.my_stats.ht]")), "outputwindow.browser:change")
		client << output(list2params(list("#int", "[H.my_stats.it]")), "outputwindow.browser:change")
		client << output(list2params(list("#dx", "[H.my_stats.dx]")), "outputwindow.browser:change")

	client << output(list2params(list("#cr", "[client.info?.chromosomes]")), "outputwindow.browser:change")
	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		client << output(list2params(list("#pr", "[H.my_stats.pr]")), "outputwindow.browser:change")
		client << output(list2params(list("#timepusher", "[src?:mind?.time_to_pay]")), "outputwindow.browser:change")
		client << output(list2params(list("#im", "[H.my_stats.im]")), "outputwindow.browser:change")
		client << output(list2params(list("#wp", "[H.my_stats.wp]")), "outputwindow.browser:change")

/mob/proc/pigHandler()
	updatePig()
	if(!ishuman(src))
		return

	var/mob/living/carbon/human/H = src
	H.updateStatPig()

/mob/living/carbon/human/New()
	..()

/mob/proc/startPig()
	spawn while(client)
		sleep(85)
		pigHandler()
		updateStatPig()

/mob/living/carbon/human/Login()
	..()
	heartporcao()
	updatePig()
	startPig()

//⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣧⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣧⠀⠀⠀⢰⡿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡟⡆⠀⠀⣿⡇⢻⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠀⣿⠀⢰⣿⡇⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡄⢸⠀⢸⣿⡇⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⡇⢸⡄⠸⣿⡇⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⢸⡅⠀⣿⢠⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣥⣾⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⡿⡿⣿⣿⡿⡅⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠉⠀⠉⡙⢔⠛⣟⢋⠦⢵⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣄⠀⠀⠁⣿⣯⡥⠃⠀⢳⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⡇⠀⠀⠀⠐⠠⠊⢀⠀⢸⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⡿⠀⠀⠀⠀⠀⠈⠁⠀⠀⠘⣿⣄⠀⠀⠀⠀⠀
//⠀⠀⠀⣠⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣷⡀⠀⠀⠀
//⠀⠀⣾⣿⣿⣿⣿⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣧⠀⠀
//⠀⡜⣭⠤⢍⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⢛⢭⣗⠀
//⠀⠁⠈⠀⠀⣀⠝⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠠⠀⠀⠰⡅
//⠀⢀⠀⠀⡀⠡⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠔⠠⡕⠀
//⠀⠀⣿⣷⣶⠒⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠀⠀⠀⠀
//⠀⠀⠘⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⠀⠀⠀⠀⠀
// ⠀⠀⠈⢿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠊⠉⢆⠀⠀⠀⠀
//⠤⠀⠀⢤⣤⣽⣿⣿⣦⣀⢀⡠⢤⡤⠄⠀⠒⠀⠁⠀⠀⠀⢘⠔⠀⠀⠀⠀
//⠀⡐⠈⠁⠈⠛⣛⠿⠟⠑⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
//⠀⠀⠉⠑⠒⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀

// ░░░░░▒░░▄██▄░▒░░░░░░
// ░░░▄██████████▄▒▒░░░
// ░▒▄████████████▓▓▒░░
// ▓███▓▓█████▀▀████▒░░
// ▄███████▀▀▒░░░░▀█▒░░
// ████████▄░░░░░░░▀▄░░
// ▀██████▀░░▄▀▀▄░░▄█▒░
// ░█████▀░░░░▄▄░░▒▄▀░░
// ░█▒▒██░░░░▀▄█░░▒▄█░░
// ░█░▓▒█▄░░░░░░░░░▒▓░░
// ░▀▄░░▀▀░▒░░░░░▄▄░▒░░
// ░░█▒▒▒▒▒▒▒▒▒░░░░▒░░░
// ░░░▓▒▒▒▒▒░▒▒▄██▀░░░░
// ░░░░▓▒▒▒░▒▒░▓▀▀▒░░░░
// ░░░░░▓▓▒▒░▒░░▓▓░░░░░
// ░░░░░░░▒▒▒▒▒▒▒░░░░░░

//`7MMF'   `7MF' db      `7MMF'    MMP""MM""YMM   .g8""8q. `7MMM.     ,MMF'      db      `7MM"""Mq.      `7MN.   `7MF' .g8""8q.         .g8"""bgd `7MMF'   `7MF'    `7MN.   `7MF' .g8""8q. `7MM"""Mq.`7MMM.     ,MMF'
//  `MA     ,V  ;MM:       MM      P'   MM   `7 .dP'    `YM. MMMb    dPMM       ;MM:       MM   `MM.       MMN.    M .dP'    `YM.     .dP'     `M   MM       M        MMN.    M .dP'    `YM. MM   `MM. MMMb    dPMM
//   VM:   ,V  ,V^MM.      MM           MM      dM'      `MM M YM   ,M MM      ,V^MM.      MM   ,M9        M YMb   M dM'      `MM     dM'       `   MM       M        M YMb   M dM'      `MM MM   ,M9  M YM   ,M MM
//    MM.  M' ,M  `MM      MM           MM      MM        MM M  Mb  M' MM     ,M  `MM      MMmmdM9         M  `MN. M MM        MM     MM            MM       M        M  `MN. M MM        MM MMmmdM9   M  Mb  M' MM
//    `MM A'  AbmmmqMA     MM           MM      MM.      ,MP M  YM.P'  MM     AbmmmqMA     MM  YM.         M   `MM.M MM.      ,MP     MM.           MM       M        M   `MM.M MM.      ,MP MM        M  YM.P'  MM
//     :MM;  A'     VML    MM           MM      `Mb.    ,dP' M  `YM'   MM    A'     VML    MM   `Mb.       M     YMM `Mb.    ,dP'     `Mb.     ,'   YM.     ,M        M     YMM `Mb.    ,dP' MM        M  `YM'   MM
//      VF .AMA.   .AMMA..JMML.       .JMML.      `"bmmd"' .JML. `'  .JMML..AMA.   .AMMA..JMML. .JMM.    .JML.    YM   `"bmmd"'         `"bmmmd'     `bmmmmd"'      .JML.    YM   `"bmmd"' .JMML.    .JML. `'  .JMML.⠀⠀⠀⠀⠀