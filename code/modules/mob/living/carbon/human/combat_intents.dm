/mob/living/carbon/human/proc/do_combat_intent(var/which)
	if(which)
		if(next_move >= world.time)
			return

		if(stat == 1)
			return

		if(restrained())
			return

		if(!canmove)
			return

		meanwhile_combat_intent = which
		do_after_intent(which)

/mob/living/carbon/human/proc/do_after_intent(var/which)
	if(which)
		switch(which)
			if(I_DEFEND)
				next_move = world.time + 10
				visible_message("<span class='hitbold'>[src]</span> <span class='hit'>prepares to defend!</span>")
				meanwhile_combat_intent = which
				ticks_to_reset = 6
				adjustStaminaLoss(4)
			if(I_GUARD)
				next_move = world.time + 10
				visible_message("<span class='hitbold'>[src]</span> <span class='hit'>prepares to guard!</span>")
				adjustStaminaLoss(6)


/mob/living/carbon/human/proc/do_combat_rmb(var/mob/living/carbon/human/H)
	if(H.next_move >= world.time)
		return

	if(H.stat == 1)
		return

	if(H.restrained())
		return

	if(!H.canmove)
		return
	switch(H.combat_intent)
		if(I_DUAL)
			if(istype(H.get_inactive_hand(), /obj/item))
				var/obj/item/I = H.get_inactive_hand()
				I.attack(src,H)
			else
				return
			H.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
			H.adjustStaminaLoss(4)
		if(I_FURY)
			if(istype(H.get_active_hand(), /obj/item))
				var/obj/item/I = H.get_active_hand()
				I.attack(src,H)
				I.next_attack_time = 0
				sleep (3)
				I.attack(src,H)
			else
				return
			H.setClickCooldown(DEFAULT_QUICK_COOLDOWN)
			adjustStaminaLoss(10)
		if(I_WEAK)
			if(istype(H.get_active_hand(), /obj/item))
				var/obj/item/I = H.get_active_hand()
				I.attack(src,H)
			else
				return
			H.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
			adjustStaminaLoss(4)
		if(I_AIMED)
			if(istype(H.get_active_hand(), /obj/item))
				var/obj/item/I = H.get_active_hand()
				I.attack(src,H)
			else
				return
			H.setClickCooldown(DEFAULT_SLOW_COOLDOWN)
			adjustStaminaLoss(4)
		if(I_STRONG)
			if(istype(H.get_active_hand(), /obj/item))
				var/obj/item/I = H.get_active_hand()
				I.attack(src,H)
			else
				return
			H.setClickCooldown(DEFAULT_SLOW_COOLDOWN)
			adjustStaminaLoss(8)
		if(I_FEINT)
			if(istype(H.get_active_hand(), /obj/item))
				if (src.combat_intent == I_DEFEND && src.combat_mode == 1)
					visible_message("<span class='hitbold'>[H]</span> <span class='hit'>makes a successful feint!</span>")
					visible_message("<span class='hitbold'>[src]</span> <span class='hit'>lost his balance and fell!</span>")
					src.resting = 1
					to_chat(H, "HA-HA!")
					to_chat(src, "I was fooled! Damn!")
				if (src.combat_intent == I_DEFEND && src.combat_mode == 0)
					visible_message("<span class='hitbold'>[H]</span> <span class='hit'>makes an unsuccessful feint!</span>")
					visible_message("<span class='hitbold'>[H]</span> <span class='hit'>lost his balance and fell!</span>")
					H.resting = 1
					to_chat(H, "NOO!")
					to_chat(src, "I knew this could happen!")
				if ((src.combat_intent != I_DEFEND))
					visible_message("<span class='hitbold'>[H]</span> <span class='hit'>trying to make a feint!</span>")
					visible_message("<span class='hitbold'>[src]</span> <span class='hit'>looks suspiciously at [H]!</span>")
					to_chat(H, "It was close!")
					to_chat(src, "He almost hit me!")
				else
					return

			else
				return
			H.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
			adjustStaminaLoss(4)


/mob/living/carbon/human/Life()
	..()
	if(ticks_to_reset != 0)
		ticks_to_reset--
		if(prob(45))
			to_chat(src, "I'm ready for combat!")
	else if(ticks_to_reset == 0 && meanwhile_combat_intent != "null")
		to_chat(src, "I relax my stance.")
		meanwhile_combat_intent = "null"