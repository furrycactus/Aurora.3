/datum/gear/faction
	display_name = "idris cap"
	path = /obj/item/clothing/head/soft/sec/idris
	slot = slot_head
	sort_category = "Factions"
	cost = 1
	faction = "Idris Incorporated"

/datum/gear/faction/idris_beret
	display_name = "idris beret"
	path = /obj/item/clothing/head/beret/sec/idris
	faction = "Idris Incorporated"

/datum/gear/faction/idris_uniform_alt
	display_name = "idris service skirt"
	description = "Not for security usage."
	path = /obj/item/clothing/under/rank/idris/service/alt
	slot = slot_wear_suit
	faction = "Idris Incorporated"

/datum/gear/faction/necro_beret
	display_name = "brown necropolis beret"
	path = /obj/item/clothing/head/beret/sec/necro
	faction = "Necropolis Industries"

/datum/gear/faction/necro_beret/alt
	display_name = "black necropolis beret"
	path = /obj/item/clothing/head/beret/sec/necro/alt
	sort_category = "Factions"

/datum/gear/faction/necro_uniform_alt
	display_name = "brown necropolis uniform"
	path = /obj/item/clothing/under/rank/security/necropolis/alt
	slot = slot_wear_suit
	faction = "Necropolis Industries"

/datum/gear/faction/necro_research_alt
	display_name = "brown necropolis research uniform"
	path = /obj/item/clothing/under/rank/necropolis/research/alt
	slot = slot_wear_suit
	faction = "Necropolis Industries"

/datum/gear/faction/eridani_beret
	display_name = "eridani beret"
	path = /obj/item/clothing/head/beret/sec/eri
	slot = slot_head
	faction = "Eridani Private Military Contractors"

/datum/gear/faction/zenghu_uniform_alt
	display_name = "zeng-hu black uniform"
	path = /obj/item/clothing/under/rank/zeng/alt
	slot = slot_wear_suit
	faction = "Zeng-Hu Pharmaceuticals"

/datum/gear/faction/necro_patch
	display_name = "necropolis sleeve patch"
	path = /obj/item/clothing/accessory/sleevepatch/necro
	slot = slot_tie
	faction = "Necropolis Industries"

/datum/gear/faction/necrosec_patch
	display_name = "necropolis security sleeve patch"
	path = /obj/item/clothing/accessory/sleevepatch/necrosec
	slot = slot_tie
	faction = "Necropolis Industries"
	allowed_roles = list("General Officer", "Medical Officer", "Science Officer", "Engineering Officer", "Supply Officer","Forensic Technician","Warden")

/datum/gear/faction/erisec_patch
	display_name = "EPMC sleeve patch"
	path = /obj/item/clothing/accessory/sleevepatch/erisec
	slot = slot_tie
	faction = "Eridani Private Military Contractors"

/datum/gear/faction/idrissec_patch
	display_name = "idris security sleeve patch"
	path = /obj/item/clothing/accessory/sleevepatch/idrissec
	faction = "Idris Incorporated"
	allowed_roles = list("General Officer", "Medical Officer", "Science Officer", "Engineering Officer", "Supply Officer","Detective")
