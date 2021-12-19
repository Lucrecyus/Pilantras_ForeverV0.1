extends KinematicBody2D

var movimento = Vector2()
export var velocidade = 120
export var gravidade = 20
const PULO = - 500
const FLOOR_NORMAL = Vector2(0, -1)
var atack = false
var flip = false
export var damage = 100
const DANOQUEDA = 10
export var dano_soco = 1
export var dano_socoforte = 2
export var dano_chute = 3
export var dano_tiro = 5
export var danogranada = 10
export var danobazuka = 20
var iniciar
var morreu = false
var atirar = false
const TIRO = preload("res://Cenas/Tiro.tscn")
const GRANADA = preload("res://Cenas/Granada.tscn")
const BAZZOKA = preload("res://Cenas/Bazzoka.tscn")
const BULLET = preload("res://Cenas/Bullet.tscn")
const SHIELD = preload("res://Cenas/Shield_player.tscn")
export var balas = 15
export var granadas = 0
export var missel = 0
var vida_maxima = 100
var vida_media = 50
var noelevador = false
var dano = false
var idle = true
var run = false
var agachado = false
var ataqueUp = false
var change_weapon = 1
export var escudo = 0
var player_name = ""
var _id = ""
var animation = "Idle_R"
puppet var puppet_animation = "Idle_R" 
puppet var puppet_idle = false
puppet var puppet_dano = false
puppet var puppet_atack = false
puppet var puppet_run = false
puppet var puppet_agachado = false
puppet var puppet_atirar = false
puppet var puppet_morreu = false
puppet var puppet_noelevador = false
puppet var puppet_flip = false
puppet var puppet_atackUp = false
var is_master = false

func initialize(id):
	name = str(id)
	
	if id == Network.net_id:
		is_master = true
	else:
		modulate = Color(1,1,0)

func _ready():
	_update_health_bar()
	#Player_name.text = player_name
	
