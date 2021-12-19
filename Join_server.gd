extends Button

signal set_connect_type


func _pressed():
	if $IP.text.is_valid_ip_address():
		join()
	else:
		$Invalid_IP.show()

func join():
	Network.initialize_client($IP.text)
	emit_signal("set_connect_type", false)
