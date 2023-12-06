//Coalition Gas Collector Crew
/datum/ghostspawner/human/coc_gas_collector_crew
	short_name = "coc_gas_collector_crew"
	name = "Coalition Gas Collection Technician"
	desc = "Crew the Coalition Gas Collection Vessel."
	tags = list("External")

	welcome_message = "As a Coalition Gas Collection crewmember, you are tasked with harvesting the gaseous atmospheres of the planets in this sector for fuel refinement, and to always keep on the lookout for a source of Phoron for the Coalition of Colonies."

	spawnpoints = list("coc_gas_collector_crew")
	max_count = 3

	outfit = /datum/outfit/admin/coc_gas_collector_crew
	possible_species = list(SPECIES_HUMAN, SPECIES_HUMAN_OFFWORLD, SPECIES_TAJARA, SPECIES_TAJARA_MSAI, SPECIES_TAJARA_ZHAN, SPECIES_DIONA, SPECIES_IPC, SPECIES_IPC_G1, SPECIES_IPC_G2, SPECIES_IPC_XION, SPECIES_IPC_ZENGHU, SPECIES_IPC_BISHOP, SPECIES_IPC_SHELL)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Coalition Gas Collection Technician"
	special_role = "Coalition Gas Collection Technician"
	respawn_flag = null

/datum/outfit/admin/coc_gas_collector_crew
	name = "Coalition Gas Collection Technician"

	uniform = /obj/item/clothing/under/tactical
	shoes = /obj/item/clothing/shoes/workboots/dark
	back = /obj/item/storage/backpack/satchel

	id = /obj/item/card/id

	l_ear = /obj/item/device/radio/headset/ship

	backpack_contents = list(/obj/item/storage/box/survival = 1)
	species_shoes = list(
		SPECIES_TAJARA = /obj/item/clothing/shoes/workboots/toeless,
		SPECIES_TAJARA_MSAI = /obj/item/clothing/shoes/workboots/toeless,
		SPECIES_TAJARA_ZHAN = /obj/item/clothing/shoes/workboots/toeless,
	)

/datum/outfit/admin/coc_gas_collector_crew/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(isoffworlder(H))
		H.equip_or_collect(new /obj/item/storage/pill_bottle/rmt, slot_in_backpack)
	if(istajara(H))
		H.equip_to_slot_or_del(new /obj/item/voidsuit_modkit/himeo/tajara, slot_r_hand)

/datum/outfit/admin/coc_gas_collector_crew/get_id_access()
	return list(access_coalition,access_external_airlocks)

/datum/ghostspawner/human/coc_gas_collection_crew/security
	short_name = "coc_gas_collector_security"
	name = "Coalition Gas Collection Security Officer"
	desc = "Act as the Security Officer of the Coalition Gas Collector Vessel."

	welcome_message = "As a Coalition Gas Collection Security Officer, you are tasked with protecting the Coalition crew during their operations."
	spawnpoints = list("coc_gas_collector_security")
	max_count = 1

	outfit = /datum/outfit/admin/coc_gas_collection_crew/security
	possible_species = list(SPECIES_HUMAN, SPECIES_HUMAN_OFFWORLD, SPECIES_TAJARA, SPECIES_TAJARA_MSAI, SPECIES_TAJARA_ZHAN, SPECIES_IPC, SPECIES_IPC_G1, SPECIES_IPC_G2, SPECIES_IPC_XION, SPECIES_IPC_ZENGHU, SPECIES_IPC_BISHOP, SPECIES_IPC_SHELL)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Coalition Gas Collection Security Officer"
	special_role = "Coalition Gas Collection Security Officer"

/datum/outfit/admin/coc_gas_collection_crew/security
	name = "Coalition Gas Collection Security Officer"

/datum/ghostspawner/human/coc_gas_collection_crew/captain
	short_name = "coc_gas_collector_captain"
	name = "Coalition Gas Collection Captain"
	desc = "Act as the Captain of the Coalition Gas Collection Vessel."

	welcome_message = "As a Coalition Gas Collection Captain, you must led the crew of your ship and ensure that fuel is gathered for the Coalition member states. And that none of the flammable gas onboard blows up."

	spawnpoints = list("coc_gas_collector_captain")
	max_count = 1

	outfit = /datum/outfit/admin/coc_gas_collection_crew/captain
	possible_species = list(SPECIES_HUMAN, SPECIES_HUMAN_OFFWORLD, SPECIES_TAJARA, SPECIES_IPC, SPECIES_IPC_G1, SPECIES_IPC_G2, SPECIES_IPC_XION, SPECIES_IPC_ZENGHU, SPECIES_IPC_BISHOP, SPECIES_IPC_SHELL)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Coalition Gas Collection Captain"
	special_role = "Coalition Gas Collection Captain"

/datum/outfit/admin/coc_gas_collection_crew/captain
	name = "Coalition Gas Collection Captain"

	back = /obj/item/storage/backpack/satchel/leather


