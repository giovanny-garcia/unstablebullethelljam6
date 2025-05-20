extends Node

var player_position: Vector2 = Vector2.ZERO

func _get_player_position() -> Vector2:
    return player_position

func _update_player_position(position: Vector2) -> void:
    player_position = position
    