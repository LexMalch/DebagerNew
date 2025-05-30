extends PanelContainer


func _on_button_pressed() -> void:
	Globals.restart_game()
	get_tree().reload_current_scene()
