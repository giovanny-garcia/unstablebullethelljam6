extends Node

var player_name: String = "Player"
var player_level: int = 1 
var player_exp: int = 0
var player_health: int = 100
var player_position: Vector2 = Vector2.ZERO
var player_inventory: Array = []
var total_playtime: float = 0.0
var save_name: String = ""
var save_timestamp: String = ""

func _ready():
	pass
func _process(delta: float):
	if player_exp == 100:
		level_up()
		
func give_xp(xp: int):
	player_exp += xp
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
