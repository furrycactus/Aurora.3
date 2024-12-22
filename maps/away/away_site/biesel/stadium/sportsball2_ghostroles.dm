// Base
/datum/ghostspawner/human/sportsball2
	tags = list("External")
	possible_species = list(SPECIES_HUMAN, SPECIES_IPC, SPECIES_IPC_BISHOP, SPECIES_IPC_G1, SPECIES_IPC_G2, SPECIES_IPC_SHELL, SPECIES_IPC_XION, SPECIES_IPC_ZENGHU)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY
	respawn_flag = null

// Stadium Staff
/obj/outfit/admin/sportsball2/stadium/get_id_access()
	return list(ACCESS_PORTSVILLE_STADIUM_STAFF)

/datum/ghostspawner/human/sportsball2/stadium/game_official
	short_name = "sportsball2_game_official"
	name = "MAA Game Official"
	desc = "Run the megacorporate sport event at Ports-Ville Stadium. (Volunteer Role)"
	spawnpoints = list("sportsball2_game_official")
	max_count = 1
	outfit = /obj/outfit/admin/sportsball2/game_official
	assigned_role = "Game Official (MAA/Ports-Ville Stadium)"
	special_role = "Game Official (MAA/Ports-Ville Stadium)"

/obj/outfit/admin/sportsball2/game_official
	name = "Game Official (MAA/Ports-Ville Stadium)"
	uniform = /obj/item/clothing/under/suit_jacket/navy
	shoes = /obj/item/clothing/shoes/laceup
	id = /obj/item/card/id/gold
	back = /obj/item/storage/backpack/satchel/pocketbook
	r_pocket = /obj/item/storage/wallet/random

/datum/ghostspawner/human/sportsball2/stadium/referee
	short_name = "sportsball2_referee"
	name = "Ports-Ville Stadium Referee"
	desc = "Referee the sports match at Ports-Ville Stadium. (Volunteer Role)"
	spawnpoints = list("sportsball2_referee")
	max_count = 2
	outfit = /obj/outfit/admin/sportsball2/referee
	assigned_role = "Referee (MAA/Ports-Ville Stadium)"
	special_role = "Referee (MAA/Ports-Ville Stadium)"

/obj/outfit/admin/sportsball2/referee
	name = "Referee (MAA/Ports-Ville Stadium)"
	uniform = /obj/item/clothing/under/shorts/athletic/colourable
	shoes = /obj/item/clothing/shoes/sneakers
	id = /obj/item/card/id
	back = /obj/item/storage/backpack/messenger
	r_pocket = /obj/item/storage/wallet/random

/datum/ghostspawner/human/sportsball2/stadium/security
	short_name = "sportsball2_security"
	name = "Ports-Ville Stadium Security Contractor"
	desc = "A security officer contracted from Zavodskoi Interstellar. Discreetly handle any obtuse Horizon employees. (Volunteer Role)"
	spawnpoints = list("sportsball2_security")
	max_count = 2
	outfit = /obj/outfit/admin/sportsball2/security
	assigned_role = "Security Officer (Zavod/Ports-Ville Stadium)"
	special_role = "Security Officer (Zavod/Ports-Ville Stadium)"

/obj/outfit/admin/sportsball2/security
	name = "Security Officer (Zavod/Ports-Ville Stadium)"
	uniform = /obj/item/clothing/under/rank/security/zavod/zavodsec/alt
	shoes = /obj/item/clothing/shoes/laceup
	id = /obj/item/card/id/zavodskoi
	back = /obj/item/storage/backpack/satchel/zavod
	r_pocket = /obj/item/storage/wallet/random

/datum/ghostspawner/human/sportsball2/stadium/janitor
	short_name = "sportsball2_janitor"
	name = "Ports-Ville Stadium Caretaker"
	desc = "Keep Ports-Ville Stadium's grounds clean and in good state. (Open to Anyone)"
	spawnpoints = list("sportsball2_janitor")
	max_count = 1
	outfit = /obj/outfit/admin/sportsball2/janitor
	assigned_role = "Caretaker (Ports-Ville Stadium)"
	special_role = "Caretaker (Ports-Ville Stadium)"

/obj/outfit/admin/sportsball2/janitor
	name = "Caretaker (Ports-Ville Stadium)"
	uniform = /obj/item/clothing/under/pants/jeans
	shoes = /obj/item/clothing/shoes/workboots/brown
	id = /obj/item/card/id
	back = /obj/item/storage/backpack/satchel
	suit = /obj/item/clothing/suit/storage/toggle/highvis_alt
	r_pocket = /obj/item/storage/wallet/random

/datum/ghostspawner/human/sportsball2/stadium/quickeburger
	short_name = "sportsball2_quickeburger"
	name = "Ports-Ville Stadium Quick-E-Burger Staff"
	desc = "Staff the Orion Express Quick-E-Burger restaurant inside of Ports-Ville Stadium. (Open to Anyone)"
	spawnpoints = list("sportsball2_quickeburger")
	max_count = 2
	outfit = /obj/outfit/admin/sportsball2/quickeburger
	assigned_role = "Restaurant Staff (Quick-E-Burger)"
	special_role = "Restaurant Staff (Quick-E-Burger)"

