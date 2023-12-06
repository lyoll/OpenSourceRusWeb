

/mob/verb/ZEPRETACO()
	winset( src.client, "mapwindow.map", "zoom-mode=normal" )

/mob/verb/ZEPRETOLA()
	winset( src.client, "mapwindow.map", "zoom-mode=distort" )

/mob/verb/ZEPRETALE()
	winset( src.client, "mapwindow.map", "zoom-mode=blur" )

/mob/living/carbon/human/examine(mob/user)
	set src in view()
	if(!usr || !src)	return
	if(!isobserver(usr))
		if( usr.sdisabilities & BLIND || usr.blinded || usr.stat==UNCONSCIOUS )
			to_chat(usr, "<span class='passivebold'>Там что-то есть, но вы этого не видите.</span>")
			return

		var/skipgloves = 0
		var/skipjumpsuit = 0
		var/skipshoes = 0
		var/skipmask = 0
		var/skipears = 0
		var/skipeyes = 0
		var/skipface = 0
		var/list/ExamineList = list()
		if(ishuman(usr))
			usr.visible_message("<span class='looksatbold'>[usr]</span> <span class='looksat'>looks at [src].</span>")
		//exosuits and helmets obscure our view and stuff.
		if(wear_suit)
			skipgloves = wear_suit.flags_inv & HIDEGLOVES
			//skipsuitstorage = wear_suit.flags_inv & HIDESUITSTORAGE
			skipjumpsuit = wear_suit.flags_inv & HIDEJUMPSUIT
			skipshoes = wear_suit.flags_inv & HIDESHOES

		if(head)
			skipmask = head.flags_inv & HIDEMASK
			skipeyes = head.flags_inv & HIDEEYES
			skipears = head.flags_inv & HIDEEARS
			skipface = head.flags_inv & HIDEFACE

		if(wear_mask)
			skipface |= wear_mask.flags_inv & HIDEFACE

		// crappy hacks because you can't do \his[src] etc. I'm sorry this proc is so unreadable, blame the text macros :<
		var/t_He = "Он" //capitalised for use at the start of each line.
		var/t_his = "его"
		var/t_him = "ему"
		var/t_has = "носит"
		var/t_is = ""
		var/t_chis = "Его"

		var/msg = "<div class='firstdivexamineplyr'><div class='boxexamineplyr'><span class='statustext'>Ох, это "

		if( skipjumpsuit && skipface || stealth || brothelstealth) //big suits/masks/helmets make it hard to tell their gender
			t_He = "Он"
			t_his = "его"
			t_him = "ему"
			t_has = "носит"
			t_is = ""
			t_chis = "Его"
		else
			switch(gender)
				if(MALE)
					t_He = "Он"
					t_his = "его"
					t_chis = "Его"
					t_him = "его"
				if(FEMALE)
					t_He = "Она"
					t_his = "её"
					t_chis = "Её"
					t_him = "её"

			if(has_penis() && (!wear_suit && is_nude()))
				t_He = "Он"
				t_his = "его"
				t_him = "ему"

		var/mob/living/carbon/human/M = usr
		var/mob/living/carbon/human/P = src
		if(stealth || brothelstealth)
			msg += "<span class='uppertext'>R a t</span>!\n"
		else
			msg += "<span class='uppertext'>[src.name]</span>!\n"

		var/datum/organ/internal/heart/HE = locate() in P.internal_organs
		if(HE)
			if(HE.stopped_working)
				msg += "\n<span class='hitbold'>[t_He] [t_is] сердечный приступ!</span>\n"
		if((ishuman(P) && ishuman(M)) && M.exam_wounds && P != M) // This should be its own proc once medical/combat becomes more advanced
			if(!istype(P, /mob/living/carbon/human/monster))
				msg += "<span class='statustext'>Состояние [t_his] тела:\n</span>"
				for(var/datum/organ/external/org in src.organs)
					var/list/status = list()

					if(org.has_finger)
						var/list/L = org.get_fucked_up()
						for(var/x in L)
							status += x

					if(org.status & ORGAN_DESTROYED)
						status += "<span class='missingnew'><big>ПОТЕРЯН</big></span>"
					if(org.status & ORGAN_MUTATED)
						status += "<span class='magentatext'>ДЕФОРМИРОВАН</span>"
					if(org.germ_level >= 1)
						status += "<span class='redtext'>ГНОЯЩИЙСЯ</span>"
					if(org.status & ORGAN_BLEEDING)
						status += "<span class='redtext'>КРОВОТЕЧЕНИЕ</span>"
					if(org.status & ORGAN_BROKEN)
						status += "<span class='redtext'>ПЕРЕЛОМ</span>"
					if(org.status & ORGAN_SPLINTED)
						status += "<span class='passivebold'>НАЛОЖЕНА ШИНА</span>"
						status -= "<span class='redtext'>ПЕРЕЛОМ</span>"
					if(org.status & ORGAN_DEAD)
						status += "<span class='redtext'>НЕКРОЗ</span>"
					if(org.status & ORGAN_ARTERY)
						status += "<span class='magentatext'>АРТЕРИАЛЬНОЕ КРОВОТЕЧЕНИЕ</span>"
					if(org.cripple_left > 0)
						status += "<span class='magentatext'>ПОКАЛЕЧЕНО</span>"
					if(org.status & ORGAN_TENDON)
						status += "<span class='magentatext'>СУХОЖИЛИЕ</span>"
					if(!org.is_usable())
						status += "<span class='missingnew'>НЕПРИГОДНЫЙ</span>"
					if(org.status & ORGAN_CUT_AWAY)
						status += "<span class='magentatext'>НЕ СОЕДИНЕННЫЙ</span>"
					if(istype(org, /datum/organ/external/head))
						var/datum/organ/external/head/HEADD = org
						if(HEADD.brained)
							status += "<span class='magentatext'>ТРЕЩИНА</span>"
					if(status.len)
						msg += "<span class='statustext'>¤ [capitalize(org.display_name)]: [english_listt(status)]</span>\n"
					else
						msg += "<span class='statustext'>¤ [capitalize(org.display_name)]: OK</span>\n"

				to_chat(usr, "[msg]</div></div>", 10)
				return

		if(istype(src, /mob/living/carbon/human/monster) && src.gender == MALE)
			msg += {"</span>[src.desc]\n<span class='bname'>Размер члена: [potenzia]см.</span></div></div>"}
			to_chat(usr, msg)
			return 1
		if(stealth || brothelstealth)
			msg += "<span class='uppertext'>Я не могу его узнать.</span>"
		else
			if(!isobserver(usr))
				if(job == "Bum" && !skipface && !stealth && !brothelstealth || istype(src, /mob/living/carbon/human/bumbot))
					msg += "<span class='statustext'>Я помню [decapitalize(t_him)] </span> <span class='uppertext'>БОМЖ.</span>"
				else
					if(job && !P.outsider && !skipface && !stealth && !brothelstealth || job == "Sheriff") // MUDAR CASO OP DEMAIS			else
						msg += "<span class='statustext'>Я помню [decapitalize(t_him)] как </span> <span class='uppertext'>[display_job()].</span>"
					else
						if(P.bandit && !skipface && !stealth && !brothelstealth)
							msg += "<span class='statustext'>Я помню [decapitalize(t_him)] как </span> <span class='uppertext'>bandit!</span>"
						else
							if(P.outsider && M.outsider && !skipface && !stealth && !brothelstealth)
								if(P.province != "Wanderer")
									if(M == P || P == M)
										msg += "<span class='statustext'>Я помню [decapitalize(t_him)] как </span> <span class='uppertext'>[display_job()].</span>"
									else
										if(M.province == P.province && !skipface && !stealth && !brothelstealth)
											msg += "<span class='statustext'>Я помню [decapitalize(t_him)] как </span> <span class='uppertext'>[display_job()].</span><span class='statustext'> [t_He] из </span><span class='uppertext'>[P.province],</span><span class='statustext'> как и я!</span>"
										else
											msg += "<span class='statustext'>Я помню [decapitalize(t_him)] как </span> <span class='uppertext'>[display_job()].</span><span class='statustext'> [t_He] из </span><span class='uppertext'>[P.province]</span>"
			else
				msg += "<span class='statustext'>Я помню [decapitalize(t_him)] как </span> <span class='uppertext'>[display_job()].</span>"
		if(ishuman(P))
			if(P.lip_style && !skipface && !stealth && !brothelstealth)
				msg += "\n<span class='bname'>Мхм, [t_his] губки такие сексуальные!</span>"
		if(excomunicated && !skipface && !stealth && !brothelstealth || src.seen_me_doing_heresy.Find(usr) && !skipface && !stealth && !brothelstealth)
			msg += "<span class='excommun'>[t_He] [t_is] ГРЯЗНЫЙ ЕРЕТИК!</span>"

		if(bandit && !skipface && !stealth && !brothelstealth)
			msg += "<br><span class='excommun'>[t_He] [t_is] БАНДИТ!</span>"

		if(master_mode == "holywar")
			if(ishuman(P) && ishuman(M))
				if(P.religion && M.religion)
					if(P.religion == M.religion)
						msg += "\n<span class='baronboldoutlined'>[t_He] [t_is] мой брат!</span>"
					else
						msg += "<br><span class='excommun'>[t_He] [t_is] ПРОТИВНИК!</span>"

		if(stealth || brothelstealth)
			msg += "<span class='uppertext'>\n[t_He] замаскирован.</span>"
		else

			//uniform
			/*if(w_uniform && !skipjumpsuit)
				//Ties
				var/tie_msg
				if(istype(w_uniform,/obj/item/clothing/under))
					var/obj/item/clothing/under/U = w_uniform
					if(U.hastie)
						tie_msg += " <span class='statustext'>with [icon2html(U.hastie, usr)] \a [U.hastie]</span>"

				if(w_uniform.blood_DNA)
					msg += "\n<span class='statustext'>[t_He] [t_is] wearing [icon2html(w_uniform, usr)] [w_uniform.gender==PLURAL?"some":"a"]</span> <span class='combatbold'>blood-stained</span> <span class='passiveglow'>[w_uniform.name][tie_msg]!</span>"
				else
					msg += "\n<span class='statustext'>[t_He] [t_is] wearing [icon2html(w_uniform, usr)] \a </span> <span class='passiveglow'>[w_uniform][tie_msg].</span>"
*/
			//head
			if(head)
				if(head.blood_DNA)
					msg += "\n<span class='combat'>[t_He] носит [icon2html(head, usr)] [head.gender==PLURAL?"some":"a"] blood-stained <span class='passiveglow'>[head.name]</span> <span class='combat'>на [t_his] голове.</span>"
				else
					msg += "\n<span class='statustext'>[t_He] носит [icon2html(head, usr)] \a </span> <span class='passiveglow'>[head]</span> <span class='statustext'>на [t_his] голове.</span>"

			//suit/armour
			if(wear_suit)
				if(wear_suit.blood_DNA)
					msg += "\n<span class='combat'>[t_He] имеет [icon2html(wear_suit, usr)] [wear_suit.gender==PLURAL?"some":"a"]</span> <span class='passiveglow'>[wear_suit.name]</span><span class='combat'>on (covered with blood)</span>"
				else
					msg += "\n<span class='statustext'>[t_He] имеет</span> [icon2html(wear_suit, usr)] <span class='statustext'> \a </span><span class='passiveglow'>[wear_suit]</span><span class='statustext'> on</span>"
			var/list/BELTSTORE = list()
			if(s_store)
				BELTSTORE.Add("[icon2html(s_store, usr)] </span><span class='passiveglow'>[s_store.name]</span>")
			if(belt)
				BELTSTORE.Add("[icon2html(belt, usr)] </span><span class='passiveglow'>[belt.name]</span>")
			if(BELTSTORE.len)
				msg += "\n<span class='statustext'>[t_He] имеет</span> [english_list(BELTSTORE)] on <span class='statustext'>[t_his] belt.</span>"
			//back
			if(back)
				ExamineList.Add("[icon2html(back, usr)] <span class='passiveglow'>[back.name]</span>")

			//left hand
			if(l_hand)
				if(l_hand.blood_DNA)
					msg += "\n<span class='combat'>[t_He] держит [icon2html(l_hand, usr)]</span> <span class='passiveglow'>[l_hand.name]</span> <span class='combat'>в [t_his] левой руке!</span>"
				else
					msg += "\n<span class='statustext'>[t_He] держит [icon2html(l_hand, usr)] \a </span><span class='passiveglow'>[l_hand]</span> <span class='statustext'>в [t_his] левой руке.</span>"

			//right hand
			if(r_hand)
				if(r_hand.blood_DNA)
					msg += "\n<span class='combat'>[t_He] держит [icon2html(r_hand, usr)]</span> <span class='passiveglow'>[r_hand.name]</span> <span class='combat'>в [t_his] правой руке! (covered with blood)</span>"
				else
					msg += "\n<span class='statustext'>[t_He] [t_is] держит [icon2html(r_hand, usr)] \a </span><span class='passiveglow'>[r_hand]</span> <span class='statustext'>в [t_his] правой руке.</span>"

			//gloves
			if(gloves && !skipgloves)
				ExamineList.Add("[icon2html(gloves, usr)] <span class='passiveglow'>[gloves.name]</span>")

			//handcuffed?

			//handcuffed?
			if(handcuffed)
				if(istype(handcuffed, /obj/item/weapon/handcuffs/cable))
					msg += "\n<span class='combat'>[t_He] [t_is] [icon2html(handcuffed, usr)] связанные руки!</span>"
				else
					msg += "\n<span class='combat'>[t_He] [t_is] [icon2html(handcuffed, usr)] связанные руки!</span>"

			//shoes
			if(shoes && !skipshoes)
				if(shoes.blood_DNA)
					msg += "\n<span class='statustext'>[t_He] [t_is] носит [icon2html(shoes, usr)] [shoes.gender==PLURAL?"some":"a"] запятнанные кровью</span> <span class='passiveglow'>[shoes.name]</span> <span class='statustext'>on [t_his] feets!</span> <span class='combat'>(covered in blood)</span>"
				else
					msg += "\n<span class='statustext'>[t_He] [t_is] носит [icon2html(shoes, usr)] \a </span><span class='passiveglow'>[shoes]</span> <span class='statustext'>on [t_his] feets."

			//mask
			if(wear_mask && !skipmask)
				if(wear_mask.blood_DNA)
					msg += "\n<span class='statustext'>[t_He] [t_has] [icon2html(wear_mask, usr)] [wear_mask.gender==PLURAL?"some":"a"] запятнанное кровью</span> <span class='passiveglow'>[wear_mask.name]</span> <span class='statustext'>on [t_his] лицо!</span> <span class='combat'>(covered in blood)</span>"
				else
					msg += "\n<span class='statustext'>[t_He] [t_has] [icon2html(wear_mask, usr)] \a </span><span class='passiveglow'>[wear_mask]</span> <span class='statustext'>на [t_his] лице.</span>"

			//eyes
			if(glasses && !skipeyes)
				ExamineList.Add("[icon2html(glasses, usr)] <span class='passiveglow'>[glasses.name]</span>")
			//left ear
			if(l_ear && !skipears)
				msg += "\n<span class='statustext'>[t_He] [t_has] [icon2html(l_ear, usr)] \a </span><span class='passiveglow'>[l_ear]</span> <span class='statustext'>on [t_his] left ear.</span>"

			//right ear
			if(r_ear && !skipears)
				msg += "\n<span class='statustext'>[t_He] [t_has] [icon2html(r_ear, usr)] \a </span><span class='passiveglow'>[r_ear]</span> <span class='statustext'>on [t_his] right ear.</span>"

			if(wrist_r)
				ExamineList.Add("[icon2html(wrist_r, usr)] <span class='passiveglow'>[wrist_r.name]</span>")
			if(wrist_l)
				ExamineList.Add("[icon2html(wrist_l, usr)] <span class='passiveglow'>[wrist_l.name]</span>")

			if(amulet)
				msg += "\n<span class='statustext'>[t_He] [t_has] [icon2html(amulet, usr)] \a </span><span class='passiveglow'>[amulet]</span> <span class='statustext'>on [t_his] neck.</span>"
			else
				if(vampirebit)
					msg += "\n<span class='itsatrap'>[t_his] neck has teeth marks!</span>"

			if(back2)
				ExamineList.Add("[icon2html(back2, usr)] <span class='passiveglow'>[back2.name]</span>")
			//ID
