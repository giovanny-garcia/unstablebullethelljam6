extends Node2D

func teleport_player_to(target_position: Vector2, level: String) -> void:
	var player = get_node("/root/" + level + "/Player") # Adjust the path to your player node
	if player:
		player.position = target_position
		print("Player teleported to: ", target_position)
		AudioManager.play_sfx("door")
	else:
		print("Player node not found.")
