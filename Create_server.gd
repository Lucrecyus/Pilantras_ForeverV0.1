extends Button

signal set_connect_type
var invite

func _ready():
	for ip in IP.get_local_addresses():
		if "192." in ip and not ip == "127.0.0.1":
			$IP.text = "IP: " + ip
	
func host():
	Network.initialize_server()
	emit_signal("set_connect_type", true)
	$".".disabled = true
