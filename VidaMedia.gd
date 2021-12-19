extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")
		

func _on_VidaMedia_body_entered(body):
	body.vidamedia()
	$AnimationPlayer.play("sumir")
	
