extends Node2D

onready var marc = get_node("Marcador")

var perc = 1

signal perdeu

func _ready():
	set_process(true)
	
func _process(delta):
	if perc > 0:
		perc -= 0.1*delta
		marc.set_region_rect(Rect2(0, 0, perc*188, 23))
		marc.set_pos(Vector2(-(1-perc)*188/2,0))
	else:
		emit_signal("perdeu")
		
func add(delta):
	perc += delta
	if perc > 1:
		perc = 1
