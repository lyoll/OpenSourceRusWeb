var/silenceofpigs = FALSE
var/trapokalipsis = FALSE
var/global/list/hiden_obols = list()
/client/proc/ChromieReturn(client/user, var/cost, var/name, var/desc)
	if(!user)
		return
	if(!cost)
		return
	if(current_server == "S3")
		return
	if(chromie_holder.chromie_number < cost)
		to_chat(usr, "Недостаточно хромосом.")
		return
	if(chromie_holder.chromie_number >= cost)
		AdjustChromies(cost*-1) // multiply by negative one to make the value negative
		ChromieDO(user, name)
		to_chat(usr, "<span class='excomm'>[cost] Хромосом потеряно!</span>")
		return TRUE

/client/proc/ChromieDO(mob/user, var/name)
	if(current_server == "S3")
		return
	switch(name)
		if("Limpar Cromossomos")
			return
		if("ReRolarSpecial")
			var/mob/new_player/N = user
			if(N.special || SpecialRolledList.Find(N.ckey))
				if(SpecialRolledList.Find(N.ckey))
					SpecialRolledList.Remove(N.ckey)
				N.special = 0
				N.specialitem = null
				N.specialdesc = null
				N.qualspecial = ""

		if("Chamar a Babylon")
			emergency_shuttle.incall()
			log_game("[src] запустил Харон.")
			message_admins("[src] запустил Харон.", 1)
			world << sound('sound/AI/shuttlecalled.ogg')
		if("RetirarVice")
			var/mob/living/carbon/human/H = user
			if(H.vice)
				H.vice = null
				H.viceneed = 0
				H.clear_event("vice")
				return
		if("SilencePigs")
			to_chat(world, "<p style='font-size:22px'><span class='passivebold'>[src.key] дарует нам молчание свиней!</span></p>")
			world << 'pigdeath.ogg'
			silenceofpigs = TRUE
			return
		if("Trapokalipsis")
			trapokalipsis = TRUE
			to_chat(world, "<p style='font-size:22px'><span class='passivebold'>[src.key] дарует нам Трапокалипсис!</span></p>")
			trapapoc = ckeywhitelistweb.Copy()
			world << 'ladyend.ogg'
		if("ForceAspect")
			var/mob/new_player/N = user
			var/events_pick = subtypesof(/datum/round_event)
			var/list/events_choose
			for(var/datum/round_event/E in events_pick)
				new E
				events_choose[E.name] = E
			var/event_select = input(N, "Select an Aspect.", "Aspects", null) in events_choose
			if(!event_select)
				event_select = pick(events_choose)
			for(var/i = 1, i <= aspects_max, i++)
				N.aspects_list += events_choose[event_select]
			to_chat(src, "<b>Aspect Rerolls Left:</b> [N.aspects_rerolls]")
			var/number = 1
			for(var/datum/round_event/R in N.aspects_list)
				to_chat(N, "[number]. <b>[R.name]</b> - [R.event_message]")
				number++
		if("ReceiveObols")
			var/obj/item/weapon/card/id/ID = found_ring_by_human(user)
			if(!ID)
				hiden_obols += user.ckey
				to_chat(user, "<i>Я спрятал оболы, но где...</i>")
			else
				to_chat(user, "Нашёл ли я их?")
				ID.receivePayment(50)

/client/proc/ChromieWinorLoose(mob/user, var/value)
	var/chromossomeTXT
	if(!value)
		return
	if(current_server == "S3")
		return
	if(value > 0)
		AdjustChromies(value)
		chromossomeTXT = "<span class='passivebold'>[value] Приобретено хромосом!</span>"
		if(value > 3)
			chromossomeTXT = "<span class='passivebold'>[value] Приобретено хромосом!</span>"
		to_chat(src, chromossomeTXT)
	if(value < 0)
		if(info.chromosomes <= -5)
			return
		AdjustChromies(value)
		cromosperdidos += value
		chromossomeTXT = "<span class='excomm'>[value] Хромосом потеряно!</span>"
		if(value > -3)
			chromossomeTXT = "<span class='excomm'>[value] Хромосом потеряно!</span>"
		to_chat(src, chromossomeTXT)

/client/verb/wipeChromossomes()
	set category = "Chromossomes"
	set name = "Обнулить хромосомы"
	set desc = "Вы очистите все хромосомы игроков."


	var/nameE = "Limpar Cromossomos"
	var/descE = "Voce vai limpar todos os cromossomos dos jogadores."
	var/cost = 100

	ChromieReturn(usr, cost, nameE, descE)


/client/verb/allMig()
	set category = "Chromossomes"
	set name = "Всемиграция"
	set desc = "Провозгласите всемиграцию."


	var/nameE = "Migracao de Todos"
	var/descE = "Voce vai fazer o gamemode All Mig."
	var/cost = 100

	ChromieReturn(usr, cost, nameE, descE)

