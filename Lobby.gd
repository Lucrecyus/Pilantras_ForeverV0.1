extends Control

var nickname = ""
var iniciar
var conectado

func _ready():
	conectado = get_tree().connect("connected_to_server", self, "connected")
	$Create_server.grab_focus()
	
func _process(_delta):
	if Input.is_action_pressed("agachar"):
		$select.play()
	if Input.is_action_pressed("cima"):
		$select.play()
	if Input.is_action_pressed("direita"):
		$select.play()
	if Input.is_action_pressed("esquerda"):
		$select.play()

func connected():
	#print("CONNECTED")
	if not Network.is_host:
		rpc("begin_game")
		begin_game()

remote func begin_game():
	iniciar = get_tree().change_scene("res://Cenas/Versus.tscn")
	
# Input the nickname
func _on_nickname_text_changed(new_nickname):
	nickname = new_nickname
	
