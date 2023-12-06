/var/obj/effect/lobby_image = new/obj/effect/lobby_image()
var/interquote = pick("Я ненавижу это место и сделал бы все, чтобы выбраться отсюда, да смилуется над нами великий Господь.",
"Все свиньи должны умереть.", "На небесах нет ангелов; все они здесь, внизу.","Расправь свои крылья по пути вниз.","Я трус, воткни в меня свой нож.",
"Счастье превращает смерть в угрозу.","Трое могут сохранить тайну, если двое из них мертвы.",
"Радуйся, что это произошло, а не печалься, что это заканчивается","Этот мир - машина! Машина для свиней! Пригоден только для забоя свиней!",
"Я умоляю тебя. Ты заставил меня. Ты мой Создатель, мой Отец. Ты не можешь уничтожить меня!","Теперь ты у меня в руках, существо. Я уничтожу тебя.",
"Все кончено. Пришло время положить конец этому безумию.","Тот, кто превращает себя в зверя, избавляет себя от боли быть человеком.")
var/brquote = pick("Я ненавижу это место и сделал бы все, чтобы выбраться отсюда, да смилуется над нами великий Господь.",
"Все свиньи должны умереть.", "На небесах нет ангелов; все они здесь, внизу.","Расправь свои крылья по пути вниз.","Я трус, воткни в меня свой нож.",
"Счастье превращает смерть в угрозу.","Трое могут сохранить тайну, если двое из них мертвы.",
"Радуйся, что это произошло, а не печалься, что это заканчивается","Этот мир - машина! Машина для свиней! Пригоден только для забоя свиней!",
"Я умоляю тебя. Ты заставил меня. Ты мой Создатель, мой Отец. Ты не можешь уничтожить меня!","Теперь ты у меня в руках, существо. Я уничтожу тебя.",
"Все кончено. Пришло время положить конец этому безумию.","Тот, кто превращает себя в зверя, избавляет себя от боли быть человеком.")
/obj/effect/lobby_image
	name = "Farweb"
	desc = "Theatre of pain."
	icon = 'icons/misc/fullscreen.dmi'
	icon_state = "title"
	screen_loc = "WEST,SOUTH"
	plane = 300

/obj/effect/lobby_grain
	name = "Grain"
	desc = "Theatre of pain."
	icon = 'icons/misc/fullscreen.dmi'
	icon_state = "grain"
	screen_loc = "WEST,SOUTH"
	mouse_opacity = 0
	layer = MOB_LAYER+6
	plane = 300

/obj/effect/lobby_image/New()
	if(master_mode == "holywar")
		icon_state = "holywar"
	else
		icon_state = "title"
	overlays += /obj/effect/lobby_grain
	desc = vessel_name()

/mob/new_player/Login()
	..()
	if(ticker?.current_state != GAME_STATE_PLAYING)
		for(var/mob/new_player/N in mob_list)
			to_chat(N, "⠀<span class='passivebold'>[capitalize(usr.key)] подключился.</span>")
	var/list/locinfo = client?.get_loc_info()
	update_Login_details()	//handles setting lastKnownIP and computer_id for use by the ban systems as well as checking for multikeying
	winset(src, null, "mainwindow.title='Farweb'")//Making it so window is named what it's named.
	if(join_motd)
		if(guardianlist.Find(ckey(src.client.key)))
			to_chat(src, "Добро пожаловать, <span class='graytextbold'>[capitalize(usr.ckey)]</span>! Ваш уровень надежности: <span class='guardianlobby'>Хранитель</span>")
		else if(src.client in admins)
			to_chat(src, "Добро пожаловать, <span class='graytextbold'>[capitalize(usr.ckey)]</span>! Ваш уровень надежности: <span class='adminlobby'>[src.client.holder.rank]</span>")
		else if(comradelist.Find(ckey(src.client.key)))
			to_chat(src, "Добро пожаловать, <span class='graytextbold'>[capitalize(usr.ckey)]</span>! Ваш уровень надежности: <span class='comradelobby'>Товарищ</span>")
		else if(villainlist.Find(ckey(src.client.key)))
			to_chat(src, "Добро пожаловать, <span class='graytextbold'>[capitalize(usr.ckey)]</span>! Ваш уровень надежности: <span class='villainlobby'>Мерзавец</span>")
		else if(pigpluslist.Find(ckey(src.client.key)))
			to_chat(src, "Добро пожаловать, <span class='graytextbold'>[capitalize(usr.ckey)]</span>! Ваш уровень надежности:: <span class='graytextbold'>Опытная свинья</span>")
		else
			to_chat(src, "Добро пожаловать,<span class='graytextbold'>[capitalize(usr.ckey)]</span>! Ваш уровень надежности: <span class='graytextbold'>Свинья</span>")
		to_chat(src, "Нажми <a href='?src=\ref[src];action=f12'>F12</a> и найди свою смерть!")
		to_chat(src, "Карта этой недели:</span> <span class='bname'><i>[currentmaprotation]</i></span>")
		to_chat(src, "Страна: <span class='bname'>[capitalize(locinfo["country"])]</span>")
		to_chat(src, "<span class='lobby'>Ruweb   </span> <span class='lobbyy'>Story #[story_id]</span>")
		to_chat(src, "<span class='bname'><b>Сплетение жизни:</span></b> <i>\"[interquote]\"</i>")
	if(ticker && ticker.current_state == GAME_STATE_PLAYING && master_mode == "inspector")
		to_chat(src, "\n<div class='firstdivmood'><div class='moodbox'><span class='graytext'>Вы можете присоединиться в качестве инспектора или его телохранителя.</span>\n<span class='feedback'><a href='?src=\ref[src];acao=joininspectree'>1. I want to.</a></span>\n<span class='feedback'><a href='?src=\ref[src];acao=nao'>2. I'll pass.</a></span></div></div>")


	if(!mind)
		mind = new /datum/mind(key)
		mind.active = 1
		mind.current = src

	if(length(newplayer_start))
		loc = pick(newplayer_start)
	else
		loc = locate(1,1,1)
	lastarea = loc

	//unlock_medal("First Timer", 0, "Welcome!", "easy")

	sight |= SEE_TURFS
	player_list |= src
	client.screen += lobby_image

/*
	var/list/watch_locations = list()
	for(var/obj/effect/landmark/landmark in landmarks_list)
		if(landmark.tag == "landmark*new_player")
			watch_locations += landmark.loc

	if(watch_locations.len>0)
		loc = pick(watch_locations)
*/
	new_player_panel()
	spawn(40)
		if(client)
			client.playtitlemusic()
