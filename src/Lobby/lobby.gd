extends Control

func _enter_tree() -> void:
	$Transition.leaving()
	
func _process(delta: float) -> void:
	if $LineEdit.text != "":
		Networking.nome = $LineEdit.text
	
func _on_host_pressed() -> void:
	Networking.create_server()
	$Transition.going()
	
func _on_login_pressed() -> void:
	Networking.create_client()
	$Transition.going()
