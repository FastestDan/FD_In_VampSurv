extends CharacterBody2D


var SPEED = 150.0
var hp = 101
var max_hp = 100
var prev_direction = Vector2.RIGHT
var exp = 0
var player_level = 1
var all_exp = 0
var time = 0
var stango = 0
var warewa = "FD"


# Тут находятся оружия (смысл этого хардкода, если VampSurv - рогалик - непонятно)
var fd = preload("res://Entities/Weapons/fd.tscn")
var alpha = preload("res://Entities/Weapons/alpha.tscn")
var spear = preload("res://Entities/Weapons/spear.tscn")
var shippu = preload("res://Entities/Weapons/shippu.tscn")
var stick = preload("res://Entities/Weapons/stick.tscn")



@onready var fdtimer: Timer = get_node("%FDTimer")
@onready var fdattacktimer: Timer = fdtimer.get_node("%FDAttackTimer")
@onready var alphatimer: Timer = get_node("%AlphaTimer")
@onready var alphaattacktimer: Timer = alphatimer.get_node("%AlphaAttackTimer")
@onready var speartimer: Timer = get_node("%SpearTimer")
@onready var spearattacktimer: Timer = speartimer.get_node("%SpearAttackTimer")
@onready var shipputimer: Timer = get_node("%ShippuTimer")
@onready var shippuattacktimer: Timer = shipputimer.get_node("%ShippuAttackTimer")
@onready var stickbase = get_node("%Stick")


var fd_bullets = 0
var fd_magazine = 0
var fd_switch = false
var fd_speed = 1.5
var fd_level = 0

var alpha_bullets = 0
var alpha_magazine = 0
var alpha_speed = 2
var alpha_level = 0

var spear_bullets = 0
var spear_magazine = 0
var spear_speed = 1.5
var spear_level = 0

var shippu_bullets = 0
var shippu_magazine = 0
var shippu_speed = 3
var shippu_level = 0

var stick_bullets = 0
var stick_level = 0

var enemy_near = []

@onready var expBar = get_node("%EXP_Bar")
@onready var lv_label = get_node("%LEVEL")
@onready var lvup = get_node("%LvUP")
@onready var up_opts = get_node("%UP_Options")
@onready var up_sound = get_node("%UP_sound")
@onready var option = preload("res://Utility/weap_item.tscn")
@onready var hpbar = get_node("%HP_Bar")
@onready var hpval = get_node("%HP")
@onready var clock = get_node("%ClockTime")
@onready var weaponsgot = get_node("%WeaponsGot")
@onready var itemsgot = get_node("%ItemsGot")
@onready var packslot = preload("res://Utility/Inventory.tscn")

@onready var DV = get_node("%DeathVic")
@onready var dvres = get_node("%DV_Results")
@onready var death_sound = get_node("%Death_sound")
@onready var vic_sound = get_node("%Vic_sound")

signal playerdeath


var backpack = []
var choptions = []
var armor = 0
var cooldown = 0
var add_size = 0
var more = 0

func _ready() -> void:
	lvup.visible = false
	match warewa:
		"FD":
			$AnimatedSprite2D.animation = "FD_OB_Idle"
			upgrade_player("fd1")
		"Alpha":
			$AnimatedSprite2D.animation = "A_B_Idle"
			upgrade_player("alpha1")
	attack()
	_on_hurt_box_hurt(0, 0, 0)
	set_expBar(exp, cap_calc())

func _physics_process(delta: float) -> void:
	movement()
	
func movement():
	var vec = Input.get_vector("go_left", "go_right", "go_up", "go_down")
	var leri = 0
	if vec != Vector2.ZERO:
		prev_direction = vec.round()
	velocity = vec.normalized() * SPEED
	#print(velocity)
	#if velocity.length() > 0:
		#$AnimatedSprite2D.play()
	#else:
		#$AnimatedSprite2D.stop()
	move_and_slide()
	#if velocity.x != 0:
		#$AnimatedSprite2D.animation = "walk"
		#$AnimatedSprite2D.flip_h = velocity.x < 0
	if velocity.x != 0 or velocity.y != 0:
		stango = 1
		match warewa:
			"FD":
				if velocity.x < 0:
					$AnimatedSprite2D.animation = "FD_OB_Move_Mirror"
				else:
					$AnimatedSprite2D.animation = "FD_OB_Move"
			"Alpha":
				$AnimatedSprite2D.animation = "A_B_Move"
	elif velocity.x == 0 and velocity.y == 0 and stango == 1:
		stango = 0
		match warewa:
			"FD":
				if prev_direction.x < 0:
					$AnimatedSprite2D.animation = "FD_OB_Idle_Mirror"
				else:
					$AnimatedSprite2D.animation = "FD_OB_Idle"
			"Alpha":
				$AnimatedSprite2D.animation = "A_B_Idle"
	$AnimatedSprite2D.flip_h = prev_direction.x < 0
	$AnimatedSprite2D.play()


