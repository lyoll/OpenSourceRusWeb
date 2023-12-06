/////////////FATES/////////////
//SEASPOTTER MERC
var/global/list/seaspotter_merc = list()
//RED DAWN MERC
var/global/list/reddawn_merc = list()
//MERCENARY
var/global/list/mercenary_donor = list()
//URCHIN
var/global/list/urchin_donor = list()
//TRIBUNAL VET
var/global/list/tribunal_vet = list()
//LORD
var/global/list/lord = list()
//CRUSADER
var/global/list/crusader = list()
//TOPHAT
var/global/list/tophat = list()//list("Willkito")
//MONK
var/global/list/monk = list()
//FUTA
var/global/list/futa = list()
//30CM
var/global/list/mobilephone = list()
//TELEFONE
var/global/list/remigrator = list()
//REMIGRATION
var/global/list/thirtycm = list()
//TRAP APOC
var/global/list/trapapoc = list()
//OUTLAW
var/global/list/outlaw = list()
//ADULT SQUIRE
var/global/list/adultsquire = list()
//ITEMS
var/global/list/waterbottledonation = list()
var/global/list/luxurydonation = list()
var/global/list/pjack = list()
//OOC COLOR
var/global/list/customooccolorlist = list()

var/global/list/coolboombox = list()

var/global/list/singer = list()

var/global/list/weeDonator = list()
var/global/list/baliset = list()
var/global/list/black_cloak = list()
var/global/list/bee_queen = list()

var/global/list/secret_devs = list()

var/global/list/patreons = list()
#define PIGPLUS 1
#define COMRADE 2
#define VILLAIN 3

/proc/build_donations_list()
    build_seaspotter()
    build_reddawn()
    build_lord()
    build_crusader()
    build_tophat()
    build_monk()
    build_futa()
    build_30cm()
    build_trapapoc()
    build_outlaw()
    build_waterbottle()
    build_luxurydonation()
    build_pjack()
    build_customooccolor()
    build_mercenary_donor()
    build_squire_donor()
    build_tribvet_donor()
    build_urchin_donor()
    build_mobilephone()
    build_weeDonator()
    build_baliset()
    //set_donation_locks() //NAO ATIVAR ISSO FICA NO MASTER_CONTROLLER.DM

/proc/build_mobilephone()
    var/DBQuery/queryInsert = dbcon.NewQuery("Select ckey FROM donation_mobilephone;")
    if(!queryInsert.Execute())
        world.log << queryInsert.ErrorMsg()
        queryInsert.Close()
        return
    while(queryInsert.NextRow())
        mobilephone.Add(queryInsert.item[1])//KKKKKKKKKKKKKKKKKKKKKKKK RETARDADO

/proc/build_baliset()
    var/DBQuery/queryInsert = dbcon.NewQuery("Select ckey FROM donation_baliset;")
    if(!queryInsert.Execute())
        world.log << queryInsert.ErrorMsg()
        queryInsert.Close()
        return
    while(queryInsert.NextRow())
        baliset.Add(queryInsert.item[1])

/proc/build_weeDonator()
    var/DBQuery/queryInsert = dbcon.NewQuery("Select ckey FROM donation_weeDonator;")
    if(!queryInsert.Execute())
        world.log << queryInsert.ErrorMsg()
        queryInsert.Close()
        return
    while(queryInsert.NextRow())
        weeDonator.Add(queryInsert.item[1])

/proc/build_remigrator()
    var/DBQuery/queryInsert = dbcon.NewQuery("Select ckey FROM donation_remigrator;")
    if(!queryInsert.Execute())
        world.log << queryInsert.ErrorMsg()
        queryInsert.Close()
        return
    while(queryInsert.NextRow())
        remigrator.Add(queryInsert.item[1])

/proc/build_seaspotter()
    var/DBQuery/queryInsert = dbcon.NewQuery("Select ckey FROM donation_seaspotter_merc;")
    if(!queryInsert.Execute())
        world.log << queryInsert.ErrorMsg()
        queryInsert.Close()
        return
    while(queryInsert.NextRow())
        seaspotter_merc.Add(queryInsert.item[1])

/proc/build_reddawn()
    var/DBQuery/queryInsert = dbcon.NewQuery("Select ckey FROM donation_reddawn_merc;")
    if(!queryInsert.Execute())
        world.log << queryInsert.ErrorMsg()
        queryInsert.Close()
        return
    while(queryInsert.NextRow())
        reddawn_merc.Add(queryInsert.item[1])

/proc/build_tribvet_donor()
    var/DBQuery/queryInsert = dbcon.NewQuery("Select ckey FROM donation_tribvet_donor;")
    if(!queryInsert.Execute())
        world.log << queryInsert.ErrorMsg()
        queryInsert.Close()
        return
    while(queryInsert.NextRow())
        tribunal_vet.Add(queryInsert.item[1])

/proc/build_mercenary_donor()
    var/DBQuery/queryInsert = dbcon.NewQuery("Select ckey FROM donation_mercenary_donor;")
    if(!queryInsert.Execute())
        world.log << queryInsert.ErrorMsg()
        queryInsert.Close()
        return
    while(queryInsert.NextRow())
        mercenary_donor.Add(queryInsert.item[1])

