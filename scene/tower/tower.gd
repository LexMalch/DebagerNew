extends StaticBody2D
var building_sprite= preload("res://scene/tower/tower.png")
var price = 7
var enemys = []
var sound = preload("res://scene/sound.tscn")
var max_health = 30
var kd=false
@onready var health = max_health


func _physics_process(delta: float) -> void:
	$ProgressBar.max_value = max_health
	$ProgressBar.value = health

		
	
func take_damage(turret_damage):
	health -=turret_damage
	$ProgressBar.show()
	if health <=0:
		Globals.busy_plase.erase(global_position)
		var sound_tsn = sound.instantiate()
		sound_tsn.stream= preload("res://sounds/build_destroy.wav")
		sound_tsn.global_position =global_position
		get_parent().add_child(sound_tsn)
		queue_free()
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
func _on_kd_timer_timeout() -> void:
	kd= false

func  kd_start():
	$Kd_Timer.start()