func attack():
	if fd_level > 0:
		fdtimer.wait_time = fd_speed * (1 - cooldown)
		if fdtimer.is_stopped():
			fdtimer.start()
			
	if alpha_level > 0:
		alphatimer.wait_time = alpha_speed * (1 - cooldown)
		if alphatimer.is_stopped():
			alphatimer.start()	

	if spear_level > 0:
		speartimer.wait_time = spear_speed * (1 - cooldown)
		if speartimer.is_stopped():
			speartimer.start()
			
	if shippu_level > 0:
		shipputimer.wait_time = shippu_speed * (1 - cooldown)
		if shipputimer.is_stopped():
			shipputimer.start()
			
	if stick_level > 0:
		spawn_stick()

func _on_hurt_box_hurt(damage, _angle, _knockback) -> void:
	hp -= clamp(damage-armor, 1.0, 999.0)
	hpbar.max_value = max_hp
	hpbar.value = hp
	hpval.text = str("HP: ", int(hp), "/", int(max_hp))
	if hp <= 0:
		gameover()
	#print(hp)

func gameover():
	DV.visible = true
	emit_signal("playerdeath")
	get_tree().paused = true
	var tween = DV.create_tween()
	tween.tween_property(DV, "position", Vector2(660.5, 249.5), 1.0).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	if time >= 300:
		dvres.text = "You WIN!"
	else:
		dvres.text = "You LOSE!"

func _on_fd_timer_timeout() -> void:
	fd_bullets += fd_magazine + more
	fd_switch = false
	fdattacktimer.start()

func _on_fd_attack_timer_timeout() -> void:
	if fd_bullets > 0:
		var fd_attack = fd.instantiate()
		fd_attack.position = position
		fd_attack.last_move = prev_direction
		fd_attack.level = fd_level
		fd_attack.leri = fd_switch
		add_child(fd_attack)
		fd_switch = not(fd_switch)
		fd_bullets -= 1
		if fd_bullets > 0:
			fdattacktimer.start()
		else:
			fdattacktimer.stop()
			
			
func _on_alpha_timer_timeout() -> void:
	alpha_bullets += alpha_magazine + more
	alphaattacktimer.start()


func _on_alpha_attack_timer_timeout() -> void:
	if alpha_bullets > 0:
		var alpha_attack = alpha.instantiate()
		alpha_attack.position = position
		alpha_attack.last_move = prev_direction
		alpha_attack.level = alpha_level
		add_child(alpha_attack)
		alpha_bullets -= 1
		if alpha_bullets > 0:
			alphaattacktimer.start()
		else:
			alphaattacktimer.stop()


func _on_spear_timer_timeout() -> void:
	spear_bullets += spear_magazine + more
	spearattacktimer.start()

func _on_spear_attack_timer_timeout() -> void:
	if spear_bullets > 0:
		var spear_attack = spear.instantiate()
		spear_attack.position = position
		spear_attack.target = get_random_target()
		spear_attack.level = spear_level
		add_child(spear_attack)
		spear_bullets -= 1
		if spear_bullets > 0:
			spearattacktimer.start()
		else:
			spearattacktimer.stop()
			
			
func _on_shippu_timer_timeout() -> void:
	shippu_bullets += shippu_magazine + more
	shippuattacktimer.start()

func _on_shippu_attack_timer_timeout() -> void:
	if shippu_bullets > 0:
		var shippu_attack = shippu.instantiate()
		shippu_attack.position = position
		shippu_attack.last_move = prev_direction
		shippu_attack.level = shippu_level
		add_child(shippu_attack)
		shippu_bullets -= 1
		if shippu_bullets > 0:
			shippuattacktimer.start()
		else:
			shippuattacktimer.stop()
			

func spawn_stick():
	var all_sticks = stickbase.get_child_count()
	var charge = stick_bullets - all_sticks
	while charge > 0:
		var newstick = stick.instantiate()
		newstick.position = position
		stickbase.add_child(newstick)
		charge -=1

		
func get_random_target():
	if enemy_near.size() > 0:
		return enemy_near.pick_random().global_position
	else:
		return prev_direction


func _on_teki_detector_body_entered(body: Node2D) -> void:
	if not enemy_near.has(body):
		enemy_near.append(body)


func _on_teki_detector_body_exited(body: Node2D) -> void:
	if enemy_near.has(body):
		enemy_near.erase(body)


func _on_grabber_area_entered(area: Area2D) -> void:
	if area.is_in_group("loot"):
		area.target = self