/*
			if(wear_id)
				/*var/id
				if(istype(wear_id, /obj/item/device/pda))
					var/obj/item/device/pda/pda = wear_id
					id = pda.owner
				else if(istype(wear_id, /obj/item/weapon/card/id)) //just in case something other than a PDA/ID card somehow gets in the ID slot :[
					var/obj/item/weapon/card/id/idcard = wear_id
					id = idcard.registered_name
				if(id && (id != real_name) && (get_dist(src, usr) <= 1) && prob(10))
					msg += "<span class='warning'>[t_He] [t_is] wearing \icon[wear_id] \a [wear_id] yet something doesn't seem right...</span>\n"
				else*/
				if(!gloves)
					msg += "\n<span class='statustext'>[t_He] [t_is] wearing [icon2html(wear_id, usr)] \a </span><span class='passiveglow'>[wear_id]</span><span class='statustext'>.</span>"
*/
		if(ExamineList.len)
			msg += "<p style='margin : 0; padding-top:0;font-size:13px;'>[t_He] носит [english_list(ExamineList)]</p>"
		if(!isobserver(usr))
			if(seen_heart_key && is_dreamer(usr))
				msg += "\n<span class='excommun'>Оно знает [seen_heart_key] ключ!</span>"

		if(!wear_mask)
			if(ExposedFang || (prob(50) && P.special == "youlooksick"))
				msg += "\n<span class='itsatrap'>У [t_He] большие, окровавленные клыки!</span>"

		if(!glasses)
			if(DeadEyes || (prob(50) && P.special == "youlooksick"))
				msg += "\n<span class='itsatrap'>[t_chis] глаза сияют, а зрачки у них белые!</span>"
