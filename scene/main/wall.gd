extends TileMapLayer
signal type()
func _physics_process(delta: float) -> void:
	if $Broken_feeler/RayCast2D.is_colliding() and $Broken_feeler/RayCast2D.get_collider().is_in_group("feeler") :
		position.y-=32*6
		Globals.stage+=1
		emit_signal("type")
		if Globals.stage==4:
			hide()
			$Spawner/SpawnTimer.stop()
			$Spawner.spawn_boss()
