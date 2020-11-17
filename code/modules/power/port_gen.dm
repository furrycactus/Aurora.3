//Baseline portable generator. Has all the default handling. Not intended to be used on it's own (since it generates unlimited power).
/obj/machinery/power/port_gen
	name = "Placeholder Generator"	//seriously, don't use this. It can't be anchored without VV magic.
	desc = "A portable generator for emergency backup power"
	icon = 'icons/obj/power.dmi'
	icon_state = "portgen0"
	density = TRUE
	anchored = FALSE

	var/active = FALSE
	var/power_gen = 5000
	var/open = FALSE
	var/power_output = 1
	has_special_power_checks = TRUE
	var/datum/looping_sound/generator/soundloop

/obj/machinery/power/port_gen/Initialize()
	. = ..()
	soundloop = new(list(src), active)

/obj/machinery/power/port_gen/proc/IsBroken()
	return (stat & (BROKEN|EMPED))

/obj/machinery/power/port_gen/proc/HasFuel() //Placeholder for fuel check.
	return TRUE

/obj/machinery/power/port_gen/proc/UseFuel() //Placeholder for fuel use.
	return

/obj/machinery/power/port_gen/proc/DropFuel()
	return

/obj/machinery/power/port_gen/proc/handleInactive()
	return

/obj/machinery/power/port_gen/machinery_process()
	if(active && HasFuel() && !IsBroken() && anchored)
		if(powernet)
			add_avail(power_gen * power_output)
		UseFuel()
		SSvueui.check_uis_for_change(src)
	else
		active = FALSE
		icon_state = initial(icon_state)
		handleInactive()

/obj/machinery/power/powered()
	return TRUE //doesn't require an external power source

/obj/machinery/power/port_gen/attack_hand(mob/user)
	if(..())
		update_icon()
		soundloop.stop()
		return
	if(!anchored)
		update_icon()
		soundloop.start()
		return

/obj/machinery/power/port_gen/examine(mob/user)
	if(!..(user, 1))
		return
	if(active)
		to_chat(usr, SPAN_NOTICE("The generator is on."))
	else
		to_chat(usr, SPAN_NOTICE("The generator is off."))

/obj/machinery/power/port_gen/emp_act(severity)
	var/duration = 6000 //ten minutes
	switch(severity)
		if(1)
			stat &= BROKEN
			if(prob(75)) explode()
		if(2)
			if(prob(25)) stat &= BROKEN
			if(prob(10)) explode()
		if(3)
			if(prob(10)) stat &= BROKEN
			duration = 300

	stat |= EMPED
	if(duration)
		spawn(duration)
			stat &= ~EMPED

/obj/machinery/power/port_gen/proc/explode()
	explosion(loc, -1, 3, 5, -1)
	qdel(src)

#define TEMPERATURE_DIVISOR 40
#define TEMPERATURE_CHANGE_MAX 20

//A power generator that runs on solid phoron sheets.
/obj/machinery/power/port_gen/pacman
	name = "\improper P-P.A.C.M.A.N.-type Portable Generator"
	desc = "An advanced power generator that runs on solid phoron sheets. Rated for 120 kW max safe output. <span class='danger'>WARNING: DO NOT OPERATE ABOVE SAFE THRESHOLD FOR EXTENDED PERIODS.</span>"

	var/sheet_name = "Phoron Sheets"
	var/sheet_path = /obj/item/stack/material/phoron
	var/board_path = "/obj/item/circuitboard/pacman"

	/*
		These values were chosen so that the generator can run safely up to 80 kW
		A full 50 phoron sheet stack should last 20 minutes at power_output = 4
		temperature_gain and max_temperature are set so that the max safe power level is 4.
		Setting to 5 or higher can only be done temporarily before the generator overheats.
	*/
	power_gen = 30000			//Watts output per power_output level
	var/max_power_output = 5	//The maximum power setting without emagging.
	var/max_safe_output = 4		// For UI use, maximal output that won't cause overheat.
	var/time_per_sheet = 96		//fuel efficiency - how long 1 sheet lasts at power level 1
	var/max_sheets = 100 		//max capacity of the hopper
	var/max_temperature = 300	//max temperature before overheating increases
	var/temperature_gain = 50	//how much the temperature increases per power output level, in degrees per level

	var/sheets = 0			//How many sheets of material are loaded in the generator
	var/sheet_left = 0		//How much is left of the current sheet
	var/temperature = 0		//The current temperature
	var/overheating = 0		//if this gets high enough the generator explodes

	component_types = list(
		/obj/item/stock_parts/matter_bin,
		/obj/item/stock_parts/micro_laser,
		/obj/item/stack/cable_coil = 2,
		/obj/item/stock_parts/capacitor
	)

