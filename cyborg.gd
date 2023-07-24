extends KinematicBody2D

var pos_inicial
var pos_final
var velocidade = 2
var flip = false

func _ready():
	$Anim.play("run")
	pos_inicial = $".".position.x
	pos_final = pos_inicial + 400


func _process(_delta):
	if flip:
		$Anim.flip_h = true
	else:
		$Anim.flip_h = false
	
	if pos_inicial <= pos_final and !flip:
	
		$".".position.x += velocidade
		
		if $".".position.x >= pos_final:

			flip = true
	
	if $".".position.x >= pos_inicial and flip:
		$".".position.x -= velocidade
		if $".".position.x <= pos_inicial:
			flip = false
	
	
	if Input.is_action_pressed("quit"):
		get_tree().quit()





func _on_Colisor_body_entered(_body):
	queue_free()
