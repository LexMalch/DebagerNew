extends Control
func _physics_process(delta: float) -> void:
	$HBoxContainer/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/dollors.text = str(Globals.dollors)
	$HBoxContainer/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/reshetkas.text = str(Globals.reshetkas)
	$HBoxContainer/MarginContainer/PanelContainer/MarginContainer/ProgressBar.max_value = $"../../../Wall/Spawner/SpawnTimer".wait_time
	$HBoxContainer/MarginContainer/PanelContainer/MarginContainer/ProgressBar.value = $"../../../Wall/Spawner/SpawnTimer".time_left
