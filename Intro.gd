extends Node2D

var iniciar
var prosseguir = false

func _input(event):
	if event.is_action_pressed("pause") or event.is_action_pressed("Start") and prosseguir:
		iniciar = get_tree().change_scene("res://Cenas/Menu.tscn")

func _ready():
	"Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)"
	$Anim.play("label")
	
func _on_Timer_timeout():
	$Timer2.start()
	$Anim.play("shaolinDev")
	
func _on_Timer2_timeout():
	$Anim.play("historia")
	prosseguir = true
	
