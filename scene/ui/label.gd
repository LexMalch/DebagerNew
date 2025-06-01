extends Label

var full_text = "Stage: "+str(Globals.stage)
var current_char = 0
var typing_speed = 0.2  # Задержка между символами (в секундах)

func _ready():
	$TypeTimer.wait_time = typing_speed
	
	

func start_typing():
	show()
	if Globals.stage !=4:
		full_text = "Stage: "+str(Globals.stage)
	else:
		full_text = "FINAL STAGE"
		modulate = Color.CRIMSON
	text = ""  # Очищаем текст
	current_char = 0
	$TypeTimer.start()

func _on_type_timer_timeout():
	if current_char < full_text.length():
		text += full_text[current_char]
		current_char += 1
	else:
		$TypeTimer.stop()  # Останавливаем, когда весь текст напечатан
		await get_tree().create_timer(5).timeout
		hide()



func _on_wall_type() -> void:
	start_typing()
