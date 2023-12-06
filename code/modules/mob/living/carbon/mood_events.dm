/datum/happiness_event
	var/description
	var/happiness = 0
	var/timeout = 0

///For descriptions, use the span classes bold info, info, none, warning and boldwarning in order from great to horrible.

/datum/happiness_event/noble_blood
	description = "<span class='goodmood'>• <span class='passivebold'>В моих жилах течет благородная кровь!</span>\n"
	happiness = 2

//nutrition
/datum/happiness_event/nutrition/fat
	description = "<span class='badmood'>• Во мне много жира.</span>\n" //muh fatshaming <---- QUEM FEZ ESSE COMMENT É UM GORDO DE MERDA <--- esse cara ta falando a verdade
	happiness = -4

/datum/happiness_event/nutrition/goodfood
	description = "<span class='goodmood'>•</span> <span class='passivebold'>Недавно я отведал хорошее блюдо!</span>\n"
	happiness = 3
	timeout = 1800

/datum/happiness_event/nutrition/wellfed
	description = "<span class='goodmood'>•</span> <span class='passivebold'>Я сыт по горло. Это приятное чувство.</span>\n"
	happiness = 4

/datum/happiness_event/nutrition/fed
	description = "<span class='goodmood'>•</span> <span class='passivebold'>Недавно я немного поел.</span>\n"
	happiness = 2

/datum/happiness_event/nutrition/bithungry
	description = "<span class='badmood'>• Я что-то немного проголодался.</span>\n"
	happiness = -2

/datum/happiness_event/nutrition/hungry
	description = "<span class='badmood'>• Я голоден.</span>\n"
	happiness = -4

/datum/happiness_event/nutrition/starving
	description = "<span class='badmood'>• Я умираю с голоду!</span>\n"
	happiness = -12

/datum/happiness_event/nutrition/humanflesh
	description = "<span class='badmood'>• Я ел человеческую плоть!</span>\n"
	happiness = -4
	timeout = 3000

/datum/happiness_event/nutrition/badtaste
	description = "<span class='badmood'>• На вкус это как дерьмо!</span>\n"
	happiness = -1
	timeout = 1800


//Hygiene
/datum/happiness_event/hygiene/clean
	description = "<span class='goodmood'>•</span> <span class='passivebold'>Я чувствую себя такой чистой!</span>\n"
	happiness = 2

/datum/happiness_event/hygiene/smelly
	description = "<span class='ifeelsick'>• От меня дерьмово пахнет.</span>\n"
	happiness = -5

/datum/happiness_event/hygiene/vomitted
	description = "<span class='ifeelsick'>• Фу, меня вырвало.</span>\n"
	happiness = -5
	timeout = 1800


/datum/happiness_event/misc/tired
	description = "<span class='badmood'><b>• Мне нужно немного поспать.</span></b>\n"
	happiness = -20

/datum/happiness_event/misc/weed
	description = "<span class='goodmood'>•</span> <span class='passivebold'>Это хорошая травка.</span>\n"
	happiness = 15

/datum/happiness_event/misc/better
	description = "<span class='goodmood'>•</span> <span class='passivebold'>Чувствую себя лучше.</span>\n"
	happiness = 15
	timeout = 9000

/datum/happiness_event/misc/argh
	description = "<span class='goodmood'>•</span> <span class='passivebold'>А-х.</span>\n"
	happiness = 15
	timeout = 9000

/datum/happiness_event/misc/woo
	description = "<span class='goodmood'>•</span> <span class='passivebold'>ВУУ!</span>\n"
	happiness = 15
	timeout = 9000

/datum/happiness_event/misc/jestbad
	description = "<span class='badmood'><b>• Пошел ты, гребаный шут Копетти.</span></b>\n"
	happiness = -20

/datum/happiness_event/misc/jestgood
	description = "<span class='goodmood'>•</span> <span class='passivebold'>Это мило. Слава богу, он не взорвался!</span>\n"
	happiness = 15


/datum/happiness_event/misc/iwanttodie
	description = "<span class='badmood'><b>• Я хочу умереть.</span></b>\n"
	happiness = -1
	timeout = 600

/datum/happiness_event/misc/lost
	description = "<span class='badmood'>• Я проиграл!</span>\n"
	happiness = -2
	timeout = 3000

/datum/happiness_event/misc/realcup
	description = "<span class='badmood'><b>• Мне нужен мой кубок.</span></b>\n"
	happiness = -1
	timeout = 600

/datum/happiness_event/misc/spoon
	description = "<span class='badmood'><b>• Я... НЕНАВИЖУ есть столовыми приборами смердов.</span></b>\n"
	happiness = -1
	timeout = 600

