extends ColorRect

@onready var opname = $Name
@onready var opdesc = $Desc
@onready var oplv = $Lv
@onready var opicon = $ColorRect/Icon


var pointer = false
var item = null
@onready var player = get_tree().get_first_node_in_group("player")

signal select_upgrade(upgrade)

func _ready() -> void:
	connect("select_upgrade", Callable(player, "upgrade_player"))
	if item == null:
		item = "food"
	opname.text = UpgradeDb.UPGRADES[item]["name"]
	opdesc.text = UpgradeDb.UPGRADES[item]["desc"]
	oplv.text = UpgradeDb.UPGRADES[item]["level"]
	opicon.texture = load(UpgradeDb.UPGRADES[item]["icon"])
	
func _input(event):
	if event.is_action("click"):
		if pointer:
			emit_signal("select_upgrade", item)

func _on_mouse_entered() -> void:
	pointer = true


func _on_mouse_exited() -> void:
	pointer = false
