extends Node2D


func _ready():
	$Start_text/Anim.play("modular")
	$AnimatedSprite.play("mdn")

func _on_Timer_timeout():
	$Start_text.queue_free()

func _process(_delta):
	
	if Input.is_action_pressed("quit"):
		get_tree().quit()


func _on_Area2D_body_entered(_body):
	$Label.set_visible(true)
	$Label/Anim2.play("modular")
