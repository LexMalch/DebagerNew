extends CharacterBody2D
var max_speed = 100
@onready var cave: = $/root/Main/Cave

var	build_mode = false
var	fight_mode = false
var	dig_mode = false 
var dig_av= true
var build_sprite =  preload("res://art/pics/otv.png")
var fight_sprite =  preload("res://art/pics/evil_robot.png")
var dig_sprite =  preload("res://scene/laser/sprite/laser_use4.png")

func _physics_process(delta: float) -> void:
	var direction = movement_vector().normalized()
	velocity = max_speed * direction * delta * max_speed
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false	
		$AnimatedSprite2D.play("run_right")

	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = true	
		$AnimatedSprite2D.play("run_right")
		
	elif velocity.y > 0:
		$AnimatedSprite2D.play("run_down")

	elif velocity.y < 0:

		$AnimatedSprite2D.play("run_up")
	else:
		$AnimatedSprite2D.play("idle")
	move_and_slide()
	if Input.is_action_just_pressed("zoom_in"):
		$Camera2D.zoom+= Vector2(0.1,0.1)
		
	if Input.is_action_just_pressed("zoom_out") and $Camera2D.zoom>= Vector2(1.0, 1.0):
		$Camera2D.zoom-= Vector2(0.1,0.1)
	if Input.is_action_just_pressed("zoom_reset"):
		$Camera2D.zoom = Vector2(1.0,1.0)
	if Input.is_action_pressed("lmb"):
		if dig_mode ==true and dig_av== true:
			$Laser/AudioStreamPlayer.volume_db = -10
			if $Laser/Beam.get_collider() and $Laser/Beam.get_collider().get("name") == "Cave":
				var colider = $Laser/Beam.get_collider_rid()
				
				cave.damage_tile(colider,min(Globals.digging_speed,9))
				%digging.pitch_scale= randf_range(0.8,1.2)
				%digging.play()
				dig_av= false
				$dig_timer.start()
		if fight_mode== true:
			$Laser/AudioStreamPlayer.volume_db = -10
			if $Laser/Beam.get_collider() and $Laser/Beam.get_collider().is_in_group("enemys") and $Laser/Beam.get_collider().kd!= true:
				
				var colider = $Laser/Beam.get_collider()
				colider.get_damage(Globals.digging_speed)
				colider.kd = true
				colider.kd_start()
			else: return
	else:
		$Laser/AudioStreamPlayer.volume_db = -80
	if Input.is_action_just_pressed("dig_mode"):
		if dig_mode ==false:
			set_mode("1")
		else:
			set_mode("0")
	if Input.is_action_just_pressed("fight_mode"):
		if fight_mode ==false:
			set_mode("2")
		else:
			set_mode("0")
	if Input.is_action_pressed("rmb") and dig_mode ==true:
		$suck/CollisionShape2D.disabled =false
		$GPUParticles2D.emitting = true
	else:
		$suck/CollisionShape2D.disabled =true
		$GPUParticles2D.emitting = false
func movement_vector():
	var movement_x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var movement_y = Input.get_action_strength("down") - Input.get_action_strength("up")
	return Vector2(movement_x,movement_y) 
func set_mode(mode):
	if mode == "1":
		%Laser/Beam_line.default_color = Color(0.16,0.89,1,1)
		%Laser/Touch_animation.modulate = Color(1,1,1,1)
		build_mode = false
		fight_mode = false
		dig_mode = true
		$Tool.texture = dig_sprite
	if mode == "2":
		%Laser/Beam_line.default_color = Color(0.708,0.19,0.12,1)
		%Laser/Touch_animation.modulate = Color(0.93,0.18,0.19,1)
		build_mode = false
		fight_mode = true
		dig_mode = false
		$Tool.texture = fight_sprite
	if mode == "3":
		build_mode = true
		fight_mode = false
		dig_mode = false
		$Tool.texture = build_sprite
	if mode == "0":
		build_mode = false
		fight_mode = false
		dig_mode = false
		$Tool.texture = null


func _on_dig_timer_timeout() -> void:
	dig_av= true


func _on_audio_stream_player_finished():
	$Laser/AudioStreamPlayer.play()
