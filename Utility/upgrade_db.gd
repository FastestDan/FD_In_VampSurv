extends Node

const ICON_PATH = "res://Graphics/Upgrades/"
const WEAPON_PATH = "res://Graphics/Weapons/"
const UPGRADES = {
	"fd1":{
		"icon": WEAPON_PATH + "FDPowerIcon.png",
		"name": "FD",
		"desc": "Powerful punch, imbued with Imagination Energy",
		"level": "Lv: 1",
		"prev": ["fd1"],
		"type": "unique"
	},
	"fd2":{
		"icon": WEAPON_PATH + "FDPowerIcon.png",
		"name": "FD",
		"desc": "You punch 2 times",
		"level": "Lv: 2",
		"prev": ["fd1"],
		"type": "unique"
	},
	"fd3":{
		"icon": WEAPON_PATH + "FDPowerIcon.png",
		"name": "FD",
		"desc": "Damage, size and knockback from punches are increased",
		"level": "Lv: 3",
		"prev": ["fd2"],
		"type": "unique"
	},
	"fd4":{
		"icon": WEAPON_PATH + "FDPowerIcon.png",
		"name": "FD",
		"desc": "You punch 3 times. Damage, size and knockback from punches are increased",
		"level": "Lv: 4",
		"prev": ["fd3"],
		"type": "unique"
	},
	"alpha1":{
		"icon": WEAPON_PATH + "AlphaBlasterIcon.png",
		"name": "Alpha Blaster",
		"desc": "Energy blast, powered by Alpha Reactor",
		"level": "Lv: 1",
		"prev": ["alpha1"],
		"type": "unique"
	},
	"alpha2":{
		"icon": WEAPON_PATH + "AlphaBlasterIcon.png",
		"name": "Alpha Blaster",
		"desc": "A spear that gets thrown at random enemies",
		"level": "Lv: 2",
		"prev": ["alpha1"],
		"type": "unique"
	},
	"alpha3":{
		"icon": WEAPON_PATH + "AlphaBlasterIcon.png",
		"name": "Alpha Blaster",
		"desc": "A spear that gets thrown at random enemies",
		"level": "Lv: 3",
		"prev": ["alpha2"],
		"type": "unique"
	},
	"alpha4":{
		"icon": WEAPON_PATH + "AlphaBlasterIcon.png",
		"name": "Alpha Blaster",
		"desc": "A spear that gets thrown at random enemies",
		"level": "Lv: 4",
		"prev": ["alpha3"],
		"type": "unique"
	},

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
	"spear3":{
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
	
	"armor1":{
		"icon": ICON_PATH + "ShieldCard.png",
		"name": "Shield Card",
		"desc": "A peculiar passing-through card. Gives a little resistance against foes",
		"level": "Lv: 1",
		"prev": [],
		"type": "item"
	},
	"armor2":{
		"icon": ICON_PATH + "ShieldCard.png",
		"name": "Shield Card",
		"desc": "More resistance against foes",
		"level": "Lv: 2",
		"prev": ["armor1"],
		"type": "item"
	},
	"armor3":{
		"icon": ICON_PATH + "ShieldCard.png",
		"name": "Armor",
		"desc": "Even more resistance against foes",
		"level": "Lv: 3",
		"prev": ["armor2"],
		"type": "item"
	},
	"armor4":{
		"icon": ICON_PATH + "ShieldCard.png",
		"name": "Armor",
		"desc": "EVEN even more resistance against foes",
		"level": "Lv: 4",
		"prev": ["armor3"],
		"type": "item"
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
