extends Control
func _physics_process(delta: float) -> void:
	$HBoxContainer/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/dollors.text = str(Globals.dollors)
	$HBoxContainer/MarginContainer/PanelContainer/MarginContainer/HBoxContainer/reshetkas.text = str(Globals.reshetkas)
