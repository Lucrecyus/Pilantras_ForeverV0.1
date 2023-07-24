extends Button

var iniciar

func _on_back_pressed():
	iniciar = get_tree().change_scene("res://Cenas/Menu.tscn")
	GameFases.versus = "desativado"
