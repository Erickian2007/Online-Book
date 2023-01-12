extends Node

const CHAT_ROOM: PackedScene = preload("res://src/chat_room/chat_room.tscn")

const IPADRESS: String = "127.0.0.1"
const PORT: int = 6007
const MAXPLAYERS: int = 10

var ip: String = IPADRESS
var nome: String = "Player"

var info_player: Array = []
var num_player: int = 0
var peer: NetworkedMultiplayerPeer = NetworkedMultiplayerENet.new()

var count: float = 0

func _ready() -> void:
	get_tree().connect("connected_to_server", self, "connected_to_server")
	
func _process(delta: float) -> void:
	if info_player.size() != 0:
		peer.poll()
	
	count += delta * 1
	if count >= 5:
		print("ConnectionStatus", ": ", peer.get_connection_status())
		count = 0
		
	
func connected_to_server() -> void:
	var id: int = peer.get_unique_id()
	rpc("register_player", id, nome)
	
remotesync func register_player(id,nome) -> void:
	info_player.append([id, nome])
	print(info_player)
	
func connection_ok() -> void:
	print("succeeded")
	
func peer_connected(id: int) -> void:
	print("PeerAdress", ": ", peer.get_peer_address(id))
	
func create_server() -> void:
	peer.create_server(PORT, MAXPLAYERS)
	get_tree().set_network_peer(peer)
	peer.connect("connection_succeeded", self, "connection_ok")
	
	register_player(peer.get_unique_id(), nome)
	
	print("servidor criado")
	
	go_chat_room()
	
func create_client() -> void:
	peer.create_client(ip, PORT)
	get_tree().set_network_peer(peer)
	peer.connect("peer_connected", self, "peer_connected")
	
	print("cliente criado")
	
	go_chat_room()
	
func go_chat_room() -> void:
	get_tree().change_scene_to(CHAT_ROOM)
	
func return_num_player() -> int:
	return num_player
	
func change_name(new: String) -> void:
	nome = new
