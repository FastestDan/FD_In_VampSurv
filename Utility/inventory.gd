extends TextureRect


var upgrade = null

func _ready() -> void:
	if upgrade != null:
		$SlotIcon.texture = load(UpgradeDb.UPGRADES[upgrade]["icon"])
