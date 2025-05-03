extends Node

var debug #reference to DebugPanel for debbug property assignment
var player
var playerstate

func set_player(player_instance):
	player = player_instance

func set_player_state(player_state_instance):
	playerstate = player_state_instance