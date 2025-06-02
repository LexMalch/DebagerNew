extends Node2D


func _on_button_pressed_start():
	var main = load("res://scene/main/main.tscn")
	get_tree().change_scene_to_packed(main)


func _on_button_2_pressed():
	pass