/obj/machinery/power/port_gen/pacman/Initialize()
	component_types += board_path
	. = ..()

	if(anchored)
		connect_to_network()

/obj/machinery/power/port_gen/pacman/Destroy()
	DropFuel()
	return ..()

/obj/machinery/power/port_gen/pacman/RefreshParts()
	var/temp_rating = 0

	for(var/obj/item/stock_parts/SP in component_parts)
		if(istype(SP, /obj/item/stock_parts/matter_bin))
			max_sheets = SP.rating * SP.rating * 50
		else if(istype(SP, /obj/item/stock_parts/micro_laser) || istype(SP, /obj/item/stock_parts/capacitor))
			temp_rating += SP.rating

	power_gen = round(initial(power_gen) * (max(2, temp_rating) / 2))
	SSvueui.check_uis_for_change(src)

/obj/machinery/power/port_gen/pacman/examine(mob/user)
	..(user)
	to_chat(user, "\The [src] appears to be producing [power_gen*power_output] W.")
	to_chat(user, "There [sheets == 1 ? "is" : "are"] [sheets] sheet\s left in the hopper.")
	if(IsBroken()) to_chat(user, SPAN_WARNING("\The [src] seems to have broken down."))
	if(overheating) to_chat(user, SPAN_DANGER("\The [src] is overheating!"))

/obj/machinery/power/port_gen/pacman/HasFuel()
	var/needed_sheets = power_output / time_per_sheet
	if(sheets >= needed_sheets - sheet_left)
		return TRUE

//Removes one stack's worth of material from the generator.
/obj/machinery/power/port_gen/pacman/DropFuel()
	if(sheets)
		var/obj/item/stack/material/S = new sheet_path(loc)
		var/amount = min(sheets, S.max_amount)
		S.amount = amount
		sheets -= amount

/obj/machinery/power/port_gen/pacman/UseFuel()

	//how much material are we using this iteration?
	var/needed_sheets = power_output / time_per_sheet

	//HasFuel() should guarantee us that there is enough fuel left, so no need to check that
	//the only thing we need to worry about is if we are going to rollover to the next sheet
	if (needed_sheets > sheet_left)
		sheets--
		sheet_left = (1 + sheet_left) - needed_sheets
	else
		sheet_left -= needed_sheets

	//calculate the "target" temperature range
	//This should probably depend on the external temperature somehow, but whatever.
	var/lower_limit = 56 + power_output * temperature_gain
	var/upper_limit = 76 + power_output * temperature_gain

	/*
		Hot or cold environments can affect the equilibrium temperature
		The lower the pressure the less effect it has. I guess it cools using a radiator or something when in vacuum.
		Gives traitors more opportunities to sabotage the generator or allows enterprising engineers to build additional
		cooling in order to get more power out.
	*/
	var/datum/gas_mixture/environment = loc.return_air()
	if (environment)
		var/ratio = min(environment.return_pressure()/ONE_ATMOSPHERE, 1)
		var/ambient = environment.temperature - T20C
		lower_limit += ambient*ratio
		upper_limit += ambient*ratio

	var/average = (upper_limit + lower_limit)/2

	//calculate the temperature increase
	var/bias = 0
	if (temperature < lower_limit)
		bias = min(round((average - temperature)/TEMPERATURE_DIVISOR, 1), TEMPERATURE_CHANGE_MAX)
	else if (temperature > upper_limit)
		bias = max(round((temperature - average)/TEMPERATURE_DIVISOR, 1), -TEMPERATURE_CHANGE_MAX)

	//limit temperature increase so that it cannot raise temperature above upper_limit,
	//or if it is already above upper_limit, limit the increase to 0.
	var/inc_limit = max(upper_limit - temperature, 0)
	var/dec_limit = min(temperature - lower_limit, 0)
	temperature += between(dec_limit, rand(-7 + bias, 7 + bias), inc_limit)

	if (temperature > max_temperature)
		overheat()
	else if (overheating > 0)
		overheating--

	SSvueui.check_uis_for_change(src)

/obj/machinery/power/port_gen/pacman/handleInactive()
	var/cooling_temperature = 20

	var/turf/T = get_turf(src)
	if(T)
		var/datum/gas_mixture/environment = T.return_air()
		if (environment)
			var/ratio = min(environment.return_pressure()/ONE_ATMOSPHERE, 1)
			var/ambient = environment.temperature - T20C
			cooling_temperature += ambient*ratio

	if (temperature > cooling_temperature)
		var/temp_loss = (temperature - cooling_temperature)/TEMPERATURE_DIVISOR
		temp_loss = between(2, round(temp_loss, 1), TEMPERATURE_CHANGE_MAX)
		temperature = max(temperature - temp_loss, cooling_temperature)
		SSvueui.check_uis_for_change(src)

	if(overheating)
		overheating--

