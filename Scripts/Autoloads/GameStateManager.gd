extends Node

var player_position: Vector2

func set_player_position(position: Vector2) -> void:
	player_position = position
    # print("Player position set to: ", player_position)

func get_player_position() -> Vector2:
	return player_position
    