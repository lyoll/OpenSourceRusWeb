/datum/perk/
	var/name = "Perk"
	var/description = "Description"
	var/reflectmessage = "Nothing!"

/datum/perk/proc/pick_perk(var/list/current_perks)
	var/perks
	if(length(current_perks))
		perks = pick(subtypesof(/datum/perk/) - current_perks)
	else
		perks = pick(subtypesof(/datum/perk/))
	if (perks)
		var/perk = new perks
		return perk
	else
		warning("erro na perk de alguem ai")

/datum/perk/proc/pick_perk_ref(var/list/current_perks)
	var/perks
	if(length(current_perks))
		perks = pick(subtypesof(/datum/perk/ref) - current_perks)
	else
		perks = pick(subtypesof(/datum/perk/ref))
	if (perks)
		var/perk = new perks
		return perk
	else
		warning("erro na perk de alguem ai")

/mob/living/carbon/human/proc/add_perk(var/datum/perk/perkpath)
	var/datum/perk/perkpaths = new perkpath(src.perks)
	src.perks.Add(perkpaths)

/mob/living/carbon/human/proc/check_perk(var/datum/perk/perkpath)
	for(var/datum/perk/P in src.perks)
		if(istype(P, perkpath))
			return 1
	return 0

/datum/perk/illiterate
	name = "Illiterate"
	description = "Я горжусь тем, что неграмотен."

/datum/perk/ref/teaching
	name = "Teaching"
	description = "Преподавание - это для меня."
	reflectmessage = "Я научился преподавать."

/datum/perk/docker
	name = "Docker"
	description = "Я могу таскать тяжелые тяжести."

/datum/perk/likeart
	name = "Likeart"
	description = "Мне нравится искусство."

/datum/perk/morestamina
	name = "Morestamina"
	description = "У меня больше выносливости, чем у других людей."

/datum/perk/lessstamina
	name = "Lessstamina"
	description = "У меня меньше выносливости, чем у других людей."

/datum/perk/screamerimmunity
	name = "Screamerimmunity"
	description = "У меня иммунитет к инфекциям крикунов."

/datum/perk/ref/value
	name = "Value"
	description = "I know the value of things."
	reflectmessage = "Теперь я знаю, как оценить стоимость товара."

/datum/perk/pathfinder
	name = "Pathfinder"
	description = "Я хорошо разбираюсь в навигации."

/datum/perk/singer
	name = "Singer"
	description = "Я хороший певец."

/datum/perk/heroiceffort
	name = "HeroicEffort"
	description = "Я могу совершать героические усилия."

/datum/perk/ref/strongback
	name = "Strongback"
	description = "У меня крепкая спина."
	reflectmessage = "Теперь у меня крепкая спина."

/datum/perk/ref/disarm
	name = "Disarm"
	description = "Я люблю обезоруживать."
	reflectmessage = "Я люблю обезоруживать."

/datum/perk/ref/slippery
	name = "Slippery"
	description = "Я скользкий."
	reflectmessage = "Я теперь скользкий, мне легче ускользать от захватов."

/datum/perk/ref/jumper
	name = "Jumper"
	description = "Я такой прыгун."
	reflectmessage = "Я такой прыгун, что теперь могу перепрыгнуть на 5 плиток дальше!"

/datum/perk/interrogate
	name = "Interrogate"
	description = "Они замечают мои вопросы."

/datum/perk/sexaddict
	name = "Sexaddict"
	description = "Я одержим сексом."

/datum/perk/ref/cavetravel
	name = "cavetravel"
	description = "Я знаю, как быстро передвигаться по пещерам."
	reflectmessage = "Я знаю, как быстро передвигаться по пещерам."

/datum/perk/ref/traptard
	name = "traptard"
	description = "Ловушки ловят только отстающих."
	reflectmessage = "Ловушки ловят только отстающих!"

/datum/perk/ref/warlock
	name = "warlock"
	description = "Я в безопасности от Падлы."
	reflectmessage = "Колдун наблюдал за тобой, он больше не причинит тебе вреда."

/datum/perk/ref/silent
	name = "silent"
	description = "Я молчу."
	reflectmessage = "Я молчу, никто не слышит моих шагов."

/datum/perk/ancitech
	name = "ancitech"
	description = "Я знаю о древних технологиях."

/datum/perk/shoemaking
	name = "shoemaking"
	description = "Я знаю, как шить обувь."

/datum/perk/chemical
	name = "chemical"
	description = "Я знаю, как смешивать химикаты."

/datum/perk/bees
	name = "bees"
	description = "Я знаю пчел."

/datum/perk/bee_queen
	name = "bee_queen"
	description = "Я знаю, что пчелы любят меня."

/datum/perk/gemcutting
	name = "gemcutting"
	description = "Я разбираюсь в драгоценных камнях."

/mob/living/carbon/human/proc/reflectexperience()
	set name = "ReflectExperience"
	if(reflectneed < 700)
		return
	if(stat == DEAD)
		to_chat(src, "<span class='combat'>Я мёртв!</span>")
		return
	if(stat != 1 && reflectneed >= 740)
		to_chat(src, "<span class='combat'>Мне нужно найти кровать.</span>")
		return
	if(!buckled)
		to_chat(src, "<span class='combat'>[pick(nao_consigoen)] Мне нужно поспать на кровати.</span>")
		return
	if(stat == 1 && reflectneed >= 740 && istype(buckled, /obj/structure/stool/bed))
		src.gainWP(1,1)
		src.reflectneed = 0
		if(src.species.name == "Child" && prob(10))
			to_chat(src, "Воздействие радиации паутины жизни привело к тому, что вы быстрее состарились.")
			src.set_species("Human")
		else if(prob(10))
			add_random_stat()
			return
		else
			var/list/ablePerks = list()
			for(var/F in subtypesof(/datum/perk/ref))
				var/datum/perk/habilidade = F
				if(habilidade in src.perks) continue
				ablePerks.Add(habilidade)
			var/perkPath = pick(ablePerks)
			if(!perkPath)
				add_random_stat()
				return
			var/datum/perk/P = new perkPath

			to_chat(src, "<span class='malfunction'><b>[P.reflectmessage]</b></span>")
			src.perks.Add(P)
		return

/mob/living/carbon/human/proc/add_random_stat()
	var/random_stat = pick(STAT_ST, STAT_DX, STAT_HT, STAT_PR, STAT_IN, STAT_IM)
	switch(random_stat)
		if(STAT_ST)
			to_chat(src, "<span class='malfunction'><b>Шло время, и ты становился сильнее.</b></span>")
			my_stats.initst += 1
			my_stats.st += 1
		if(STAT_DX)
			to_chat(src, "<span class='malfunction'><b>Со временем вы стали более проворными.</b></span>")
			my_stats.initdx += 1
			my_stats.dx += 1
		if(STAT_HT)
			to_chat(src, "<span class='malfunction'><b>С течением времени ты становишься жестче.</b></span>")
			my_stats.initht += 1
			my_stats.ht += 1
		if(STAT_PR)
			to_chat(src, "<span class='malfunction'><b>Со временем вы стали более внимательными.</b></span>")
			my_stats.initpr += 1
			my_stats.pr += 1
		if(STAT_IN)
			to_chat(src, "<span class='malfunction'><b>Со временем ты стал умнее.</b></span>")
			my_stats.initit += 1
			my_stats.it += 1
		if(STAT_IM)
			to_chat(src, "<span class='malfunction'><b>Со временем ваша иммунная система улучшилась.</b></span>")
			my_stats.initim += 1
			my_stats.im += 1