/obj/machinery/power/port_gen/pacman/proc/overheat()
	overheating++
	if (overheating > 60)
		explode()

/obj/machinery/power/port_gen/pacman/explode()
	//Vapourize all the phoron
	//When ground up in a grinder, 1 sheet produces 20 u of phoron -- Chemistry-Machinery.dm
	//1 mol = 10 u? I dunno. 1 mol of carbon is definitely bigger than a pill
	var/phoron = (sheets+sheet_left)*20
	var/datum/gas_mixture/environment = loc.return_air()
	if (environment)
		environment.adjust_gas_temp(GAS_PHORON, phoron/10, temperature + T0C)
	var/rads = 90 + (sheets + sheet_left)*1.5
	for (var/mob/living/L in range(src, 10))
		//should really fall with the square of the distance, but that makes the rads value drop too fast
		//I dunno, maybe physics works different when you live in 2D -- SM radiation also works like this, apparently
		L.apply_effect(max(20, round(rads/get_dist(L,src))), IRRADIATE, blocked = L.getarmor(null, "rad"))
	explosion(loc, 3, 6, 12, 16, 1) //explosion about as big as a Supermatter shard, also produces radiation. Mars told us phoron is dangerous.
	qdel(src)

	sheets = 0
	sheet_left = 0
	..()

/obj/machinery/power/port_gen/pacman/emag_act(var/remaining_charges, var/mob/user)
	if (active && prob(25))
		explode() //if they're foolish enough to emag while it's running

	if (!emagged)
		emagged = TRUE
		return TRUE

/obj/machinery/power/port_gen/pacman/attackby(var/obj/item/O, var/mob/user)
	if(istype(O, sheet_path))
		var/obj/item/stack/addstack = O
		var/amount = min((max_sheets - sheets), addstack.amount)
		if(amount < 1)
			to_chat(user, SPAN_NOTICE("The [name] is full!"))
			return
		to_chat(user, SPAN_NOTICE("You add [amount] sheet\s to the [name]."))
		sheets += amount
		addstack.use(amount)
		SSvueui.check_uis_for_change(src)
		return
	else if(!active)
		if(O.iswrench())

			if(!anchored)
				connect_to_network()
				to_chat(user, SPAN_NOTICE("You secure the generator to the floor."))
			else
				disconnect_from_network()
				to_chat(user, SPAN_NOTICE("You unsecure the generator from the floor."))
				SSvueui.close_uis(src)

			playsound(loc, 'sound/items/Deconstruct.ogg', 50, 1)
			anchored = !anchored

		else if(O.isscrewdriver())
			open = !open
			playsound(loc, O.usesound, 50, 1)
			if(open)
				to_chat(user, SPAN_NOTICE("You open the access panel."))
			else
				to_chat(user, SPAN_NOTICE("You close the access panel."))
		else if(open && O.iscrowbar())
			var/obj/machinery/constructable_frame/machine_frame/new_frame = new /obj/machinery/constructable_frame/machine_frame(loc)
			for(var/obj/item/I in component_parts)
				I.forceMove(loc)
			while (sheets > 0)
				DropFuel()

			new_frame.state = 2
			new_frame.icon_state = "box_1"
			qdel(src)
	SSvueui.check_uis_for_change(src)

/obj/machinery/power/port_gen/pacman/attack_hand(mob/user)
	..()
	if (!anchored)
		return
	ui_interact(user)

/obj/machinery/power/port_gen/pacman/attack_ai(mob/user)
	if(!ai_can_interact(user))
		return
	ui_interact(user)

/obj/machinery/power/port_gen/pacman/vueui_data_change(var/list/data, var/mob/user, var/datum/vueui/ui)
	if(!data)
		. = data = list()

	data["active"] = active
	data["output_set"] = power_output
	data["output_max"] = max_power_output
	data["output_safe"] = max_safe_output
	data["temperature_current"] = temperature
	data["temperature_max"] = max_temperature
	data["temperature_overheat"] = overheating

	var/datum/gas_mixture/environment = loc.return_air()
	data["temperature_min"] = Floor(environment.temperature - T0C)
	data["output_min"] = initial(power_output)
	data["is_broken"] = IsBroken()
	data["is_ai"] = (isAI(user) || (isrobot(user) && !Adjacent(user)))

	var/list/fuel = list(
		"fuel_stored" = round((sheets * 1000) + (sheet_left * 1000)),
		"fuel_capacity" = round(max_sheets * 1000, 0.1),
		"fuel_usage" = active ? round((power_output / time_per_sheet) * 1000) : FALSE,
		"fuel_type" = sheet_name
		)

	LAZYINITLIST(data["fuel"])
	data["fuel"] = fuel
	data["output_watts"] = power_output * power_gen

	return data

