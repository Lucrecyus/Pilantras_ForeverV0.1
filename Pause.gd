extends Control

var pause = false
var iniciar


func _ready():
	pause = false

func _input(event):
	if event.is_action_pressed("pause"):
	 
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
		pause = true


	if event.is_action_pressed("quit"):
		if get_tree().paused:
			iniciar = get_tree().change_scene("res://Cenas/Menu.tscn")
		
