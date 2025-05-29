extends Label

var full_text = "STAGE: 1"
var current_char = 0
var typing_speed = 0.2  # Задержка между символами (в секундах)

func _ready():
	#%Wall.type.connect(_on_wall_type)
	$TypeTimer.wait_time = typing_speed
	$TypeTimer.timeout.connect(_on_type_timer_timeout)
	start_typing()

func start_typing():
	show()
	text = ""  # Очищаем текст
	current_char = 0
	$TypeTimer.start()

func _on_type_timer_timeout():
	if current_char < full_text.length():
		text += full_text[current_char]
		current_char += 1
	else:
		$TypeTimer.stop()  # Останавливаем, когда весь текст напечатан
		await get_tree().create_timer(10).timeout
		hide()



func _on_wall_type() -> void:
	start_typing()
