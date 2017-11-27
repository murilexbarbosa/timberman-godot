extends Node

onready var felpudo = get_node("Felpudo")
onready var camera = get_node("Camera")

func _ready():
	set_process_input(true)
	
func _input(event):
	event = camera.make_input_local(event)
	if event.type == InputEvent.SCREEN_TOUCH and event.pressed:
		if event.pos.x < 360:
			felpudo.esq()
		else:
			felpudo.dir()
		felpudo.bater()
