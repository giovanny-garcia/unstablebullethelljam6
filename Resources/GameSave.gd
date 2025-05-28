extends Resource
class_name GameSave

const GAME_SAVE_PATH := "res://GameSave.tres"

@export var player_position: Vector2
@export var player_health: int
@export var player_inventory: Resource
@export var map := ""

func write_save() -> void:
	pass #ResourceSaver.save(GAME_SAVE_PATH, self)

static func load_save() -> Resource:
	if ResourceLoader.exists(GAME_SAVE_PATH):
		return load(GAME_SAVE_PATH)
	return null
   
