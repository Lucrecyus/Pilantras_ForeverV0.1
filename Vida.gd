extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")


func _on_Vida_body_entered(body):
	body.vida()
	$AnimationPlayer.play("sumir")
	