func _physics_process(delta):

	if is_master:
		
		if !morreu:
			
			movimento.x = velocidade * delta
		
			movimento.y += gravidade
			_update_health_bar()
				
			if Input.is_action_pressed("direita"):
				direita()
				if ! is_network_master():
					rpc("direita")
				
			
			elif Input.is_action_pressed("esquerda"): 
				esquerda()
				if ! is_network_master():
					rpc("esquerda")
					
					
			elif Input.is_action_pressed("baixo"): 
		
					rpc("agachar")
		
			else:
				$CollisionShape2D.disabled = false
				$DashD/CollisionShape2D.disabled = false
				$DashE/CollisionShape2D.disabled = false
				$Agachado.disabled = true
				parado()
				if ! is_network_master():
					rpc("parado")
	
			
			if agachado == false:
				$CollisionShape2D.disabled = false
				
			if Input.is_action_just_pressed("ataque") and !agachado and !ataqueUp and !dano:
					rpc("ataque")	
		
			if Input.is_action_just_pressed("ataque1") and !ataqueUp and !agachado and !dano:
		
					rpc("ataque1")
		
			
			if Input.is_action_just_pressed("ataque2") and !agachado and !ataqueUp and !dano:
			
					rpc("ataque2")
		
			
			if Input.is_action_just_pressed("tiro") and atirar == false and balas > 0 and change_weapon == 1:
				
				rpc("shoot")
		#Contagem de balas
			$CanvasLayer/Label.set_text(String(balas))
		
			if Input.is_action_just_pressed("tiro") and atirar == false and granadas > 0 and change_weapon == 0:
				rpc("jogargranada")
			$CanvasLayer/granadas.set_text(String(granadas))
		
			if Input.is_action_just_pressed("tiro") and atirar == false and missel > 0 and change_weapon == 2:

				rpc("tirobazzoka")
			$CanvasLayer/misseis.set_text(String(missel))
		
			if Input.is_action_just_pressed("tiro") and atirar == false and escudo > 0 and change_weapon == 3:
			
				rpc("get_shield")
			$CanvasLayer/barreira.set_text(String(escudo))
			
		
			if Input.is_action_just_pressed("tiro") and balas == 0 and change_weapon == 1:
				$clicFX.play()
			if Input.is_action_just_pressed("trocararma") and change_weapon == 1:
				get_node("CanvasLayer/selected").set_visible(false)
				get_node("CanvasLayer/selected2").set_visible(true)
				get_node("CanvasLayer/selected3").set_visible(false)
				get_node("CanvasLayer/selected4").set_visible(false)
				change_weapon -= 1
		
			
			elif change_weapon == 0 and Input.is_action_just_pressed("trocararma"):
				change_weapon += 2
				get_node("CanvasLayer/selected").set_visible(false)
				get_node("CanvasLayer/selected2").set_visible(false)
				get_node("CanvasLayer/selected3").set_visible(true)
				get_node("CanvasLayer/selected4").set_visible(false)
			
			elif change_weapon == 2 and Input.is_action_just_pressed("trocararma"):
				get_node("CanvasLayer/selected").set_visible(false)
				get_node("CanvasLayer/selected2").set_visible(false)
				get_node("CanvasLayer/selected3").set_visible(false)
				get_node("CanvasLayer/selected4").set_visible(true)
				change_weapon += 1
			
			elif change_weapon == 3 and Input.is_action_just_pressed("trocararma"):
				get_node("CanvasLayer/selected").set_visible(true)
				get_node("CanvasLayer/selected2").set_visible(false)
				get_node("CanvasLayer/selected3").set_visible(false)
				get_node("CanvasLayer/selected4").set_visible(false)
				change_weapon -= 2
		
			if is_on_floor():
				if Input.is_action_just_pressed("pulo"):
					pular()
			else:
				rpc("anim_jump")
		
							
			if movimento.y > 1000:
				danogeral()
					
			movimento = move_and_slide(movimento, FLOOR_NORMAL)
			rpc_unreliable("update_position", position)	
			
			
			if damage <=0:
				
				rpc("morrer")
	
							
	if is_network_master():	
		$Anim.play(animation)
		rset("puppet_animation", animation)
		rset("puppet_agachado", agachado)
		rset("puppet_idle", idle)
		rset("puppet_run", run)
		rset("puppet_atack", atack)
		rset("puppet_dano", dano)
		rset("puppet_atirar", atirar)
		rset("puppet_morreu", morreu)
		rset("puppet_noelevador", noelevador)
		rset("puppet_flip", flip)
		rset("puppet_atackUp", ataqueUp)
		
		
	else:
		$Anim.play(puppet_animation)
		agachado = puppet_agachado
		idle = puppet_idle
		run = puppet_run
		atack = puppet_atack
		dano = puppet_dano
		atirar = puppet_atirar
		morreu = puppet_morreu
		noelevador = puppet_noelevador
		flip = puppet_flip
		ataqueUp = puppet_atackUp
#----------------------------------------------------------------		
#MORTE-----------------------------MORTE----------------------

remotesync func morrer():
	morreu = true
	if morreu == true:	
		animation = "Die"
		$morrerFX.play()
		movimento = Vector2(0, 0)
		$CollisionShape2D.disabled = true
		$DashD/CollisionShape2D.disabled = true
		$DashE/CollisionShape2D.disabled = true


func _update_health_bar():
	get_node("CanvasLayer/HPplayer").value = int(damage)
	if damage <= 0:
		damage = 0
	

#MOVIMENTOS-------------------MOVIMENTOS----------------------

remote func update_position(pos):
	position = pos
	
remotesync func parado():
	movimento.x = 0
	run = false
	agachado = false
	idle = true
	if flip == false and movimento.x == 0 and atack == false and atirar == false and idle == true and dano == false and morreu == false:
		animation = "Idle_R"
		
	elif flip == true and movimento.x == 0 and atack == false and atirar == false and idle == true and dano == false and morreu == false:
		animation = "Idle_L"
		
		
remotesync func direita():
	if atack == false and atirar == false and !dano:
		flip = false
		idle = false
		run = true
		agachado = false
		movimento.x = velocidade
		animation = "Walk_R"
	

remotesync func esquerda():
	if atack == false and atirar == false and !dano:
		flip = true
		idle = false
		run = true
		agachado = false
		movimento.x = - velocidade
		animation = "Walk_L"


func pular():
	if ! agachado:
		movimento.y = PULO
		$PuloFX.play()
		
remotesync func anim_jump():
	if ! atack and ! noelevador and ! atirar and ! morreu and !dano and ! agachado:
		animation = "Jump_R"
		if flip:
			animation = "Jump_L"
		

