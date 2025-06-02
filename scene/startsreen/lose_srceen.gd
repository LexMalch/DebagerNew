extends Node2D


func _on_button_pressed():
	Globals.restart_game()
	Engine.time_scale = 1
	get_tree().reload_current_scene()
