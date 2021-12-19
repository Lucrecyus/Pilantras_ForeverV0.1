extends KinematicBody2D

var movimento = Vector2()
var velocidade = 90
const PULO = -600
const ONFLOOR = Vector2(0,-1)
var gravidade = 20
var flip = false

func _physics_process(delta):
	
	movimento.x = velocidade * delta
		
	movimento.y += gravidade
	
	if flip:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false
	
	if Input.is_action_pressed("direita"):
		movimento.x = velocidade
		$Anim.play("walk")
		flip = false
	elif Input.is_action_pressed("esquerda"):
		movimento.x = -velocidade
		flip = true
		$Anim.play("walk")
	else:
		movimento.x = 0
		$Anim.play("idle")
	
	if is_on_floor():
		if Input.is_action_pressed("pulo"):
			movimento.y = PULO
	else:
		$Anim.play("jump")
	
	movimento = move_and_slide(movimento, ONFLOOR)


func _on_Area2D_body_entered(_body):
	movimento.y = PULO
