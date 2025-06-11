extends Node

var player: CharacterBody2D
var player_name: String = "Player"
var player_level: int = 1 
var player_exp: int = 0
var player_health: int = 100
var player_position: Vector2 = Vector2.ZERO
var player_inventory: Array = []
var total_playtime: float = 0.0
var save_name: String = ""
var save_timestamp: String = ""

var is_in_game: bool = false

func _ready():
	pass
	#player = get_node(player_name)
	
func _process(_delta: float):
	pass
		
func give_xp(xp: int):
	var total_exp
	total_exp = player_exp + xp
	if total_exp < 100:
		player_exp += xp
	elif total_exp >= 100:
		level_up()
		player_exp = total_exp - 100
	print("received experience: ", xp)
		
func level_up():
		player_level = player_level + 1	
		
func get_player_level() -> int:
	return player_level
	
func set_player_position(position: Vector2) -> void:
	player_position = position
	# print("Player position set to: ", player_position)
	
func get_player_position() -> Vector2:
	return player_position

func set_player_to_talking_state() -> void:
	pass
	#player.set_state_to_talking()

func set_is_player_in_game(state: bool) -> void:
	is_in_game = state
	
func get_is_player_in_game() -> bool:
	return is_in_game
