extends AudioStreamPlayer2D

func _ready() -> void:
	play()
	$Timer.start()
func play_sound(sound,pos):

	play()
	$Timer.start()
	


func _on_timer_timeout() -> void:
	queue_free()