func _on_collector_area_entered(area: Area2D) -> void:
	if area.is_in_group("loot"):
		var exp_get = area.picked()
		exp_calc(exp_get)
		
		
func exp_calc(exp_get):
	var exp_left = cap_calc()
	all_exp += exp_get
	if exp + all_exp >= exp_left:
		all_exp -= exp_left - exp
		player_level += 1
		exp = 0
		exp_left = cap_calc()
		levelup()
	else:
		exp += all_exp
		all_exp = 0
	
	set_expBar(exp, exp_left)
	
func cap_calc():
	var cap = player_level
	if player_level < 20:
		cap = player_level * 5
	elif player_level < 40:
		cap = 95 * (player_level-19) * 8
	else:
		cap = 255 + (player_level - 39) * 12
	return cap

func levelup():
	up_sound.play()
	lv_label.text = str("Lv: ", player_level)
	var tween = lvup.create_tween()
	tween.tween_property(lvup, "position", Vector2(660.5, 249.5), 0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween.play()
	lvup.visible = true
	var options = 0
	var allop = 3
	var op_ar = []
	while options < allop:
		var choice = option.instantiate()
		choice.item = get_random_item()
		up_opts.add_child(choice)
		options += 1
	get_tree().paused = true
	
func upgrade_player(upgrade):
	match upgrade:
		"alpha1":
			alpha_level = 1
			alpha_magazine +=1
		"alpha2":
			alpha_level = 2
			alpha_speed = 1.0
		"alpha3":
			alpha_level = 3
			alpha_magazine +=1
		"alpha4":
			alpha_level = 4
			alpha_magazine +=1
			
		"fd1":
			fd_level = 1
			fd_magazine +=1
		"fd2":
			fd_level = 2
			fd_magazine +=1
		"fd3":
			fd_level = 3
		"fd4":
			fd_level = 4
			fd_magazine +=1
			
		"spear1":
			spear_level = 1
			spear_magazine +=1
		"spear2":
			spear_level = 2
			spear_magazine +=1
		"spear3":
			spear_level = 3
		"spear4":
			spear_level = 4
			spear_magazine +=1
			
		"shippu1":
			shippu_level = 1
			shippu_magazine +=1
		"shippu2":
			shippu_level = 2
			shippu_magazine +=1
		"shippu3":
			shippu_level = 3
			shippu_magazine +=1
		"shippu4":
			shippu_level = 4
			shippu_magazine +=1
			
		"armor1", "armor2", "armor3", "armor4":
			armor += 1.5
			
		"food":
			hp += 20
			hp = clamp(hp, 0, max_hp)
	print("Choice: ", upgrade)
	
	display_pack(upgrade)
	attack()
	var options = up_opts.get_children()
	for i in options:
		i.queue_free()
	choptions.clear()
	backpack.append(upgrade)
	lvup.visible = false
	lvup.position = Vector2(2130.0, 249.5)
	get_tree().paused = false
	exp_calc(0)

func set_expBar(now_val=1, max_val=100):
	expBar.value = now_val
	expBar.max_value = max_val
	
func get_random_item():
	var db = []
	for i in UpgradeDb.UPGRADES:
		if i in backpack:
			pass
		elif i in choptions:
			pass
		elif UpgradeDb.UPGRADES[i]["type"] == "food":
			pass
		elif UpgradeDb.UPGRADES[i]["prev"].size() > 0:
			for j in UpgradeDb.UPGRADES[i]["prev"]:
				if not j in backpack:
					pass
				else:
					db.append(i)
					
		else:
			db.append(i)
	if db.size() > 0:
		var random = db.pick_random()
		choptions.append(random)
		return random
	else:
		return null
		
func change_time(argtime = 0):
	time = argtime
	var min = int(time / 60.0)
	var sec = time % 60
	if min < 10:
		min = str(0, min)
	if sec < 10:
		sec = str(0, sec)
	clock.text = str(min, ":", sec)
	
func display_pack(upgrade):
	var name = UpgradeDb.UPGRADES[upgrade]["name"]
	var type = UpgradeDb.UPGRADES[upgrade]["type"]
	if type != "food":
		var collected = []
		for i in backpack:
			collected.append(UpgradeDb.UPGRADES[i]["name"])
		print("Collected: ", collected)
		if name not in collected:
			var slot = packslot.instantiate()
			slot.upgrade = upgrade
			match type:
				"unique", "weapon":
					weaponsgot.add_child(slot)
					print("Pack weapon: ", upgrade)
				"item":
					itemsgot.add_child(slot)
					print("Pack item: ", upgrade)


func _on_menu_btn_click_end() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Utility/title_screen.tscn")
