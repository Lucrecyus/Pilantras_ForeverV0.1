extends Node2D

var iniciar


func _ready():
	get_tree().set_pause(false)

func _on_Timer_timeout():
	iniciar = get_tree().change_scene("res://Cenas/final.tscn")