remotesync func agachar():
	if atack == false and atirar == false and !dano:
		agachado = true
		run = false
		idle = false
		movimento.x = 0
		$CollisionShape2D.disabled = true
		$DashD/CollisionShape2D.disabled = true
		$DashE/CollisionShape2D.disabled = true
		$Agachado.disabled = false
		animation = "agachar"
		if flip == true:
			movimento.x = 0
			$CollisionShape2D.disabled = true
			$DashD/CollisionShape2D.disabled = true
			$DashE/CollisionShape2D.disabled = true
			$Agachado.disabled = false
			animation = "agachar_L"
		
		
func _on_DashD_area_shape_entered(_area_id, _area, _area_shape, _self_shape):
	movimento.x = velocidade*30
	animation = "Dano"
# warning-ignore:return_value_discarded
	move_and_slide(movimento)


func _on_DashE_area_shape_entered(_area_id, _area, _area_shape, _self_shape):
	movimento.x = -velocidade*30
	animation = "Dano"
# warning-ignore:return_value_discarded
	move_and_slide(movimento)


#-------------PEGAR ITENS------------PEGAR ITENS-------------------		
func cartucho():
	balas += 15
	$clicFX.play()
	
func misseis():
	missel += 5
	
func getgranada():
	granadas += 5
	$socoforteFX.play()
func getbazooka():
	missel += 5
	$socoforteFX.play()
	
func vida():
	$lifeFX.play()
	damage = vida_maxima

func vidamedia():
	$lifeFX.play()
	if damage < 100:
		damage = damage + vida_media

	if damage > 100:
		damage = 100
		


	
#DANOS GOLPES---------------------------DANOS GOLPES-----------------------------------------------	
		

remote func tiro():
	dano = true
	if dano == true and atack == false:
		velocidade = 0
		damage -= dano_tiro
		$danoFX.play()
		animation = "Dano"
		$DanoReset.start()
	if ! is_master:
		rpc("tiro")
		
remote func soco():
	dano = true
	if dano == true:
		velocidade = 0
		damage -= dano_soco
		$danoFX.play()
		animation = "Dano"
		$DanoReset.start()
	if ! is_master:
		rpc("soco")
	
		
remote func socoforte():
	dano = true
	if dano == true:
		velocidade = 0
		damage -= dano_socoforte
		$danoFX.play()
		animation = "Dano"
		$DanoReset.start()
	if ! is_master:
		rpc("socoforte")
		
remote func chute():
	dano = true
	if dano == true:
		velocidade = 0
		damage -= dano_chute
		$danoFX.play()
		animation = "Dano"
		$DanoReset.start()
	if ! is_master:
		rpc("chute")
	
remote func granada():
	dano = true
	if dano == true:
		velocidade = 0
		damage -= danogranada
		$danoFX.play()
		animation = "Dano"
		$DanoReset.start()
	if ! is_master:
		rpc("granada")


remote func boombazuka():
	dano = true
	if dano == true:
		velocidade = 0
		damage -= danobazuka
		$danoFX.play()
		animation = "Dano"
		$DanoReset.start()
	if ! is_master:
		rpc("boombazuka")
		

remote func bazzoka():
	dano = true
	if dano == true:
		velocidade = 0
		damage -= danogranada
		$danoFX.play()
		animation = "Dano"
		$DanoReset.start()

		
		
remote func _on_DanoReset_timeout():
	dano = false
	parado()
	if dano == false and idle == true:
		velocidade = 120
	if !is_master:
		rpc_unreliable("_on_DanoReset_timeout")

	
#ATAQUES --------------------ATAQUES------------ATAQUES------------------------------------	
sync func ataque():
	atack = true
	idle = false
	$ResetAttack.start()
	if atack == true and idle == false:
		$socofracoFX.play()
		$AttackArea/CollisionShape2D.position.x = 19
		animation = "Attack_R"
		$AttackArea/CollisionShape2D.disabled = false
		if flip == true:
			$AttackArea/CollisionShape2D.position.x = -25
			animation = "Attack_L"
			$AttackArea/CollisionShape2D.disabled = false
			
	
			
sync func ataque1():
	atack = true
	idle = false
	ataqueUp = true
	$socoforteFX.play()
	$ataque1.start()
	if ataqueUp == true and atack and idle == false:
		$AttackArea1/CollisionShape2D.position.x = 19
		animation = "Attack1_R"
		$AttackArea1/CollisionShape2D.disabled = false
		if flip == true:
			$AttackArea1/CollisionShape2D.position.x = -25
			animation = "Attack1_L"
			$AttackArea1/CollisionShape2D.disabled = false
			
