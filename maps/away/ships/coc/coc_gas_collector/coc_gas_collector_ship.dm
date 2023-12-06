/datum/map_template/ruin/away_site/coc_gas_collector_vessel
	name = "Coalition Gas Collection Vessel"
	description = "This colossal vessel is designed and operated by the Coalition of Colonies. In the wake of the Phoron Crisis, the need for finding more ship fuel - Phoron or otherwise - drastically increased. As a result, the Coalition member states pooled together to fund a small fleet of ships for the scouting, collection, and refining of gaseous fuel."
	suffixes = list("ships/coc/coc_gas_collector/coc_gas_collector.dmm")
	sectors = list(ALL_COALITION_SECTORS, ALL_VOID_SECTORS)
	spawn_weight = 1
	ship_cost = 1
	id = "Coalition Gas Collection Vessel"
	shuttles_to_initialise = list(/datum/shuttle/autodock/overmap/coc_gas_collector_shuttle)

	unit_test_groups = list(2)

/singleton/submap_archetype/coc_gas_collector
	map = "Coalition Gas Collection Vessel"
	descriptor = "This colossal vessel is designed and operated by the Coalition of Colonies. In the wake of the Phoron Crisis, the need for finding more ship fuel - Phoron or otherwise - drastically increased. As a result, the Coalition member states pooled together to fund a small fleet of ships for the scouting, collection, and refining of gaseous fuel."

// Ship Stuff
/obj/effect/overmap/visitable/ship/coc_gas_collector
	name = "Coalition Gas Collection Vessel"
	class = "CCV"
	desc = "This colossal vessel is designed and operated by the Coalition of Colonies. In the wake of the Phoron Crisis, the need for finding more ship fuel - Phoron or otherwise - drastically increased. As a result, the Coalition member states pooled together to fund a small fleet of ships for the scouting, collection, and refining of gaseous fuel."
	icon_state = "tramp"
	moving_state = "tramp_moving"
	colors = list("#8492fd", "#4d61fc")
	designer = "Coalition of Colonies, Xanu Prime"
	volume = "60 meters length, 58 meters beam/width, 12 meters vertical height"
	drive = "Low-Speed Warp Acceleration FTL Drive"
	weapons = "Dual extruding port fore and starboard fore-mounted medium caliber armament, aft obscured flight craft bay"
	sizeclass = "Galga-class Surveyor"
	shiptype = "Exploration, mineral and artifact recovery"
	max_speed = 1/(2 SECONDS)
	burn_delay = 1 SECONDS
	vessel_mass = 5000
	fore_dir = SOUTH
	vessel_size = SHIP_SIZE_SMALL
	initial_restricted_waypoints = list(
		"Coalition Gas Collection Shuttle" = list("nav_hangar_coc_gas_collector")
	)
	initial_generic_waypoints = list(
		"nav_coc_gas_collector_1",
		"nav_coc_gas_collector_2",
		"nav_coc_gas_collector_3",
		"nav_coc_gas_collector_4",
		"nav_coc_gas_collector_5",
		"nav_coc_gas_collector_6",
		"nav_coc_gas_collector_7",
	)

	invisible_until_ghostrole_spawn = TRUE

/obj/effect/overmap/visitable/ship/coc_gas_collector/New()
	designation = "[pick("Archemedes", "Pallas", "Crius", "Pothos", "Nyx")]"
	..()

/obj/effect/shuttle_landmark/coc_gas_collector
	base_turf = /turf/space/dynamic
	base_area = /area/space

/obj/effect/shuttle_landmark/coc_gas_collector/nav1
	name = "Coalition Gas Collection Vessel - Aft Dock"
	landmark_tag = "nav_coc_gas_collector_1"
	base_turf = /turf/space/dynamic
	base_area = /area/space

/obj/effect/shuttle_landmark/coc_gas_collector/nav2
	name = "Coalition Gas Collection Vessel - Port Dock"
	landmark_tag = "nav_coc_gas_collector_2"
	base_turf = /turf/space/dynamic
	base_area = /area/space

/obj/effect/shuttle_landmark/coc_gas_collector/nav3
	name = "Coalition Gas Collection Vessel - Starboard Dock"
	landmark_tag = "nav_coc_gas_collector_3"
	base_turf = /turf/space/dynamic
	base_area = /area/space

/obj/effect/shuttle_landmark/coc_gas_collector/nav4
	name = "Coalition Gas Collection Vessel - Fore"
	landmark_tag = "nav_coc_gas_collector_4"
	base_turf = /turf/space/dynamic
	base_area = /area/space

/obj/effect/shuttle_landmark/coc_gas_collector/nav5
	name = "Coalition Gas Collection Vessel - Aft"
	landmark_tag = "nav_coc_gas_collector_5"
	base_turf = /turf/space/dynamic
	base_area = /area/space

/obj/effect/shuttle_landmark/coc_gas_collector/nav6
	name = "Coalition Gas Collection Vessel - Port"
	landmark_tag = "nav_coc_gas_collector_6"
	base_turf = /turf/space/dynamic
	base_area = /area/space

/obj/effect/shuttle_landmark/coc_gas_collector/nav7
	name = "Coalition Gas Collection Vessel - Starboard"
	landmark_tag = "nav_coc_gas_collector_7"
	base_turf = /turf/space/dynamic
	base_area = /area/space

//shuttle stuff
/obj/effect/overmap/visitable/ship/landable/coc_gas_collector_shuttle
	name = "Coalition Gas Collection Shuttle"
	class = "CCV"
	designation = "Lamprey"
	desc = "A new Baleen-class gas harvester shuttle design by the Coalition. Used to siphon the atmosphere of a planetary body for later refining."
	shuttle = "Coalition Gas Collection Shuttle"
	icon_state = "pod"
	moving_state = "pod_moving"
	colors = list("#a0a8ec", "#8492fd")
	max_speed = 1/(3 SECONDS)
	burn_delay = 2 SECONDS
	vessel_mass = 3000 //very inefficient pod
	fore_dir = SOUTH
	vessel_size = SHIP_SIZE_TINY

/obj/machinery/computer/shuttle_control/explore/coc_gas_collector_shuttle
	name = "shuttle control console"
	shuttle_tag = "Coalition Gas Collection Shuttle"

/datum/shuttle/autodock/overmap/coc_gas_collector_shuttle
	name = "Coalition Gas Collection Shuttle"
	move_time = 20
	shuttle_area = list(/area/shuttle/coc_gas_collector_shuttle)
	current_location = "nav_hangar_coc_gas_collector"
	landmark_transition = "nav_transit_coc_gas_collector_shuttle"
	dock_target = "coc_gas_collector_shuttle"
	range = 1
	fuel_consumption = 2
	logging_home_tag = "nav_hangar_coc_gas_collector"
	defer_initialisation = TRUE

/obj/effect/shuttle_landmark/coc_gas_collector_shuttle/hangar
	name = "Coalition Gas Collection Shuttle Hangar"
	landmark_tag = "nav_hangar_coc_gas_collector"
	docking_controller = "coc_gas_collector_shuttle_dock"
	base_area = /area/cocgascollect_ship/coc_gas_collector_ship/coc_gas_collector_hangar
	base_turf = /turf/simulated/floor/plating
	movable_flags = MOVABLE_FLAG_EFFECTMOVE

/obj/effect/shuttle_landmark/coc_gas_collector_shuttle/transit
	name = "In transit"
	landmark_tag = "nav_transit_coc_gas_collector_shuttle"
	base_turf = /turf/space/transit/north