/proc/build_squire_donor()
    var/DBQuery/queryInsert = dbcon.NewQuery("Select ckey FROM donation_squire_donor;")
    if(!queryInsert.Execute())
        world.log << queryInsert.ErrorMsg()
        queryInsert.Close()
        return
    while(queryInsert.NextRow())
        adultsquire.Add(queryInsert.item[1])

/proc/build_urchin_donor()
    var/DBQuery/queryInsert = dbcon.NewQuery("Select ckey FROM donation_urchin_donor;")
    if(!queryInsert.Execute())
        world.log << queryInsert.ErrorMsg()
        queryInsert.Close()
        return
    while(queryInsert.NextRow())
        urchin_donor.Add(queryInsert.item[1])

/proc/set_donation_locks()
    for(var/datum/job/job in job_master.occupations)
        if(job.title == "Mercenary")
            job.donation_lock = mercenary_donor.Copy()
        if(job.title == "Urchin")
            job.donation_lock = urchin_donor.Copy()
        if(job.title == "Tribunal Veteran")
            job.donation_lock = tribunal_vet.Copy()

/proc/build_lord()
    var/DBQuery/queryInsert = dbcon.NewQuery("Select ckey FROM donation_lord;")
    if(!queryInsert.Execute())
        world.log << queryInsert.ErrorMsg()
        queryInsert.Close()
        return
    while(queryInsert.NextRow())
        lord.Add(queryInsert.item[1])

/proc/build_crusader()
    var/DBQuery/queryInsert = dbcon.NewQuery("Select ckey FROM donation_crusader;")
    if(!queryInsert.Execute())
        world.log << queryInsert.ErrorMsg()
        queryInsert.Close()
        return
    while(queryInsert.NextRow())
        crusader.Add(queryInsert.item[1])

/proc/build_tophat()
    var/DBQuery/queryInsert = dbcon.NewQuery("Select ckey FROM donation_tophat;")
    if(!queryInsert.Execute())
        world.log << queryInsert.ErrorMsg()
        queryInsert.Close()
        return
    while(queryInsert.NextRow())
        tophat.Add(queryInsert.item[1])

/proc/build_monk()
    var/DBQuery/queryInsert = dbcon.NewQuery("Select ckey FROM donation_monk;")
    if(!queryInsert.Execute())
        world.log << queryInsert.ErrorMsg()
        queryInsert.Close()
        return
    while(queryInsert.NextRow())
        monk.Add(queryInsert.item[1])

/proc/build_futa()
    var/DBQuery/queryInsert = dbcon.NewQuery("Select ckey FROM donation_futa;")
    if(!queryInsert.Execute())
        world.log << queryInsert.ErrorMsg()
        queryInsert.Close()
        return
    while(queryInsert.NextRow())
        futa.Add(queryInsert.item[1])


/proc/build_30cm()
    var/DBQuery/queryInsert = dbcon.NewQuery("Select ckey FROM donation_30cm;")
    if(!queryInsert.Execute())
        world.log << queryInsert.ErrorMsg()
        queryInsert.Close()
        return
    while(queryInsert.NextRow())
        thirtycm.Add(queryInsert.item[1])

/proc/build_trapapoc()
    var/DBQuery/queryInsert = dbcon.NewQuery("Select ckey FROM donation_trapapoc;")
    if(!queryInsert.Execute())
        world.log << queryInsert.ErrorMsg()
        queryInsert.Close()
        return
    while(queryInsert.NextRow())
        trapapoc.Add(queryInsert.item[1])

/proc/build_outlaw()
    var/DBQuery/queryInsert = dbcon.NewQuery("Select ckey FROM donation_outlaw;")
    if(!queryInsert.Execute())
        world.log << queryInsert.ErrorMsg()
        queryInsert.Close()
        return
    while(queryInsert.NextRow())
        outlaw.Add(queryInsert.item[1])

/proc/build_waterbottle()
    var/DBQuery/queryInsert = dbcon.NewQuery("Select ckey FROM donation_waterbottledonation;")
    if(!queryInsert.Execute())
        world.log << queryInsert.ErrorMsg()
        queryInsert.Close()
        return
    while(queryInsert.NextRow())
        waterbottledonation.Add(queryInsert.item[1])

/proc/build_luxurydonation()
    var/DBQuery/queryInsert = dbcon.NewQuery("Select ckey FROM donation_luxurydonation;")
    if(!queryInsert.Execute())
        world.log << queryInsert.ErrorMsg()
        queryInsert.Close()
        return
    while(queryInsert.NextRow())
        luxurydonation.Add(queryInsert.item[1])

/proc/build_pjack()
    var/DBQuery/queryInsert = dbcon.NewQuery("Select ckey FROM donation_pjack;")
    if(!queryInsert.Execute())
        world.log << queryInsert.ErrorMsg()
        queryInsert.Close()
        return
    while(queryInsert.NextRow())
        pjack.Add(queryInsert.item[1])

/proc/build_customooccolor()
    var/DBQuery/queryInsert = dbcon.NewQuery("Select ckey FROM donation_customooccolorlist;")
    if(!queryInsert.Execute())
        world.log << queryInsert.ErrorMsg()
        queryInsert.Close()
        return
    while(queryInsert.NextRow())
        customooccolorlist.Add(queryInsert.item[1])