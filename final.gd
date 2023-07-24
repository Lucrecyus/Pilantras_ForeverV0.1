extends Node2D

var iniciar

func _on_Timer_timeout():
	$AnimationPlayer.play("fadeout")
	$continuaTimer.start()
	
func _on_continuaTimer_timeout():
	$AnimationPlayer.play("continua")

func _on_AnimationPlayer_animation_finished(_continua):
	iniciar = get_tree().change_scene("res://Cenas/Menu.tscn")