/*
		if(DeadEyes && ExposedFang || (prob(80) && P.special == "youlooksick"))
			msg+= "\n<span class='itsatrap2'>Holy shit, IT IS a vampire!</span>"
*/
		if(!isobserver(usr))
			if(special == "merchunt" && ishuman(M))
				if(M.job && M.job == "Mercenary")
					msg += "\n<span class='excomm'>Это моя цель!</span>"

		if(P.species.name == "Midget")
			msg += "\n<span class='baronboldoutlined'>Ха-ха, карлик! Как отвратительно!</span>"
		if(!isobserver(usr))
			if(ishuman(P) && ishuman(M))
				if(P.religion && M.religion)
					if(P.religion == "Thanati" && M.religion == "Thanati")
						if(gender == FEMALE)
							msg += "\n<span class='baronboldoutlined'>Это моя сестра по вере. Слава Всевышнему!</span>"
						else
							msg += "\n<span class='baronboldoutlined'>Это мой брат по вере. Слава Всевышнему!</span>"

		if(!isobserver(usr))
			if(ishuman(P) && ishuman(M))
				for(var/datum/relation/family/R in M.mind.relations)
					if(R?.relation_holder?.current == src)
						msg += "\n<span class='baronboldoutlined'>Это моя [R.name]!</span>"

		if(!isobserver(usr))
			if(ishuman(P) && ishuman(M))
				if(P.special == "piercinggaze")
					if(M != P && P != M)
						M.rotate_plane()

		if(ishuman(P) && !stealth && !brothelstealth)
			if(ishuman(M))
				if((M.my_stats.it >= 8 && M.my_stats.pr >= 12) || M.my_skills.GET_SKILL(SKILL_OBSERV) >= 2)
					msg += "<p style='margin : 0; padding-top:0;font-size:12px;'><span class='moodboxtext'>[t_He] приблизительно ростом <b>[P.height] см</b>.</span></p>"
				if((M.my_stats.it >= 10 && M.my_stats.pr >= 14) || M.my_skills.GET_SKILL(SKILL_OBSERV) >= 3)
					if(P.combat_mode)
						msg += "<p style='margin : 0; padding-top:0;font-size:12px;'><span class='combatbold'>[t_He] is aware.</span></p>"
		if(!isobserver(usr) && !stealth && !brothelstealth)
			if(ishuman(M))
				var/totaldifference = null
				if(P.height > M.height)
					totaldifference = P.height - M.height
					if(totaldifference >= 6)
						msg += "<p style='margin : 0; padding-top:0;font-size:12px;'><small><span class='moodboxtext'>[t_He] выше меня.</span></small></p>"
					else
						msg += "<p style='margin : 0; padding-top:0;font-size:12px;'><small><span class='moodboxtext'>[t_He] немного выше меня.</span></small></p>"
				if(P.height == M.height)
					msg += "<p style='margin : 0; padding-top:0;font-size:12px;'><small><span class='moodboxtext'>[t_He] такого же размера, как я.</span></small></p>"
				if(P.height < M.height)
					totaldifference = M.height - P.height
					if(totaldifference >= 6)
						msg += "<p style='margin : 0; padding-top:0;font-size:12px;'><small><span class='moodboxtext'>[t_He] ниже меня ростом.</span></small></p>"
					else
						msg += "<p style='margin : 0; padding-top:0;font-size:12px;'><small><span class='moodboxtext'>[t_He] немного ниже меня ростом.</span></small></p>"
				if(P.eye_closed)
					msg += "<p style='margin : 0; padding-top:0;font-size:12px;'><small><span class='moodboxtext'>[t_chis] глаза закрыты.</span></small></p>"
		if(!isobserver(usr) && (ishuman(M)))
			if(M?.isVampire)
				var/blood_volume = round(P:vessel.get_reagent_amount("blood"))
				var/blood_percent =  blood_volume / 560
				blood_percent *= 100
				msg += "<p style='margin : 0; padding-top:0;font-size:15px;'><span class='excomm'>[blood_percent]% кровь, оставшаяся на [src]</span></p>"