/client/verb/callCharon()
	set category = "Chromossomes"
	set name = "ChamarCharon"
	set desc = "Voce vai chamar a Charon."

	var/nameE = "Chamar a Babylon"
	var/descE = "Voce vai chamar a Babylon."
	var/cost = 10

	if(ticker.mode.config_tag == "kingwill" && world.time < 80 MINUTES)
		to_chat(usr, "<span class='combatbold'>The tribunal will not allow the Babylon to be launched.</span>")
		return

	if(ticker.mode.config_tag == "siege")
		to_chat(usr, "<span class='combatbold'>There can be only one!</span>")
		return

	var/datum/shuttle/shuttle = shuttleMain

	if(shuttle.called)
		to_chat(usr, "<span class='combat'>The Babylon launch has already been initiated.</span>")
		return

	shuttle.callshuttle()
	log_game("[key_name(usr)] has launched the Babylon.")
	message_admins("[key_name_admin(usr)] has launched the Babylon.", 1)

	ChromieReturn(usr, cost, nameE, descE)

/client/verb/jobConcealCustom()
	set category = "Chromossomes"
	set name = "Скрыть индивидуальную роль"
	set desc = "Скрыть индивидуальную роль"

	var/nameE = "Esconder cargo Custom"
	var/descE = "Voce vai se conceder um cargo customizado."
	var/cost = 10

	ChromieReturn(usr, cost, nameE, descE)

/client/verb/jobConceal()
	set category = "Chromossomes"
	set name = "Скрыть роль"
	set desc = "Скрыть роль"

	var/nameE = "Esconder cargo"
	var/descE = "Voce vai se conceder um cargo."
	var/cost = 2

	ChromieReturn(usr, cost, nameE, descE)

/client/verb/rerollSpecial()
	set category = "Chromossomes"
	set name = "Сменить особенность"
	set desc = "Сменить особенность."

	var/nameE = "ReRolarSpecial"
	var/descE = "Voce vai dar reroll em seu Special."
	var/cost = 2

	ChromieReturn(usr, cost, nameE, descE)

/client/verb/Trapokalipsis()
	set category = "Chromossomes"
	set name = "Трапоапокалипсис"
	set desc = "Вот оно, - счастье."

	var/nameE = "Trapokalipsis"
	var/descE = "Pain."
	var/cost = 15

	if(trapokalipsis)
		return

	ChromieReturn(usr, cost, nameE, descE)

/client/verb/removeVice()
	set category = "Chromossomes"
	set name = "Убрать недостаток"
	set desc = "Вы уберете свою зависимость от чего-то."

	var/nameE = "RetirarVice"
	var/descE = "Voce vai retirar seu vicio sobre algo."
	var/cost = 1

	if(!ticker || ticker.current_state != GAME_STATE_PLAYING)
		to_chat(src, "Раунд либо не готов, либо уже завершен...")
		return 0
	ChromieReturn(usr, cost, nameE, descE)

/client/verb/silencePigs()
	set category = "Chromossomes"
	set name = "Молчание свиней"
	set desc = "Пусть помолчат"

	var/nameE = "SilencePigs"
	var/descE = "cale os porcos"
	var/cost = 2
	if(silenceofpigs)
		return
	ChromieReturn(usr, cost, nameE, descE)

/client/verb/ForceAspect()
	set category = "Chromossomes"
	set name = "Продвинуть аспект"
	set desc = "продвинуть аспект"

	var/nameE = "ForceAspect"
	var/descE = "Force Aspect"
	var/cost = 10

	if(!istype(usr, /mob/new_player) || ticker.current_state != GAME_STATE_PREGAME)
		to_chat(usr, "It's only useble before round begins.")
		return

	ChromieReturn(usr, cost, nameE, descE)

/client/verb/ForcePadla()
	set category = "Chromossomes"
	set name = "Продвинуть Падлу"
	set desc = "Продвинуть Падлу"

	var/nameE = "ForcePadla"
	var/descE = "Force Padla"
	var/cost = 7

	if (!ticker || ticker.current_state != GAME_STATE_PLAYING)
		to_chat(usr, "Дождитесь начала раунда.")
		return

	ChromieReturn(usr, cost, nameE, descE)

/client/verb/ReceiveObols()
	set category = "Chromossomes"
	set name = "Получить оболы"
	set desc = "Получить оболы"

	var/nameE = "ReceiveObols"
	var/descE = "Receive Obols"
	var/cost = 1

	if (!istype(usr, /mob/living/carbon/human))
		to_chat(usr, "В конце концов, мне нужно быть человеком...")
		return

	ChromieReturn(usr, cost, nameE, descE)