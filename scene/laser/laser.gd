extends Node2D
const max_range = 50
var shoot = false
func _physics_process(delta):
	var mouse_pos = get_local_mouse_position()
	var max_cast_range = mouse_pos.normalized() * max_range
	$Beam.target_position = max_cast_range
	if $Beam.get_collider():
		$AudioStreamPlayer.play()
		$Touch_animation.rotation = (get_angle_to(get_global_mouse_position()))
		$Touch_animation.global_position = $Beam.get_collision_point()
		$Beam_line.set_point_position(1,$Beam_line.to_local($Touch_animation.global_position))
	else:
		$AudioStreamPlayer.play()
		$Touch_animation.rotation = (get_angle_to(get_global_mouse_position()))
		$Touch_animation.position = $Beam.target_position
		$Beam_line.points[1] = $Touch_animation.position
	if shoot == true:
		$Beam_line.visible = true
		$Touch_animation.visible = true
	else:
		$Beam_line.visible = false
		$Touch_animation.visible = false
	if Input.is_action_pressed("lmb") and (get_parent().fight_mode or get_parent().dig_mode):
		shoot = true
	else:
		shoot = false