/obj/machinery/power/port_gen/pacman/ui_interact(mob/user)
	var/datum/vueui/ui = SSvueui.get_open_ui(user, src)
	if (!ui)
		ui = new(user, src, "machinery-power-pacman", 500, 560, capitalize(name))
	ui.open()

/obj/machinery/power/port_gen/pacman/Topic(href, href_list)
	if(..())
		return

	add_fingerprint(usr)
	if(href_list["action"])
		if(href_list["action"] == "enable")
			if(!active && HasFuel() && !IsBroken())
				active = TRUE
				icon_state = "portgen1"
		if(href_list["action"] == "disable")
			if (active)
				active = FALSE
				icon_state = "portgen0"
		if(href_list["action"] == "eject")
			if(!active)
				DropFuel()
		if(href_list["action"] == "lower_power")
			if (power_output > initial(power_output))
				power_output--
		if (href_list["action"] == "higher_power")
			if ((power_output < max_power_output) || (emagged && (power_output < round(max_power_output*2.5))))
				power_output++
		SSvueui.check_uis_for_change(src)

/obj/machinery/power/port_gen/pacman/super
	name = "U-P.A.C.M.A.N.-type Portable Generator"
	desc = "A power generator that utilizes uranium sheets as fuel. Can run for much longer than the standard PACMAN type generators. Rated for 80 kW max safe output. WARNING: MINOR RADIATION HAZARD WHEN ACTIVE. DO NOT OPERATE ABOVE SAFE THRESHOLD FOR EXTENDED PERIODS."
	icon_state = "portgen1"
	sheet_path = /obj/item/stack/material/uranium
	sheet_name = "Uranium Sheets"
	power_gen = 20000 //watts
	time_per_sheet = 576 //lowest output, but a 50 sheet stack will last 2 hours at max safe power
	board_path = "/obj/item/circuitboard/pacman/super"

/obj/machinery/power/port_gen/pacman/super/UseFuel()
	//produces a tiny amount of radiation when in use
	if (prob(2*power_output))
		for (var/mob/living/L in range(src, 5))
			L.apply_effect(1, IRRADIATE, blocked = L.getarmor(null, "rad")) //should amount to ~5 rads per minute at max safe power
	..()

/obj/machinery/power/port_gen/pacman/super/explode()
	//a nice burst of radiation. Vaporised uranium make geiger counter go vrrrr.
	var/rads = 50 + (sheets + sheet_left)*1.5
	for (var/mob/living/L in range(src, 10))
		//should really fall with the square of the distance, but that makes the rads value drop too fast
		//I dunno, maybe physics works different when you live in 2D -- SM radiation also works like this, apparently
		L.apply_effect(max(20, round(rads/get_dist(L,src))), IRRADIATE, blocked = L.getarmor(null, "rad"))

	explosion(loc, 3, 3, 5, 3)
	qdel(src)

/obj/machinery/power/port_gen/pacman/mrs
	name = "T-P.A.C.M.A.N.-type Portable Generator"
	desc = "An advanced power generator that runs on tritium. Rated for 200 kW maximum safe output! WARNING: DO NOT OPERATE ABOVE SAFE THRESHOLD FOR EXTENDED PERIODS."
	icon_state = "portgen2"
	sheet_path = /obj/item/stack/material/tritium
	sheet_name = "Tritium Fuel Sheets"

	//I don't think tritium has any other use, so we might as well make this rewarding for players
	//max safe power output (power level = 8) is 200 kW and lasts for 1 hour - 3 or 4 of these could power the station
	power_gen = 25000 //watts
	max_power_output = 10
	max_safe_output = 8
	time_per_sheet = 576
	max_temperature = 800
	temperature_gain = 90
	board_path = "/obj/item/circuitboard/pacman/mrs"

/obj/machinery/power/port_gen/pacman/mrs/explode()
	//no special effects, but the explosion is pretty big (same as a supermatter shard). Slightly radioactive Hydrogen isotopes go boom.
	explosion(loc, 3, 6, 12, 16, 1)
	qdel(src)
