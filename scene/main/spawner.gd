extends Marker2D
var dir = 8
var cur_wave = 0


var Enemy = preload("res://scene/enemy/enemy_spider/enemy_spider.tscn")



func _physics_process(delta: float) -> void:
	position.x += dir 



func _on_timer_timeout() -> void:
	dir *= -1


func _on_spawn_timer_timeout() -> void:
	cur_wave+=1
	if cur_wave==5:
		cur_wave=0
		Globals.enemy_quantity+= round(sqrt(Globals.enemy_quantity))
		%EnemyWarning.start_typing()
	for i in range(Globals.enemy_quantity):
		await get_tree().create_timer(0.2).timeout
		var enemy = Enemy.instantiate()
		enemy.global_position = global_position
		get_parent().get_parent().add_child(enemy)
	if Globals.stage >=2:
		var enemy_fat = Enemy.instantiate()
		enemy_fat.global_position = global_position+Vector2(0,20)
		enemy_fat.scale.x = 2
		enemy_fat.scale.y = 2
		enemy_fat.col = Color.CRIMSON
		enemy_fat.max_speed = 30
		enemy_fat.max_health = 50
		enemy_fat.damage = 1
		get_parent().get_parent().add_child(enemy_fat)
func spawn_boss():
		var boss = Enemy.instantiate()
		boss.global_position = Vector2(300,-900)
		boss.scale.x = 5
		boss.scale.y = 5
		boss.col = Color(25,0.5,1,1)
		boss.max_speed = 200
		boss.max_health = 500
		boss.damage = 10
		get_parent().get_parent().add_child(boss)
		
		
		
		
		
		
		
		
		
		
		
		
