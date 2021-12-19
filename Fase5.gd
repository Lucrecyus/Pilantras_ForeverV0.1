extends Node2D

var iniciar

func _ready():
	get_tree().set_pause(true)
	$Enter_Dialogo1.start()
	

func _on_Fechar_gate_body_entered(_body):
	GameFases.open = "fechado"


func _on_SupremeSoldier2_tree_exited():
	$Armadilha17.queue_free()


func _on_Ghost_tree_exited():
	$Armadilha18.queue_free()


func _on_exit_body_entered(_body):
	$Enter_Dialogo.start()
	GameFases.stage5 = "complete"
	GameFases.save_data()


func _on_Enter_Dialogo_timeout():

	$Dialogo.position = $Player.global_position
	get_node("Dialogo").set_visible(true)
	get_tree().set_pause(true)
	$fade_out.start()
	$Exit.start()
	

func _on_Exit_timeout():
	iniciar = get_tree().change_scene("res://Cenas/SelectFases.tscn")


func _on_fade_out_timeout():
	$Anim.play("fadeout")


func _on_Enter_Dialogo1_timeout():
	$Dialogo2.set_visible(true)
	$exit_dialogo1.start()


func _on_exit_dialogo1_timeout():
	$Dialogo2.set_visible(false)
	get_tree().set_pause(false)
