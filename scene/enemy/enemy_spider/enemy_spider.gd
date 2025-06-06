extends CharacterBody2D
var max_speed = 50
var  max_health: float  = 10
var damage = 2
var col = Color(1,1,1,1)
var is_boss = false
enum State {
	MOVING_DOWN,
	MOVING_TO_TARGET,
	ATTACK
}
var state = State.MOVING_DOWN
@onready var health = max_health
@onready var nav_ag : = $NavigationAgent2D as NavigationAgent2D
var targets = []
var nearest_body  
var direction = Vector2.DOWN
var attack_target
var kd= false

func _ready() -> void:
	modulate = col
	$AudioStreamPlayer2D2.play()
	await get_tree().create_timer(1).timeout
	$AudioStreamPlayer2D2.queue_free()
func _physics_process(delta: float) -> void:
	velocity = direction * max_speed
	$ProgressBar.max_value = max_health
	$ProgressBar.value = health
	match state:
		State.MOVING_DOWN:
			direction = Vector2.DOWN
			lock_at_dir(global_position+ Vector2.DOWN)
			move_and_slide()
		State.MOVING_TO_TARGET:
			makepath()
			direction = to_local(nav_ag.get_next_path_position()).normalized()
			lock_at_dir(nav_ag.get_next_path_position())
			move_and_slide()
		State.ATTACK:
			pass



func makepath() -> void:
	nav_ag.target_position = nearest_body.global_position

func change_state(new_state:State):
	if new_state == State.ATTACK:
		$Attack_Timer.start()
		$Sprites/Spider_legs.pause()
		
	else:
		$Attack_Timer.stop()
		$Sprites/Spider_legs.play()
	
	state = new_state
	



func lock_at_dir(dir):
	$Sprites/Spider_body.look_at(dir)
	$Sprites/Spider_legs.look_at(dir)
	$Spider_head.look_at(dir)
	
func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("ally"):
		targets.append(body)
		update_nearest_body()
		if state == State.MOVING_DOWN:
			change_state(State.MOVING_TO_TARGET)
		
func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("ally"):
		targets.erase(body)
		update_nearest_body()
		if targets.is_empty():
			change_state(State.MOVING_DOWN)
		else:
			change_state(State.MOVING_TO_TARGET)
func update_nearest_body():
	if targets.is_empty():
		nearest_body = null
		return
	

	nearest_body = targets[0]
	var nearest_distance = global_position.distance_to(nearest_body.global_position)
	
	for body in targets:
		if body:
			var dist = global_position.distance_to(body.global_position)
			if dist < nearest_distance:
				nearest_distance = dist
				nearest_body = body



func _on_spider_head_body_entered(body: Node2D) -> void:
	if body.is_in_group("ally"):
		attack_target = body
		change_state(State.ATTACK)
		



func _on_attack_timer_timeout() -> void:
	if state == State.ATTACK and  attack_target:
		attack_target.take_damage(damage)
		$Bite.play("bite1")
		


func _on_spider_head_body_exited(body: Node2D) -> void:
	attack_target = null
	$Bite.stop()

func get_damage(damage_amount):
	$ProgressBar.show()
	health -= damage_amount
	health = clamp(health, 0, max_health)
	$AudioStreamPlayer2D.play()
	if health <= 0:
		if is_boss == true:
			Engine.time_scale = 0
			$"../Player/CanvasLayer/Control/Win_srceen".visible = true
		queue_free()


func _on_kd_timer_timeout() -> void:
	kd= false

func  kd_start():
	$Kd_Timer.start()
