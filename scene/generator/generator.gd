extends StaticBody2D
var hp = 40


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
	hp -=damage
	
	if hp <=0:
		Globals.busy_plase.erase(global_position)

		Engine.time_scale = 0
		$"../Player/CanvasLayer/Control/Lose_srceen".visible = true
		

		queue_free()	
	

