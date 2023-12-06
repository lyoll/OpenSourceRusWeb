
/mob/living/carbon/human/proc/handle_vice()
	if(vice)
		if(viceneed < 1000)
			spawn(10)
				viceneed += rand(1,2)
				clear_event("vice")

	if(viceneed > 1000)
		viceneed = 1000

	if(viceneed >= 1000)
		switch(vice)
			if("Smoker")
				add_event("vice", /datum/happiness_event/vice/smoke)
				if(sleeping) return

				if(prob(1))
					to_chat(src, "<br><span class='graytextbold'>⠀+ Мне нужно покурить. +</span><br>")
			if("Pothead")
				add_event("vice", /datum/happiness_event/vice/weed)
				if(sleeping) return

				if(prob(1))
					to_chat(src, "<br><span class='graytextbold'>⠀+ Мне нужно ещё. +</span><br>")
			if("Pyromaniac")
				add_event("vice", /datum/happiness_event/vice/pyromaniac)
				if(sleeping) return

				if(prob(1))
					to_chat(src, "<br><span class='graytextbold'>⠀+ Мне нужно увидеть, как горит мир. +</span><br>")
			if("Kleptomaniac")
				add_event("vice", /datum/happiness_event/vice/klepto)
				if(sleeping) return

				if(prob(1))
					to_chat(src, "<br><span class='graytextbold'>⠀+ Мне нужно у кого-нибудь украсть. +</span><br>")
			if("Photographer")
				add_event("vice", /datum/happiness_event/vice/photo)
				if(sleeping) return

				if(prob(1))
					to_chat(src, "<br><span class='graytextbold'>⠀+ Мне нужно кое-кого сфотографировать. +</span><br>")
			if("Addict (Kisses)")
				add_event("vice", /datum/happiness_event/vice/kiss)
				if(sleeping) return

				if(prob(1))
					to_chat(src, "<br><span class='graytextbold'>⠀+ Мне нужен поцелуй. +</span><br>")
			if("Necrophile")
				if(src.age > 17)
					add_event("vice", /datum/happiness_event/vice/necro)
					if(sleeping) return

					if(prob(1))
						to_chat(src, "<br><span class='graytextbold'>⠀+ Мне нужен кто-то более испорченный, чем я сам. +</span><br>")
			if("Sexoholic")
				if(src.age > 17)
					add_event("vice", /datum/happiness_event/vice/sexo)
					if(sleeping) return

					if(prob(1))
						to_chat(src, "<br><span class='graytextbold'>⠀+ Мне нужно удовлетворить свои желания. +</span><br>")
			
			if("Voyeur")
				if(src.age > 17)
					add_event("vice", /datum/happiness_event/vice/voyeur)
					if(sleeping) return

					if(prob(1))
						to_chat(src, "<br><span class='graytextbold'>⠀+ Мне нужно посмотреть, как кто-то делает это. +</span><br>")

			if("Alcoholic")
				add_event("vice", /datum/happiness_event/vice/alco)
				if(sleeping) return

				if(prob(1))
					to_chat(src, "<br><span class='graytextbold'>⠀+ Мне нужно выпить. +</span><br>")
			if("Addict (Buffout)")
				add_event("vice", /datum/happiness_event/vice/buff)
				if(sleeping) return

				if(prob(1))
					to_chat(src, "<br><span class='graytextbold'>⠀+ Мне нужно принять душ. +</span><br>")
			if("Addict (Mentats)")
				add_event("vice", /datum/happiness_event/vice/ment)
				if(sleeping) return

				if(prob(1))
					to_chat(src, "<br><span class='graytextbold'>⠀+ Мне нужно принять ментатов. +</span><br>")
			if("Addict (Heroin)")
				add_event("vice", /datum/happiness_event/vice/heroin)
				if(sleeping) return

				if(prob(1))
					to_chat(src, "<br><span class='graytextbold'>⠀+ Мне нужна доза. +</span><br>")
			if("Addict (Stimulants)")
				add_event("vice", /datum/happiness_event/vice/stimulants)
				if(sleeping) return

				if(prob(1))
					to_chat(src, "<br><span class='graytextbold'>⠀+ Мне нужно быть живым. +</span><br>")
			if("Masochist")
				add_event("vice", /datum/happiness_event/vice/maso)
				if(sleeping) return

				if(prob(1))
					to_chat(src, "<br><span class='graytextbold'>⠀+ Мне нужно почувствовать боль! +</span><br>")

/mob/living/carbon/human/proc/handle_reflect()
	if(can_reflect == FALSE)
		return
	if(reflectneed < 750)
		spawn(10)
			reflectneed += rand(1,2)
			clear_event("reflect")
			src.verbs -= /mob/living/carbon/human/proc/reflectexperience

	if(reflectneed > 750)
		reflectneed = 750
		src.verbs += /mob/living/carbon/human/proc/reflectexperience
		spawn(80)
			src.updatePig()

	if(reflectneed >= 750)
		add_event("reflect", /datum/happiness_event/reflect)
		src.verbs += /mob/living/carbon/human/proc/reflectexperience
		if(sleeping) return
		if(prob(1))
			to_chat(src, "<br><span class='graytextbold'>⠀+ Мне нужно обдумать пережитое. +</span><br>")