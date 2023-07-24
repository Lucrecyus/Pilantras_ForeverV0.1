extends Control


var iniciar

func _ready():
	
	get_tree().set_pause(false)

func _process(_delta):
	if Input.is_action_pressed("quit"):
		iniciar = get_tree().change_scene("res://Cenas/Menu.tscn")