/datum/happiness_event/misc/ravenheart
	description = "<span class='badmood'><b>• Я буду скучать по Вороньему сердцу.</span></b>\n"
	happiness = -2
	timeout = 4000


/datum/happiness_event/misc/ivefailed
	description = "<span class='badmood'><b>• Я потерпел неудачу.</span></b>\n"
	happiness = -2
	timeout = 300

//Disgust
/datum/happiness_event/disgust/gross
	description = "<span class='ifeelsick'>• Это было отвратительно.</span>\n"
	happiness = -2
	timeout = 1800

/datum/happiness_event/disgust/verygross
	description = "<span class='ifeelsick'>• Кажется, меня сейчас стошнит...</span>\n"
	happiness = -4
	timeout = 1800

/datum/happiness_event/disgust/disgusted
	description = "<span class='ifeelsick'>• О боже, это отвратительно...</span>\n"
	happiness = -6
	timeout = 1800

/datum/happiness_event/disgust/terriblethings
	description = "<span class='badmood'>• Я видел ужасные вещи.</span>\n"
	happiness = -4
	timeout = 1800

/datum/happiness_event/disgust/death
	description = "<span class='badmood'>• Я видел, как кто-то умер!</span>\n"
	happiness = -8
	timeout = 2400

//Generic events
/datum/happiness_event/favorite_food
	description = "<span class='goodmood'>•</span> <span class='passivebold'>Мне действительно понравилось это есть.</span>\n"
	happiness = 3
	timeout = 2400

/datum/happiness_event/nice_shower
	description = "<span class='goodmood'>•</span> <span class='passivebold'>У меня был приятный душ.</span>\n"
	happiness = 1
	timeout = 1800

/datum/happiness_event/handcuffed
	description = "<span class='badmood'>• Думаю, мои выходки наконец-то настигли меня..</span>\n"
	happiness = -1

/datum/happiness_event/booze
	description = "<span class='goodmood'>•</span> <span class='passivebold'>Алкоголь делает вселенную светлее.</span>\n"
	happiness = 3
	timeout = 2400

/datum/happiness_event/relaxed//For nicotine.
	description = "<span class='goodmood'>•</span> <span class='passivebold'>Я чувствую себя расслабленным.</span>\n"
	happiness = 1
	timeout = 1800

/datum/happiness_event/blessed
	description = "<span class='goodmood'>•</span> <span class='passivebold'>Я благословлен!</span>\n"
	happiness = 2
	timeout = 65000

/datum/happiness_event/badblessed
	description = "<span class='badmood'>• Я был осквернен Библией!</span>\n"
	happiness = -6
	timeout = 800

/datum/happiness_event/martyr
	description = "<span class='goodmood'>•</span> <span class='passivebold'>Я божий мученик!</span>\n"
	happiness = 6
	timeout = 800

/datum/happiness_event/mentallytired
	description = "<span class='badmood'>• Я чувствую душевную усталость! Я должен поспать.</span>\n"
	happiness = -4
	timeout = INFINITY

//Embarassment
/datum/happiness_event/hygiene/shit
	description = "<span class='ifeelsick'>• Я обосрался. Как неловко.</span>\n"
	happiness = -12
	timeout = 1800

/datum/happiness_event/hygiene/pee
	description = "<span class='ifeelsick'>• Я обоссался. Как неловко.</span>\n"
	happiness = -12
	timeout = 1800

/datum/happiness_event/badsex
	description = "<span class='badmood'>• Фу, этот секс был ужасен.</span>\n"
	happiness = -4
	timeout = 1800

/datum/happiness_event/learningfail
	description = "<span class='badmood'>• Я ничему не смогла научиться, я чувствую себя такой глупой!</span>\n"
	happiness = -4
	timeout = 300

/datum/happiness_event/damned
	description = "<span class='badmood'>• Я был проклят на всю свою жизнь!</span>\n"
	happiness = -8
	timeout = 1900

/datum/happiness_event/excom
	description = "<span class='badmood'>• Я был отлучен от церкви, я никогда не найду спасения!</span>\n"
	happiness = -12
	timeout = INFINITY

/datum/happiness_event/excomthanati
	description = "<span class='goodmood'>•</span> <span class='passivebold'>Я был отлучен от церкви, спасибо тебе, Чернобог!</span>\n"
	happiness = 4
	timeout = INFINITY

/datum/happiness_event/excomothers
	description = "<span class='badmood'>• Я должен убить отлученного от церкви!</span>\n" //replaced with their name at runtime.
	happiness = -1
	timeout = INFINITY

