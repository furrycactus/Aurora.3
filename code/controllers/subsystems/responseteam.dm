/var/datum/controller/subsystem/responseteam/SSresponseteam

/datum/controller/subsystem/responseteam
	name = "Response Team"
	flags = SS_NO_FIRE

	var/ert_count = 0
	var/send_emergency_team = FALSE
	var/can_call_ert = TRUE

	var/list/datum/responseteam/available_teams = list()
	var/datum/responseteam/picked_team
	var/list/datum/ghostspawner/human/ert/sent_teams = list()

/datum/controller/subsystem/responseteam/Recover()
	send_emergency_team = SSresponseteam.send_emergency_team

/datum/controller/subsystem/responseteam/New()
	NEW_SS_GLOBAL(SSresponseteam)
	feedback_set("responseteam_count",0)

/datum/controller/subsystem/responseteam/Initialize(start_timeofday)
	. = ..()
	var/list/all_teams = subtypesof(/datum/responseteam)
	for(var/team in all_teams)
		CHECK_TICK
		var/datum/responseteam/ert = new team
		available_teams += ert

/datum/controller/subsystem/responseteam/stat_entry()
	var/out = "CC:[can_call_ert]"
	..(out)

/datum/controller/subsystem/responseteam/proc/pick_random_team()
	var/datum/responseteam/result
	var/probability = rand(1, 100)
	var/tally = 0
	for(var/datum/responseteam/ert in available_teams) //We need a loop to keep going through each candidate to be sure we find a good result.
		if((ert.chance + tally) <= probability) //Check every available ERT's chance. Keep going until we add enough to the tally so that we have a certain result.
			tally += ert.chance
			continue
		result = ert
		break

	if(!result)
		log_debug("SSresponseteam: We didn't find an ERT pick result!")
		return pick(available_teams)
	else
		return result


/datum/controller/subsystem/responseteam/proc/trigger_armed_response_team(var/forced_choice = null)
	if(!can_call_ert && !forced_choice)
		return
	if(send_emergency_team)
		return
	
	ert_count++
	feedback_inc("responseteam_count")

	command_announcement.Announce("A distress beacon has been launched. Please remain calm, a relief team will arrive soon.", "[current_map.boss_name]", 'sound/effects/distressbeacon.ogg')

	if(forced_choice && forced_choice != "Random")
		for(var/datum/responseteam/R in available_teams)
			if(R.name == forced_choice)
				picked_team = R
				break
	else
		picked_team = pick_random_team()

	feedback_set("responseteam[ert_count]",world.time)

	can_call_ert = FALSE // Only one call per round, gentleman.
	send_emergency_team = 1

	sent_teams = list() //Make sure this list is clear before we use it.

	handle_spawner()

	sleep(120 SECONDS)

	for(var/datum/ghostspawner/G in sent_teams)
		G.disable()

	send_emergency_team = FALSE //We completed the ERT handling, so let's allow admins to call another.

/datum/controller/subsystem/responseteam/proc/handle_spawner()
	for(var/N in typesof(picked_team.spawner)) //Find all spawners that are subtypes of the team we want.
		var/datum/ghostspawner/human/ert/new_spawner = new N
		for(var/role_spawner in SSghostroles.spawners)
			if(new_spawner.short_name == role_spawner) //Create the spawner, then use its name to find the spawner in SSghostroles' spawner lists.
				var/datum/ghostspawner/human/ert/good_spawner = SSghostroles.spawners[role_spawner]
				sent_teams += good_spawner //Enable that spawner.
				good_spawner.enable()

/datum/controller/subsystem/responseteam/proc/close_ert_blastdoors()
	var/datum/wifi/sender/door/wifi_sender = new("ert_shuttle_lockdown", src)
	wifi_sender.activate("close")

/datum/controller/subsystem/responseteam/proc/close_tcfl_blastdoors()
	var/datum/wifi/sender/door/wifi_sender = new("tcfl_shuttle_lockdown", src)
	wifi_sender.activate("close")

/client/proc/response_team()
	set name = "Dispatch Emergency Response Team"
	set category = "Special Verbs"
	set desc = "Send an emergency response team to the station"

	if(!holder)
		to_chat(usr, "<span class='danger'>Only administrators may use this command.</span>") 
		return
	if(!ROUND_IS_STARTED)
		to_chat(usr, "<span class='danger'>The round hasn't started yet!</span>")
		return
	if(SSresponseteam.send_emergency_team)
		to_chat(usr, "<span class='danger'>[current_map.boss_name] has already dispatched an emergency response team!</span>")
		return
	if(alert("Do you want to dispatch an Emergency Response Team?",,"Yes","No") != "Yes")
		return
	if(get_security_level() != "red") // Allow admins to reconsider if the alert level isn't Red
		switch(alert("The station is not in red alert. Do you still want to dispatch a response team?",,"Yes","No"))
			if("No")
				return

	var/list/plaintext_teams = list("Random")
	for(var/datum/responseteam/A in SSresponseteam.available_teams)
		plaintext_teams += A.name

	var/choice = input("Select the response team type","Response team selection") as null|anything in plaintext_teams

	if(SSresponseteam.send_emergency_team)
		to_chat(usr, "<span class='danger'>Looks like somebody beat you to it!</span>")
		return

	message_admins("[key_name_admin(usr)] is dispatching a Response Team: [choice].", 1)
	log_admin("[key_name(usr)] used Dispatch Response Team: [choice].",admin_key=key_name(usr))
	SSresponseteam.trigger_armed_response_team(choice)


/hook/shuttle_moved/proc/close_response_blastdoors(var/area/departing, var/area/destination)
	//Check if we are departing from the Odin
	if(istype(departing,/area/shuttle/specops/centcom))
		SSresponseteam.close_ert_blastdoors()

	//Check if we are departing from the TCFL base
	else if(istype(departing,/area/shuttle/legion/centcom))
		SSresponseteam.close_tcfl_blastdoors()
	return TRUE