/*
		//Jitters
		if(is_jittery)
			if(jitteriness >= 300)
				msg += "\n<span class='combat'>[t_He] [t_is] convulsing violently!</span>"
			else if(jitteriness >= 200)
				msg += "\n<span class='combat'>[t_He] [t_is] extremely jittery.</span>"
			else if(jitteriness >= 100)
				msg += "\n<span class='combat'>[t_He] [t_is] twitching ever so slightly.</span>"
*/
		//splints
		for(var/organ in list("l_leg","r_leg","l_arm","r_arm"))
			var/datum/organ/external/o = get_organ(organ)
			if(o && o.status & ORGAN_SPLINTED)
				msg += "\n<span class='combat'>[t_He] [t_has] a splint on [t_his] [o.display_name]!</span>"

		// if(suiciding)
		//	msg += "\n<span class='itsatrap'>[t_He] appears to have commited suicide... there is no hope of recovery.</span>"

		if(mSmallsize in mutations)
			msg += "\n[t_He] [t_is] small halfling!"

		var/distance = get_dist(usr,src)
		if(istype(usr, /mob/dead/observer) || usr.stat == 2) // ghosts can see anything
			distance = 1
		if (src.stat)
			msg += "\n<span class='passive'>[t_He] [t_is]n't не реагирует на то что происходит вокруг [t_him] и кажется спит.</span>"
			if((stat == 2 || src.death_door) && distance <= 3)
				msg += "\n<span class='horriblestate'>[t_He] похоже не дышит.</span>"
			if(istype(usr, /mob/living/carbon/human) && !usr.stat && distance <= 1)
				for(var/mob/O in viewers(usr.loc, null))
					O.show_message("<span class='passivebold'>[usr]</span> <span class='passive'>checks</span> <span class='passivebold'>[src]</span><span class='passive'>'s pulse.</span>", 1)
			spawn(15)
				if(!usr)	return

				if(distance <= 1 && usr.stat != 1)
					if(pulse == PULSE_NONE)
						usr << "<span class='horriblestate'>[t_He] нет пульса[src.client ? "" : " и [t_his] душа покинута"]...</span>"
					else
						usr << "<span class='passiveglow'>[t_He] нет пульса!</span>"

		msg += "<span class='warning'>"


		msg += "</span>"

		if(stat == UNCONSCIOUS)
			msg += "\n<span class='passiveglow'>[t_He] без сознания.</span>"
		/* else if(getBrainLoss() >= 60)
			msg += "\n[t_He] [t_has] a stupid expression on [t_his] face." */

		if((has_brain()) && stat != DEAD)
			if(!key)
				msg += "\n<span class='cavedoze'>Жёлтая слюна капает из [t_his] рта, возможно, пещерная болезнь?</span>"
			else if(!client)
				msg += "\n<span class='cavedoze'>Жёлтая слюна капает из [t_his] рта, возможно, пещерная болезнь?</span>"

		var/list/wound_flavor_text = list()
		var/list/is_destroyed = list()
		var/list/is_bleeding = list()
		for(var/datum/organ/external/temp in organs)
			if(temp)
				if(temp.status & ORGAN_DESTROYED)
					is_destroyed["[temp.display_name]"] = 1
					wound_flavor_text["[temp.display_name]"] = "\n<span class='magentasmall'>[t_He] пропала [t_his] [temp.display_name].</span>"
					continue
				if(temp.status & ORGAN_ROBOT)
					if(!(temp.brute_dam + temp.burn_dam))
						wound_flavor_text["[temp.display_name]"] = "\n<span class='magentasmall'>[t_He] робот [temp.display_name]!</span>"
						continue
					else
						wound_flavor_text["[temp.display_name]"] = "<span class='magentasmall'>[t_He] робот [temp.display_name], it has"
					if(temp.brute_dam) switch(temp.brute_dam)
						if(0 to 20)
							wound_flavor_text["[temp.display_name]"] += " несколько синяков"
						if(21 to INFINITY)
							wound_flavor_text["[temp.display_name]"] += pick(" много синяков"," серьёзное повреждение тканей")
					if(temp.brute_dam && temp.burn_dam)
						wound_flavor_text["[temp.display_name]"] += " и"
					if(temp.burn_dam) switch(temp.burn_dam)
						if(0 to 20)
							wound_flavor_text["[temp.display_name]"] += " несколько ожогов"
						if(21 to INFINITY)
							wound_flavor_text["[temp.display_name]"] += pick(" много ожогов"," серьёзное ожоговое повреждение")
					wound_flavor_text["[temp.display_name]"] += "\n!</span>"
				else if(temp.wounds.len > 0)
					var/list/wound_descriptors = list()
					for(var/datum/wound/W in temp.wounds)
						if(W.internal && !temp.open) continue // can't see internal wounds
						var/this_wound_desc = W.desc
						if(W.bleeding()) this_wound_desc = "кровоточит [this_wound_desc]"
						else if(W.bandaged) this_wound_desc = "забинтованный [this_wound_desc]"
						if(W.germ_level > 250) this_wound_desc = "плохо[pick("воняющий", "пахнущий")] [this_wound_desc]"
						else if(W.germ_level > 50) this_wound_desc = "слегка поражённый [this_wound_desc]"
						if(this_wound_desc in wound_descriptors)
							wound_descriptors[this_wound_desc] += W.amount
							continue
						wound_descriptors[this_wound_desc] = W.amount
					if(wound_descriptors.len)
						var/list/flavor_text = list()
						var/list/no_exclude = list("зияющая рана", "большая зияющая рана", "обширная рана", "большой синяк",\
						"огромный синяк", "огромные синяки", "сильный ожог", "большой ожог", "глубокий ожог", "обугленная зона")
						for(var/wound in wound_descriptors)
							switch(wound_descriptors[wound])
								if(1)
									if(!flavor_text.len)
										flavor_text += "<span class='magentasmall'>[t_He] has[prob(10) && !(wound in no_exclude)  ? " what might be" : ""] a [wound]"
									else
										flavor_text += "[prob(10) && !(wound in no_exclude) ? " what might be" : ""] a [wound]"
								if(2)
									if(!flavor_text.len)
										flavor_text += "<span class='magentasmall'>[t_He] has[prob(10) && !(wound in no_exclude) ? " what might be" : ""] a pair of [wound]s"
									else
										flavor_text += "[prob(10) && !(wound in no_exclude) ? " what might be" : ""] a pair of [wound]s"
								if(3 to 5)
									if(!flavor_text.len)
										flavor_text += "<span class='magentasmall'>[t_He] has several [wound]s"
									else
										flavor_text += " several [wound]s"
								if(6 to INFINITY)
									if(!flavor_text.len)
										flavor_text += "<span class='magentasmall'>[t_He] has a bunch of [wound]s"
									else
										flavor_text += " a ton of [wound]\s"
						var/flavor_text_string = "\n"
						for(var/text = 1, text <= flavor_text.len, text++)
							if(text == flavor_text.len && flavor_text.len > 1)
								flavor_text_string += ", and"
							else if(flavor_text.len > 1 && text > 1)
								flavor_text_string += ","
							flavor_text_string += flavor_text[text]
						flavor_text_string += " on [t_his] [temp.display_name].</span>"
						wound_flavor_text["[temp.display_name]"] = flavor_text_string
					else
						wound_flavor_text["[temp.display_name]"] = ""
					if(temp.status & ORGAN_BLEEDING)
						is_bleeding["[temp.display_name]"] = 1
				else
					wound_flavor_text["[temp.display_name]"] = ""

		//Handles the text strings being added to the actual description.
		//If they have something that covers the limb, and it is not missing, put flavortext.  If it is covered but bleeding, add other flavortext.
		var/display_chest = 0
		var/display_shoes = 0
		var/display_gloves = 0
		if(is_bleeding["right foot"])
			display_shoes = 1
		if(display_chest)
			msg += "\n<span class='combatglow'><b>[src] из-под одежды [t_his] сочится кровь!</b></span>"
		if(display_shoes)
			msg += "\n<span class='combatglow'><b>[src] из-под ботинок [t_his] сочится кровь!</b></span>"
		if(display_gloves)
			msg += "\n<span class='combatglow'><b>[src] из-под перчаток [t_his] сочится кровь!</b></span>"
		for(var/implant in get_visible_implants(1))
			msg += "\n<span class='combatglow'><b>[src] has \a [implant] торчащие из их плоти!</span>"
		if(digitalcamo)
			msg += "\n<span class='combatglow'>[t_He] [t_is] отталкивающе жуткий!</span>"

		var/datum/organ/external/mouth/O = locate() in organs

		if(O && O.get_teeth() < O.max_teeth)
			msg += "\n<span class='combatglow'><B>[O.get_teeth() <= 0 ? "All" : "[O.max_teeth - O.get_teeth()]"] of [t_his] зубов не хватает!</B></span>"

		if(is_nude() && (potenzia > -1) && species.genitals)//Interactions
			if(!wear_suit)
				if(gender == FEMALE && (futa || isFemboy()))
					msg += "\n<span class='bname'>Размер члена: [potenzia]см.</span>"
				else if(gender == MALE)
					msg += "\n<span class='bname'>Размер члена: [potenzia]см.</span>"

		if(is_nude() && gender == FEMALE && species.genitals && futa == FALSE)
			if(virgin)
				msg += "\n<span class='erp'>Их вишня цела!</span>\n"

		if(is_nude() && mutilated_genitals)
			msg += "\n<span class='combatglow'><b>ИХ ПАХ РАЗРУШЕН!</b></span>\n"

		if(right_eye_fucked && !left_eye_fucked && !istype(src.glasses, /obj/item/clothing/glasses/Reyepatch))
			msg += "\n<span class='combatglow'><b>Его правый глаз уничтожен!</b></span>\n"
		else if(!right_eye_fucked && left_eye_fucked && !istype(src.glasses, /obj/item/clothing/glasses/Leyepatch))
			msg += "\n<span class='combatglow'><b>Его левый глаз уничтожен!</b></span>\n"
		else if(right_eye_fucked && left_eye_fucked)
			msg += "\n<span class='combatglow'><b>Его глаза уничтожены!</b></span>\n"

		if(reagents.has_reagent("cocaine"))
			msg += "\n<span class='combatglow'><b>Его глаза уничтожены!</b></span>\n"

		if(pale)
			msg += "\n<span class='combatglow'><b>Они выглядят бледными.</b></span>\n"

		if(happiness <= MOOD_LEVEL_SAD2)
			msg += "\n<span class='statustext'>[t_He] выглядит грустным.</span>"

		if(decaylevel == 1)
			msg += "\n<span class='combat'>[t_He] [t_is] начинает вонять.</span>"
		if(decaylevel == 2)
			msg += "\n<span class='combat'>[t_He] [t_is] раздутый и отвратительно пахнущий.</span>"
		if(decaylevel == 3)
			msg += "\n<span class='combat'>[t_He] [t_is] гниющий и почерневший, кожа отслаивается. Запах неописуемо отвратительный.</span>"
		if(decaylevel == 4)
			msg += "\n<span class='combat'>[t_He] [t_is] сейчас они в основном высохли, и от того, что когда-то было человеком, остались только кости.</span>"

		if(print_flavor_text())
			msg += "\n[print_flavor_text()]"
		if(ishuman(M) && ishuman(P))
			var/Pmystatsst = P.my_stats.st
			var/Mmystatsst = M.my_stats.st

			if(is_dreamer(usr))
				Mmystatsst = initial(M.my_stats.initst)

			if(!isobserver(usr) && !stealth && !brothelstealth)
				if(Pmystatsst > Mmystatsst && Pmystatsst < (Mmystatsst + 5))
					msg += "<span class='combat'>[t_He] выглядит сильнее тебя.</span>"

				if(Pmystatsst > (Mmystatsst + 5))
					msg += "<span class='combatglow'><b>[t_He] выглядит намного сильнее тебя.</b></span>"

				if(Pmystatsst == Mmystatsst)
					msg += "<span class='combat'>[t_He] выглядит таким же сильным, как и ты.</span>"

				if(Pmystatsst < Mmystatsst)
					msg += "<span class='passiveglow'>[t_He] выглядит слабее тебя.</span>"

		msg += "\n</span>"
		if (pose)
			if( findtext(pose,".",length(pose)) == 0 && findtext(pose,"!",length(pose)) == 0 && findtext(pose,"?",length(pose)) == 0 )
				pose = addtext(pose,".") //Makes sure all emotes end with a period.
			msg += "\n[t_He] is [pose]"
		if(distance <= 1 && ishuman(src))
			msg += "<hr class='linexd'>"
			var/datum/organ/external/head/H = get_organ("head")
			var/datum/organ/external/head/THR = get_organ("throat")
			if(H && H.brained)
				msg += "\n<span class='magentasmall'><b>[src]</b>'s череп раздроблен, и мозг находится на открытом воздухе!</span>"
			if(THR && THR.hasVocal && THR.VocalTorn)
				msg += "\n<span class='magentasmall'><b>[src]</b>'s голосовые связки повреждены!</span>"
			if(wound_flavor_text["head"] && (is_destroyed["head"] || (!skipmask && !(wear_mask && istype(wear_mask, /obj/item/clothing/mask/gas)))))
				msg += wound_flavor_text["head"]
			else if(is_bleeding["head"])
				msg += "\n<span class='magentasmall'>[src] голова кровоточит!</span>"
			if(wound_flavor_text["chest"] && !w_uniform && !skipjumpsuit) //No need.  A missing chest gibs you.
				msg += wound_flavor_text["chest"]
			else if(is_bleeding["chest"])
				display_chest = 1
			if(wound_flavor_text["left arm"] && (is_destroyed["left arm"] || (!w_uniform && !skipjumpsuit)))
				msg += wound_flavor_text["left arm"]
			else if(is_bleeding["left arm"])
				display_chest = 1
			if(wound_flavor_text["left hand"] && (is_destroyed["left hand"] || (!gloves && !skipgloves)))
				msg += wound_flavor_text["left hand"]
			else if(is_bleeding["left hand"])
				display_gloves = 1
			if(wound_flavor_text["right arm"] && (is_destroyed["right arm"] || (!w_uniform && !skipjumpsuit)))
				msg += wound_flavor_text["right arm"]
			else if(is_bleeding["right arm"])
				display_chest = 1
			if(wound_flavor_text["right hand"] && (is_destroyed["right hand"] || (!gloves && !skipgloves)))
				msg += wound_flavor_text["right hand"]
			else if(is_bleeding["right hand"])
				display_gloves = 1
			if(wound_flavor_text["groin"] && (is_destroyed["groin"] || (!w_uniform && !skipjumpsuit)))
				msg += wound_flavor_text["groin"]
			else if(is_bleeding["groin"])
				display_chest = 1
			if(wound_flavor_text["left leg"] && (is_destroyed["left leg"] || (!w_uniform && !skipjumpsuit)))
				msg += wound_flavor_text["left leg"]
			else if(is_bleeding["left leg"])
				display_chest = 1
			if(wound_flavor_text["left foot"]&& (is_destroyed["left foot"] || (!shoes && !skipshoes)))
				msg += wound_flavor_text["left foot"]
			else if(is_bleeding["left foot"])
				display_shoes = 1
			if(wound_flavor_text["right leg"] && (is_destroyed["right leg"] || (!w_uniform && !skipjumpsuit)))
				msg += wound_flavor_text["right leg"]
			else if(is_bleeding["right leg"])
				display_chest = 1
			if(wound_flavor_text["right foot"]&& (is_destroyed["right foot"] || (!shoes  && !skipshoes)))
				msg += wound_flavor_text["right foot"]
		to_chat(usr, "[msg]</div></div>")
