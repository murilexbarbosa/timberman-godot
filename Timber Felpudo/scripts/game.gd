extends Node

var barril = preload("res://scenes/Barril.tscn")
var barrilDir = preload("res://scenes/BarrilDir.tscn")
var barrilEsq = preload("res://scenes/BarrilEsq.tscn")

onready var felpudo = get_node("Felpudo")
onready var camera = get_node("Camera")
onready var barris = get_node("Barris")
onready var destbarris = get_node("DestBarris")

var ultini

func _ready():
	randomize()
	set_process_input(true)
	
	gerarIni()
	
func _input(event):
	event = camera.make_input_local(event)
	if event.type == InputEvent.SCREEN_TOUCH and event.pressed:
		if event.pos.x < 360:
			felpudo.esq()
		else:
			felpudo.dir()
		felpudo.bater()

func aleaBarril(pos):
	var num = rand_range(0,3)
	if ultini:
		num = 0
	gerarBarril(int(num),pos)

func gerarBarril(tipo, pos):
	var novo
	if tipo == 0:
		ultini = false
		novo = barril.instance()
	elif tipo == 1:
		ultini = true
		novo = barrilEsq.instance()
		novo.add_to_group("barrilEsq")
	elif tipo == 2:
		ultini = false
		novo = barrilDir.instance()
		novo.add_to_group("barrilDir")
	
	novo.set_pos(pos)
	barris.add_child(novo)
	
func gerarIni():
	for i in range(0,3):
		gerarBarril(0,Vector2(360,1090 - i*172))
	
	for i in range(0,10):
		aleaBarril(Vector2(360,1090 - i*172))