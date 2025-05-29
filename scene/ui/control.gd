extends Control
func _physics_process(delta: float) -> void:
	$MarginContainer/PanelContainer/MarginContainer/HBoxContainer/dollors.text = str(Globals.dollors)
	$MarginContainer/PanelContainer/MarginContainer/HBoxContainer/reshetkas.text = str(Globals.reshetkas)