sync func ataque2():
	atack = true
	idle = false
	$chuteFX.play()
	$ResetAttack.start()
	if atack == true and idle == false:
		$AttackArea2/CollisionShape2D.position.x = 25	
		animation = "Kick_R"
		$AttackArea2/CollisionShape2D.disabled = false
		if flip == true:
			$AttackArea2/CollisionShape2D.position.x = -30
			animation = "Kick_L"
			$AttackArea2/CollisionShape2D.disabled = false

			
sync func shoot():
	if is_on_floor():
		movimento.x = 0
	$TiroFx.play()
	get_node("Light2D").set_visible(true)
	balas -= 1
	atirar = true
	var tiro = TIRO.instance()
	get_parent().add_child(tiro)
	$ShootReset.start()
	if ! flip:
		tiro.position = $Tiro_R.global_position
		animation = "Shoot_R"
		tiro.set_tiro_direction(1)
	if flip:
		tiro.position = $Tiro_L.global_position
		animation = "Shoot_L"
		tiro.set_tiro_direction(-1)

		
		
sync func tirobazzoka():
	$bazuca.play()
	movimento.x = 0
	missel -= 1
	atirar = true
	var bazzoka = BAZZOKA.instance()
	get_parent().add_child(bazzoka)
	bazzoka.position = $tiromissel.global_position
	$MisselReset.start()
	animation = "bazoka_R"
	bazzoka.set_bazzoka_direction(1)
	if flip:
		bazzoka.position = $tiromissel2.global_position
		animation = "bazoka_L"
		bazzoka.set_bazzoka_direction(-1)
		
		
		
sync func jogargranada():
	if is_on_floor():
	
		movimento.x = 0
	granadas -= 1
	atirar = true
	var granada = GRANADA.instance()
	get_parent().add_child(granada)
	granada.position = $Arremeco.global_position
	$ShootReset.start()
	animation = "arremeco"
	granada.set_granada_direction(1)
	if flip:
		granada.position = $Arremeco2.global_position
		animation = "arremeco_L"
		granada.set_granada_direction(-1)

sync func get_shield():
	atack = true
	idle = false
	escudo -= 1
	if !idle and atack:
		$ResetAttack.start()
		$socofracoFX.play()
		var shield = SHIELD.instance()
		get_parent().add_child(shield)
		shield.position = $shield2.global_position
		animation = "Shield_R"
		if flip:
			shield.position = $shield1.global_position
			animation = "Shield_L"


remote func _on_ShootReset_timeout():
	atirar = false
	idle = true
	get_node("Light2D").set_visible(false)
	if ! is_master:
		rpc_unreliable("_on_ShootReset_timeout")

remote func _on_MisselReset_timeout():
	atirar = false
	idle = true
	get_node("Light2D").set_visible(false)
	if ! is_master:
		rpc_unreliable("_on_MisselReset_timeout")


func _on_AttackArea_body_entered(body):
	$punchfracoFX.play()
	body.soco()


func _on_AttackArea1_body_entered(body):
	$punchforteFX.play()
	body.socoforte()


func _on_AttackArea2_body_entered(body):
	$kickFX.play()
	body.chute()
	
func _on_ResetAttack_timeout():
	atack = false
	dano = false
	parado()
	$AttackArea/CollisionShape2D.disabled = true
	$AttackArea2/CollisionShape2D.disabled = true
	
remote func _on_ataque1_timeout():
	atack = false
	dano = false
	ataqueUp = false
	parado()
	$AttackArea1/CollisionShape2D.disabled = true
	if ! is_master:
		rpc_unreliable("_on_ataque1_timeout")

#DANOS GERAIS ----------------- DANOS GERAIS______________________________	
func armadilha():
	dano = true
	if dano == true:
		$DanoReset.start()
		$danoFX.play()
		animation = "Dano"
		damage -= 100
	
			
func danogeral():
	dano = true
	if dano == true:
		$DanoReset.start()
		$danoFX.play()
		animation = "Dano"
		damage -= DANOQUEDA
	
	
#-------------------------------------------------------------
	
func elevador():
	noelevador = true


func saiuelevador():
	noelevador = false


func gatecontrol():
	pass
	






