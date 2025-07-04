extends CharacterBody2D


@export var speed = 50
@export var hp = 25
@export var knockback_recover = 3.5
@export var exp = 1
@export var damage = 1

var knockback = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")
@onready var loot = get_tree().get_first_node_in_group("loot")
@onready var hit_sound = $Hit
@onready var sprite = $AnimatedSprite2D
@onready var hitbox = $HitBox

var baku_anim = preload("res://Entities/Enemies/bakuhatsu.tscn")
var exp_pickup = preload("res://Entities/Objects/exp_up.tscn")

signal remove_from_array(object)

func _ready() -> void:
	hitbox.damage = damage

func _physics_process(delta: float) -> void:
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recover)
	var dir = global_position.direction_to(player.global_position)
	velocity = dir * speed
	velocity += knockback
	move_and_slide()

func ded():
	emit_signal("remove_from_array", self)
	var fuse = baku_anim.instantiate()
	fuse.scale = sprite.scale
	fuse.global_position = global_position
	get_parent().call_deferred("add_child", fuse)
	var new_up = exp_pickup.instantiate()
	new_up.global_position = global_position
	new_up.exp = exp
	loot.call_deferred("add_child", new_up)
	queue_free()


func _on_hurt_box_hurt(damage, angle, knock) -> void:
	hp -= damage
	knockback = angle * knock
	if hp <= 0:
		ded()
	else:
		hit_sound.play()
