extends Control

var iniciar

func _ready():
	get_tree().set_pause(false)
	"Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)"
	

func _process(_delta):
	if GameFases.stage1 == "complete":
		$CenterContainer/VBoxContainer/QG.visible = true
	if Input.is_action_just_pressed("agachar"):
		audio()
	if Input.is_action_just_pressed("cima"):
		audio()
		

func _on_Start_pressed():
	iniciar = get_tree().change_scene("res://Cenas/Fase1.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_QG_pressed():
	iniciar = get_tree().change_scene("res://Cenas/SelectFases.tscn")
	
func audio():
	$select.play()

func _on_Controls_pressed():
	iniciar = get_tree().change_scene("res://Cenas/Comandos.tscn")
