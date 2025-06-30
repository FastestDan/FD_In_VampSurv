extends Button

signal click_end()



func _on_mouse_entered() -> void:
	$hover_on.play()

func _on_pressed() -> void:
	#$click_on.play()
	emit_signal("click_end")
	
#func _on_click_on_finished() -> void:
	#emit_signal("click_end")
