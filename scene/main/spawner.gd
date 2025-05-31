extends Marker2D
var dir = 8
var cur_wave = 0

var Enemy = preload("res://scene/enemy/enemy_spider/enemy_spider.tscn")
func _physics_process(delta: float) -> void:
	position.x += dir 



func _on_timer_timeout() -> void:
	dir *= -1


func _on_spawn_timer_timeout() -> void:
	for i in range(Globals.enemy_quantity):
		await get_tree().create_timer(0.2).timeout
		var enemy = Enemy.instantiate()
		enemy.global_position = global_position
		get_parent().get_parent().add_child(enemy)
		cur_wave+=1
		print(cur_wave)
		if cur_wave==5:
			cur_wave=0
			Globals.enemy_quantity+= round(sqrt(Globals.enemy_quantity))
			%EnemyWarning.start_typing()
