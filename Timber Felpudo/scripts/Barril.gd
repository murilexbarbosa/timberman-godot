extends Node2D


func _ready():
	pass

func dest(sent):
	if sent == -1:
		get_node("AnimationPlayer").play("direita")
	else:
		get_node("AnimationPlayer").play("esquerda")