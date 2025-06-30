extends Control

@onready var dan = get_node("DanSprite")

@onready var main_layout = get_node("MainLayout")
@onready var chara_layout = get_node("CharaSelectLayout")
@onready var _level = preload("res://Levels/test_place.tscn")

signal fd_set
signal alpha_set


func _ready() -> void:
	dan.animation = "Dan_Idle"
	dan.play()

func _on_play_button_click_end() -> void:
	get_tree().change_scene_to_packed(_level)
	#main_layout.visible = false
	#chara_layout.visible = true

func _on_exit_button_click_end() -> void:
	get_tree().quit()

#
#func _on_fd_button_click_end() -> void:
	#emit_signal("fd_set")
#
#
#
#func _on_alpha_button_click_end() -> void:
	#emit_signal("alpha_set")
	#get_tree().change_scene_to_packed(_level)
#
#
#func _on_back_button_click_end() -> void:
	#main_layout.visible = true
	#chara_layout.visible = false