/datum/happiness_event/excomdead
	description = "<span class='goodmood'>•</span> <span class='passivebold'> Еретик мертв, <B>Да будет спасен Бог!</B></span>\n"
	happiness = 4
	timeout = 1800

/datum/happiness_event/thanati
	description = "<span class='goodmood'>•</span> <span class='passivebold'> Еще один умирает! <B>Хвала Всевышнему!</B></span>\n"
	happiness = 4
	timeout = 1800


/datum/happiness_event/imposter
	description = "<span class='goodmood'>•</span> <span class='passivebold'> Приятно быть предателем!</span>\n"
	happiness = 4
	timeout = INFINITY

/datum/happiness_event/imposterbad
	description = "<span class='badmood'>• Нас предали!</span>\n"
	happiness = -4
	timeout = INFINITY

/datum/happiness_event/whipchurch
	description = "<span class='goodmood'>•</span> <span class='passivebold'>Бог улыбается мне.</span>\n"
	happiness = 4
	timeout = INFINITY

/datum/happiness_event/gmyza
	description = "<span class='badmood'>•Эй, я не гмыза!</span>\n"
	happiness = -1
	timeout = 800

/datum/happiness_event/copetti
	description = "<span class='badmood'>•Эй, я не копетти!</span>\n"
	happiness = -4
	timeout = 800

/datum/happiness_event/hug
	description = "<span class='goodmood'>•</span> <span class='passivebold'>Меня крепко обняли!</span>\n"
	happiness = 2
	timeout = 600

/datum/happiness_event/respect
	description = "<span class='goodmood'>•</span> <span class='passivebold'>Смерды оказывают мне то уважение, которого я заслуживаю!</span>\n"
	happiness = 2
	timeout = 600

//Good sex here too because why not.
/datum/happiness_event/goodsex
	description = "<span class='goodmood'>•</span> <span class='passivebold'>Этот секс был действительно хорош!\n"
	happiness = 4
	timeout = 1800

/datum/happiness_event/regurgipleasure
	description = "<span class='goodmood'>•</span> <span class='passivebold'>Это было действительно приятно!\n"
	happiness = 4

/datum/happiness_event/magazinepleasure
	description = "<span class='goodmood'>•</span> <span class='passivebold'>Это было действительно приятно!\n"
	happiness = 4
	timeout = 1800

//Unused so far but I want to remember them to use them later.
/datum/happiness_event/disturbing
	description = "● Недавно я увидел нечто тревожное</span>\n"
	happiness = -2

/datum/happiness_event/clown
	description = "● Недавно я видел забавного клоуна!</span>\n"
	happiness = 1

/datum/happiness_event/cloned_corpse
	description = "● Недавно я видел свой собственный труп...</span>\n"
	happiness = -6

/datum/happiness_event/surgery
	description = "<span class='badmood'>• ОН ВСКРЫВАЕТ МЕНЯ!!</span>\n"
	happiness = -8

//MISC

/datum/happiness_event/misc/sheriff
	description = "<span class='badmood'>• Я ненавижу эту крепость! Я не могу дождаться, когда выберусь отсюда.</span>\n"
	happiness = -12

/datum/happiness_event/misc/barondead
	description = "<span class='badmood'>• Наш барон мертв, что будет дальше?!</span>\n"
	happiness = -3

/datum/happiness_event/misc/shattereddreams
	description = "<span class='badmood'>• Бедный Морган Джеймс!</span>\n"
	happiness = -7

/datum/happiness_event/misc/lorddead
	description = "<span class='badmood'>• Наш господь мертв, что будет дальше?!</span>\n"
	happiness = -7

/datum/happiness_event/misc/coronated
	description = "<span class='goodmood'>•</span> <span class='passivebold'>Я был коронован.</span>\n"
	happiness = 12

/datum/happiness_event/misc/pregnantgood
	description = "<span class='goodmood'>•</span> <span class='passivebold'>Вероятно, я беременна!</span>\n"
	happiness = 5

/datum/happiness_event/misc/sheekos
	description = "<span class='goodmood'>•</span> <span class='passivebold'>Шикарно!</span>\n"
	happiness = 5

/datum/happiness_event/misc/godsave
	description = "<span class='goodmood'>•</span> <span class='passivebold'>Бог спасет меня.</span>\n"
	happiness = 5

/datum/happiness_event/misc/donate
	description = "<span class='goodmood'>•</span> <span class='passivebold'>Я помогаю господу.</span>\n"
	happiness = 5

/datum/happiness_event/misc/pregnantbad
	description = "<span class='badmood'>• Я, наверное, беременна, о нет!</span>\n"
	happiness = -5

