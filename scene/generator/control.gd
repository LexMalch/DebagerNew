extends Control


func _on_button_pressed() -> void:
	$HBoxContainer/LaserDamage.hide()
	await get_tree().create_timer(5).timeout
	$HBoxContainer/LaserDamage.show()


func _on_button_2_pressed() -> void:
	$HBoxContainer/TurretDamage.hide()
	await get_tree().create_timer(5).timeout
	$HBoxContainer/TurretDamage.show()


func _on_button_3_pressed() -> void:
	$HBoxContainer/OreAmount.hide()
	await get_tree().create_timer(5).timeout
	$HBoxContainer/OreAmount.show()
