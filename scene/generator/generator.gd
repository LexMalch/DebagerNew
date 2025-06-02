extends StaticBody2D
var max_health = 40
var kd= false
@onready var health = max_health

func _physics_process(delta: float) -> void:
	$ProgressBar.max_value = max_health
	$ProgressBar.value = health
func _on_generator_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player")or body.is_in_group("coins"):
		$Sprite.play("buid_up")
	if body.is_in_group("player"):
		$AnimationPlayer.play("shop_in")
		
		


func _on_generator_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player")  or body.is_in_group("coins"):
		$Sprite.play_backwards("buid_up")
	if body.is_in_group("player"):
		$AnimationPlayer.play_backwards("shop_in")



func _on_buildup_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("coins"):
		if body.get("type") == "#":
			Globals.reshetkas+=1
	
		else:
			Globals.dollors+=1
		
		body.explode()
func take_damage(damage):
	health -=damage
	$ProgressBar.show()
	if health <=0:
		Globals.busy_plase.erase(global_position)

		Engine.time_scale = 0
		$"../Player/CanvasLayer/Control/Lose_srceen".visible = true
		

		queue_free()	
func _on_kd_timer_timeout() -> void:
	kd= false

func  kd_start():
	$Kd_Timer.start()


func _on_healing_timer_timeout() -> void:
	if health < max_health:
		health +=2
		if health >= max_health:
			health = max_health
		if health== max_health:
			
			$ProgressBar.hide()
