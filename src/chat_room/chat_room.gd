extends Control

onready var rich_text_label: RichTextLabel = get_node("Messege/RichTextLabel")
onready var writing_line: LineEdit = get_node("Send/Pin/WritingLine")
onready var transition: AnimationPlayer = get_node("Transition")
onready var confirm: TextureButton = get_node("Send/Confim")

func _enter_tree() -> void:
	$Transition.leaving()
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("enter"):
		send_message()
		
	get_historic()
		
		
func get_historic() -> void:
	if get_tree().is_network_server():
		var historic: String = rich_text_label.bbcode_text
		rpc("send_historic", historic)
		
	
remotesync func send_historic(historic) -> void:
	rich_text_label.bbcode_text = historic
	
func send_message() -> void:
	var message: String = writing_line.text + "\n"
	var nome: String = Networking.nome
	rpc("reseive_message", message, nome)
	
sync func reseive_message(message, nome) -> void:
	rich_text_label.bbcode_text += str(nome) + ": " + message
	
func _on_confim_button_up() -> void:
	send_message()
