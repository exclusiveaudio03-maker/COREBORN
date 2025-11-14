extends Node
signal connected()
signal disconnected()
signal player_synced(data)

var online := false
var player_data := {}

func connect_to_server(url:String):
	# placeholder: implement HTTP / WebSocket client
	print("MMOManager: connect_to_server -> %s" % url)
	online = false

func sync_player():
	# placeholder: fetch or push player_data
	if not online:
		print("MMOManager: offline, skip sync")
		return
	emit_signal("player_synced", player_data)

func set_player_data(d:Dictionary):
	player_data = d
	if online:
		sync_player()

func add_item(item_id:String, amount:int=1):
	var inv = GameState.state["inventory"]
	inv[item_id] = inv.get(item_id,0) + amount
	GameState.save()
