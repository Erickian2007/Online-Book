extends Node

const CHAT_ROOM: PackedScene = preload("res://src/chat_room/chat_room.tscn")

const IPADRESS: String = "127.0.0.1"
const PORT: int = 6007
const MAXPLAYERS: int = 10

var ip: String = IPADRESS
var nome: String = "Jogador"

var num_player: int = 0
var peer

func _ready() -> void:
	get_tree().connect("connected_to_server", self, "connected_to_server")

func connected_to_server() -> void:
	print("numeros de players" + ": " + str(num_player))
	print("conectado ao servidor")
	
func create_server() -> void:
	peer = NetworkedMultiplayerENet.new()
	peer.create_server(PORT, MAXPLAYERS)
	get_tree().set_network_peer(peer)
	num_player += 1
	print("servidor criado")
	
	go_chat_room()
	
func create_client() -> void:
	peer = NetworkedMultiplayerENet.new()
	peer.create_client(ip, PORT)
	get_tree().set_network_peer(peer)
	num_player += 1
	print("cliente criado")
	
	go_chat_room()
	
func go_chat_room() -> void:
	get_tree().change_scene_to(CHAT_ROOM)
	
func return_num_player() -> int:
	return num_player
	
