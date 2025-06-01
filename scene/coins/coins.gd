extends RigidBody2D
var type
func _ready() -> void:
	if type == "$":
		$Sprite.play("bucks")
	elif type == "#":
		$Sprite.play("resh")
	#$AnimationPlayer.play("drop")
	global_position+= Vector2(round(randf_range(-10,10)),round(randf_range(-10,10)))

func explode():
	$CollisionShape2D.set_deferred("disabled","true")
	$GPUParticles2D.emitting = true
	$Sprite.hide()
	$Timer.start()
		


func _on_timer_timeout() -> void:
	queue_free()
