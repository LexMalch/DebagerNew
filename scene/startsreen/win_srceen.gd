extends Node2D


func _on_button_pressed():
	Engine.time_scale = 1
	var start = load("res://scene/startsreen/start_screen.tscn")
	get_tree().change_scene_to_packed(start)
