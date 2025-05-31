extends Label

var full_text = "The Amount of enemies has been increased!"
var current_char = 0
var typing_speed = 0.1

func _ready():
	$Timer.wait_time = typing_speed
	
	

func start_typing():
	show()
	text = ""  # Очищаем текст
	current_char = 0
	$Timer.start()



func _on_timer_timeout() -> void:
	if current_char < full_text.length():
		text += full_text[current_char]
		current_char += 1
	else:
		$Timer.stop()  # Останавливаем, когда весь текст напечатан
		await get_tree().create_timer(5).timeout
		hide()