/datum/happiness_event/misc/needsex
	description = "<span class='badmood'>• IНУЖНО КОГО-ТО ТРАХНУТЬ!</span>\n"
	happiness = -30


//VICE
/datum/happiness_event/reflect
	description = "<span class='badmood'>• Мне нужно обдумать пережитое.</span>\n"
	happiness = -3

/datum/happiness_event/vice/smoke
	description = "<span class='badmood'>• Мне нужно покурить.</span>\n"
	happiness = -15

/datum/happiness_event/vice/weed
	description = "<span class='badmood'>• Мне нужно немного травки..</span>\n"
	happiness = -15


/datum/happiness_event/vice/klepto
	description = "<span class='badmood'>• Мне нужно у кого-нибудь украсть.</span>\n"
	happiness = -15


/datum/happiness_event/vice/photo
	description = "<span class='badmood'>• Мне нужно кое-кого сфотографировать.</span>\n"
	happiness = -15

/datum/happiness_event/vice/kiss
	description = "<span class='badmood'>• Мне нужен чей-нибудь поцелуй.</span>\n"
	happiness = -15


/datum/happiness_event/vice/necro
	description = "<span class='badmood'>• Мне нужен кто-то более испорченный, чем я сам.</span>\n"
	happiness = -15

/datum/happiness_event/vice/pyromaniac
	description = "<span class='badmood'>• Мне нужно увидеть, как горит мир.</span>\n"
	happiness = -15

/datum/happiness_event/vice/sexo
	description = "<span class='badmood'>• Мне нужно кого-нибудь трахнуть.</span>\n"
	happiness = -15

/datum/happiness_event/vice/alco
	description = "<span class='badmood'>• Мне нужно выпить.</span>\n"
	happiness = -15

/datum/happiness_event/vice/ment
	description = "<span class='badmood'>• Мне нужны ментаты.</span>\n"
	happiness = -15

/datum/happiness_event/vice/buff
	description = "<span class='badmood'>• Мне нужен баффут.</span>\n"
	happiness = -15

/datum/happiness_event/vice/heroin
	description = "<span class='badmood'>• Мне нужно принять укол.</span>\n"
	happiness = -15

/datum/happiness_event/vice/stimulants
	description = "<span class='badmood'>• Мне нужны стимуляторы.</span>\n"
	happiness = -15

/datum/happiness_event/vice/maso
	description = "<span class='badmood'>• Мне нужно почувствовать боль.</span>\n"
	happiness = -15

/datum/happiness_event/vice/voyeur
	description = "<span class='badmood'>• Мне нужно увидеть, как кто-то это сделает.</span>\n"
	happiness = -15

/datum/happiness_event/wonder
	description = "<span class='badmood'>• Я видел нечто кошмарное. Я боюсь за свою жизнь.</span>\n"
	happiness = -18

//Song
/datum/happiness_event/song/perfect
	description = "<span class='goodmood'>•</span> <span class='passivebold'>Эта песня замечательна!</span>\n"
	happiness = 8
	timeout = 30 SECONDS

/datum/happiness_event/song/good
	description = "<span class='goodmood'>• Эта песня великолепна!</span>\n"
	happiness = 4
	timeout = 30 SECONDS

/datum/happiness_event/song/bad
	description = "<span class='badmood'>• Эта песня ужасна!</span>\n"
	happiness = -4
	timeout = 30 SECONDS

//Help me
/datum/happiness_event/want_punch
	description = "<span class='badmood'>• Я хочу ударить... кого?</span>\n"
	happiness = -4
	timeout = 600
	var/mob/living/carbon/human/pidor = null

/datum/happiness_event/epitemia
	description = "<span class='badmood'>• Мне нужно... сделать что?</span>\n"
	happiness = -6
	var/epitemia_type = null

/datum/happiness_event/flag
	description = "<span class='badmood'>• Флаг упал!</span>\n"
	happiness = -10

/mob/living/carbon/human/proc/add_epitemia(var/T)
	var/datum/happiness_event/epitemia/mood = new
	mood.epitemia_type = T
	mood.description = "<span class='badmood'>• Мне нужно [T] искупить свои грехи!</span>\n"
	var/category = "epitemia"
	if(events[category])
		clear_event(category)
	events[category] = mood

/mob/living/carbon/human/proc/want_punch(var/mob/living/carbon/human/who)
	var/datum/happiness_event/want_punch/mood = new
	mood.pidor = who
	mood.description = "<span class='badmood'>• Я хочу ударить [who.name]!</span>\n"
	var/category = "want_punch"
	if(events[category])
		clear_event(category)
	events[category] = mood
	spawn(mood.timeout)
		events -= category