/obj/outfit/admin/sportsball2/quickeburger
	name = "Restaurant Staff (Quick-E-Burger)"
	uniform = /obj/item/clothing/under/rank/chef/orion
	shoes = /obj/item/clothing/shoes/sneakers
	id = /obj/item/card/id/orion
	back = /obj/item/storage/backpack/satchel/orion
	suit = /obj/item/clothing/accessory/apron/chef
	r_pocket = /obj/item/storage/wallet/random

/datum/ghostspawner/human/sportsball2/stadium/clinician
	short_name = "sportsball2_clinician"
	name = "Ports-Ville Stadium Clinician"
	desc = "Be a sports doctor, nurse or paramedic inside of Ports-Ville Stadium's sports clinic. (Open to Anyone)"
	spawnpoints = list("sportsball2_clinician")
	max_count = 2
	outfit = /obj/outfit/admin/sportsball2/clinician
	assigned_role = "Clinician (Ports-Ville Stadium)"
	special_role = "Clinician (Ports-Ville Stadium)"

/obj/outfit/admin/sportsball2/clinician
	name = "Clinician (Ports-Ville Stadium)"
	uniform = /obj/item/clothing/under/color/white
	shoes = /obj/item/clothing/shoes/sneakers
	id = /obj/item/card/id
	back = /obj/item/storage/backpack/satchel/med
	r_pocket = /obj/item/storage/wallet/random

// Other venues outside of ther city
/datum/ghostspawner/human/sportsball2/library_cafe
	short_name = "sportsball2_library_cafe"
	name = "Library-Cafe Owner"
	desc = "Own a barge that's been converted into a library-cafe. Serve anyone who would prefer a more cozy environment over the stadium. (Open to Anyone)"
	max_count = 1
	spawnpoints = list("sportsball2_library_cafe")
	outfit = /obj/outfit/admin/sportsball2/library_cafe
	assigned_role = "Owner (Library-Cafe)"
	special_role = "Owner (Library-Cafe)"

/obj/outfit/admin/sportsball2/library_cafe
	name = "Owner (Library-Cafe)"
	uniform = /obj/item/clothing/under/lawyer/purple
	shoes = /obj/item/clothing/shoes/sneakers/black
	back = /obj/item/storage/backpack/satchel/pocketbook
	head = /obj/item/clothing/head/festive/santa
	l_pocket = /obj/item/storage/wallet/random
	id = /obj/item/card/id

/obj/outfit/admin/sportsball2/library_cafe/get_id_access()
	return list(ACCESS_LIBRARYCAFE)

/datum/ghostspawner/human/sportsball2/lesoleilroyal_staff
	short_name = "sportsball2_lesoleilroyal_staff"
	name = "Wear Like Idris Sales Worker"
	desc = "Work a shift at the Wear Like Idris store outside of the stadium grounds. (Open to Anyone)"
	max_count = 1
	spawnpoints = list("sportsball2_lesoleilroyal_staff")
	outfit = /obj/outfit/admin/sportsball2/lesoleilroyal_staff
	assigned_role = "Sales Worker (Idris)"
	special_role = "Sales Worker (Idris)"

/obj/outfit/admin/sportsball2/lesoleilroyal_staff
	name = "Sales Worker (Wear Like Idris)"
	uniform = /obj/item/clothing/under/suit_jacket/burgundy
	shoes = /obj/item/clothing/shoes/laceup
	back = /obj/item/storage/backpack/satchel/pocketbook
	l_pocket = /obj/item/storage/wallet/random
	id = /obj/item/card/id

/obj/outfit/admin/sportsball2/lesoleilroyal_staff/get_id_access()
	return list(ACCESS_LESOLEILROYAL)

// Admin/CCIA intervention
/datum/ghostspawner/human/sportsball2/police
	short_name = "sportsball2_police"
	name = "Ports-Ville Police Department Police Officer"
	desc = "Someone is probably losing their job if you're here. (Admin/CCIA)"
	tags = list("Admin")
	spawnpoints = list("sportsball2_police")
	max_count = 2
	outfit = /obj/outfit/admin/sportsball2/police
	assigned_role = "Police Officer (PVPD)"
	special_role = "Police Officer (PVPD)"

/obj/outfit/admin/sportsball2/police
	name = "Police Officer (PVPD)"
	uniform = /obj/item/clothing/under/pants/black
	accessory = /obj/item/clothing/accessory/holster/thigh
	shoes = /obj/item/clothing/shoes/jackboots
	id = /obj/item/card/id
	l_ear = /obj/item/device/radio/headset/ert
	belt = /obj/item/storage/belt/security/full/pistol45
	r_pocket = /obj/item/storage/wallet/random
	back = /obj/item/storage/backpack/satchel/pocketbook

/obj/outfit/admin/sportsball2/police/get_id_access()
	return list(ACCESS_PORTSVILLE_STADIUM_STAFF)
