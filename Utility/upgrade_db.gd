extends Node

const ICON_PATH = "res://Graphics/Upgrades/"
const WEAPON_PATH = "res://Graphics/Weapons/"
const UPGRADES = {
	"spear1":{
		"icon": WEAPON_PATH + "SPEAR_TEST.png",
		"name": "Spear",
		"desc": "A spear that gets thrown at random enemies",
		"level": "Lv: 1",
		"prev": [],
		"type": "weapon"
	},
	
	"spear2":{
		"icon": WEAPON_PATH + "SPEAR_TEST.png",
		"name": "Spear",
		"desc": "An additional spear is thrown",
		"level": "Lv: 2",
		"prev": ["spear1"],
		"type": "weapon"
	},
	
	"shippu1":{
		"icon": WEAPON_PATH + "SPEAR_TEST.png",
		"name": "Shippu",
		"desc": "A spear that gets thrown at random enemies",
		"level": "Lv: 1",
		"prev": [],
		"type": "weapon"
	},
	
	"shippu2":{
		"icon": WEAPON_PATH + "SPEAR_TEST.png",
		"name": "Shippu",
		"desc": "An additional spear is thrown",
		"level": "Lv: 2",
		"prev": ["shippu1"],
		"type": "weapon"
	},
	"shippu3":{
		"icon": WEAPON_PATH + "SPEAR_TEST.png",
		"name": "Shippu",
		"desc": "An additional spear is thrown",
		"level": "Lv: 3",
		"prev": ["shippu2"],
		"type": "weapon"
	},
	
	"food":{
		"icon": ICON_PATH + "ICON_TEST.png",
		"name": "Food",
		"desc": "Heals for 20 HP",
		"level": "",
		"prev": [],
		"type": "food"
	},
}
