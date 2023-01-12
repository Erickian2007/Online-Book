extends Control

func _on_host_pressed() -> void:
	Networking.create_server()
	
func _on_login_pressed() -> void:
	Networking.create_client()
	
