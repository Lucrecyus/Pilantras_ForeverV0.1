extends StaticBody2D

var speed = 1000
var velocidade = Vector2()
var direction = 1
onready var anim_sprite: Sprite = get_node("Bala")

func _ready():
	$Anim.play("run")

func set_tiro_direction(dir):
	direction = dir
	
func _process(delta):
	
	velocidade.x = speed * delta * direction
	translate(velocidade)
			
	
func _on_VisibilityNotifier2D_screen_exited():
	destroy()

func _on_Tiro_body_entered(body):
	body.tiro()
	destroy()


func _on_Anim_animation_finished():
	destroy()

func destroy():
	queue_free()

func tiroboss():
	queue_free()
func elevador():
	pass
func saiuelevador():
	pass
func danotatu():
	pass
func cartucho():
	pass
func armadilha():
	queue_free()
	
func boombazuka():
	pass
