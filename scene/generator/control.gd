extends Control
var total_price: = 1


func _on_button_pressed() -> void:
	if Globals.reshetkas>= total_price:
		Globals.digging_speed+= round(sqrt(Globals.digging_speed))
		Globals.reshetkas-=total_price
		total_price+= round(sqrt(total_price))
		update_price()
		$HBoxContainer/LaserDamage.hide()
		await get_tree().create_timer(5).timeout
		$HBoxContainer/LaserDamage.show()


func _on_button_2_pressed() -> void:
	if Globals.reshetkas>= total_price:
		Globals.turret_damage+= round(sqrt(Globals.turret_damage))
		Globals.reshetkas-=total_price
		total_price+= round(sqrt(total_price))		
		$HBoxContainer/TurretDamage.hide()
		await get_tree().create_timer(5).timeout
		$HBoxContainer/TurretDamage.show()
		update_price()


func _on_button_3_pressed() -> void:
	if Globals.reshetkas>= total_price:
		Globals.ores+= round(sqrt(Globals.ores))
		Globals.reshetkas-=total_price
		total_price+= round(sqrt(total_price))
		update_price()		
		$HBoxContainer/OreAmount.hide()
		await get_tree().create_timer(5).timeout
		$HBoxContainer/OreAmount.show()

func update_price():
	$HBoxContainer/LaserDamage/Button/MarginContainer/HBoxContainer/Price.text=str(total_price)             
	$HBoxContainer/TurretDamage/Button2/MarginContainer/HBoxContainer/Price.text=str(total_price)  
	$HBoxContainer/OreAmount/Button3/MarginContainer/HBoxContainer/Price.text=str(total_price)                                                         
