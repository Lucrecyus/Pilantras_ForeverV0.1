extends Node2D


func _ready():
	Network.set_ids()
	create_players()

func create_players():
	for id in Network.peer_ids:
		create_player(id)
	create_player(Network.net_id)

func create_player(id):
	#print("Player with ID " + str(id) + " initialized")
	var p = preload("res://Cenas/Player_M.tscn").instance()
	add_child(p)
	p.initialize(id)
	p.position = Vector2(100,-1)

