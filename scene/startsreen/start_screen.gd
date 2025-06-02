extends Node2D
@onready var a= preload("res://scene/main/main.tscn").instantiate()
@onready var ab= preload("res://scene/sound.tscn").instantiate()
@onready var b= preload("res://scene/ui/control.tscn").instantiate()
@onready var ba= preload("res://scene/generator/generator.tscn").instantiate()
@onready var baa= preload("res://scene/tower/tower.tscn").instantiate()
@onready var baaa= preload("res://scene/turret/turret.tscn").instantiate()




func _on_button_pressed_start():
	var main = load("res://scene/main/main.tscn")
	get_tree().change_scene_to_packed(main)


func _on_button_2_pressed():
	pass
