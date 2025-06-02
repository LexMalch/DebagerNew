extends StaticBody2D
var building_sprite= preload("res://scene/tower/tower.png")
var price = 0
var enemys = []

var max_health = 30

@onready var health = max_health


func _physics_process(delta: float) -> void:
	$ProgressBar.max_value = max_health
	$ProgressBar.value = health

		
	
func take_damage(turret_damage):
	health -=turret_damage
	$ProgressBar.show()
	if health <=0:
		Globals.busy_plase.erase(global_position)
		queue_free()



	




func _on_sooting_timer_timeout() -> void:
	if enemys:
		$Area2D.show()
		for enemy in enemys:
			if enemy:
				enemy.get_damage(enemy.max_health/20)
	else:
		$Area2D.hide()


func _on_healing_timer_timeout() -> void:
	if health < max_health:
		health+=4
	else:
		$ProgressBar.hide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemys"):
		enemys.append(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemys"):
		enemys.erase(body)
