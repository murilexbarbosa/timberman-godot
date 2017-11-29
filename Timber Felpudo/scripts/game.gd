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
		
		if !verif():
			felpudo.bater()
			var prim = barris.get_children()[0]
			barris.remove_child(prim)
			destbarris.add_child(prim)
			prim.dest(felpudo.lado)
			aleaBarril(Vector2(360, 1090-10*172))
			
			descer()
			if verif():
				perder()
		else:
			perder()

func aleaBarril(pos):
	var num = rand_range(0,3)
	if ultini:
		num = 0
	gerarBarril(int(num),pos)

func gerarBarril(tipo, pos):
	var novo
	if tipo == 0:
		novo = barril.instance()
		ultini = false
	elif tipo == 1:
		novo = barrilEsq.instance()
		novo.add_to_group("barrilEsq")
		ultini = true
	elif tipo == 2:
		novo = barrilDir.instance()
		novo.add_to_group("barrilDir")
		ultini = false
	
	novo.set_pos(pos)
	barris.add_child(novo)
	
func gerarIni():
	for i in range(0,3):
		gerarBarril(0,Vector2(360,1090 - i*172))
	
	for i in range(3,10):
		aleaBarril(Vector2(360,1090 - i*172))
		
func verif():
	var lado = felpudo.lado
	var prim = barris.get_children()[0]
	
	if (lado == felpudo.ESQ and prim.is_in_group("barrilEsq")) or (lado == felpudo.DIR and prim.is_in_group("barrilDir")):
		return true
	else:
		return false
		
func descer():
	for b in barris.get_children():
		b.set_pos(b.get_pos()+Vector2(0,172))

func perder():
	felpudo.morrer()