extends Button


func _on_pressed() -> void:
	Globals.turrt_bullet *=2
	queue_free()
