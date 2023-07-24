extends Node2D

var is_on_floor = false
var iniciar
var timer = 0
var endTime = false

func _ready():
	get_tree().set_pause(false)

	$Start_dialogo.start()
	
func _process(_delta):
	$dialogo2.position = $Player.global_position
	$CanvasLayer/Tempo.set_text(String(timer))
	
	if is_on_floor and Input.is_action_pressed("usar"):
		saiuDodrone()
		
	if timer >= 130:
		fimDotempo()
		
func saiuDodrone():
	get_tree().set_pause(true)
	$dialogo2.set_visible(true)
	$Mission_failed.start()

func fimDotempo():
	$Timer.stop()
	get_tree().set_pause(true)
	$Mission_failed.start()
	$dialogo4.set_visible(true)
	$dialogo4.position = $Player.position

		
func _on_Start_dialogo_timeout():
	
	$End_dialogo.start()
	get_tree().set_pause(true)
	$dialogo1.set_visible(true)


func _on_End_dialogo_timeout():
	get_tree().set_pause(false)
	$dialogo1.set_visible(false)
	$Timer.start()


func _on_Floor_body_shape_entered(_body_id, _body, _body_shape, _area_shape):
	is_on_floor = true
	


func _on_Mission_failed_timeout():
	iniciar = get_tree().change_scene("res://Cenas/Menu.tscn")


func _on_Final_body_entered(_body):
	get_tree().set_pause(true)
	$dialogo3.set_visible(true)
	$dialogo3.position = $Player.position
	$End_stage.start()


func _on_End_stage_timeout():
	GameFases.stage4 = "complete"
	GameFases.save_data()
	$Anim.play("fade_out")
	$Sair.start()
	


func _on_Sair_timeout():
	
	iniciar = get_tree().change_scene("res://Cenas/SelectFases.tscn")


func _on_BossDrone2_tree_exited():
	$Gate.queue_free()


func _on_Timer_timeout():
	timer += 1


func _on_zonasegura_body_entered(_body):
	is_on_floor = false
