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
	
	"food":{
		"icon": ICON_PATH + "ICON_TEST.png",
		"name": "Food",
		"desc": "Heals for 20 HP",
		"level": "",
		"prev": [],
		"type": "item"
	},
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
