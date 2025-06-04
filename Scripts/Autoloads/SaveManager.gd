extends Node
"""Why this approach works:
	- No wasted space.
	- Easier maintainence and version control
	- Self-Documenting
"""

var selected_save_slot: int = 1

const SAVE_FILE_PATH = "user://save_slod_%d.save"
const MAX_SAVE_SLOTS = 3

func save_game(slot: int, game_data: Dictionary):
	if slot < 1 or slot > MAX_SAVE_SLOTS:
		print("Invalid save slot: ", slot)
		return false
		
	var file = FileAccess.open(SAVE_FILE_PATH % slot, FileAccess.WRITE)
	if file == null:
		print("Error opening save file")
		return false
		
	file.store_string(JSON.stringify(game_data))
	file.close()
	return true
	
func load_game(slot: int) -> Dictionary:
	if slot < 1 or slot > MAX_SAVE_SLOTS:
		return get_default_save_data()
		
	var file_path = SAVE_FILE_PATH % slot
	if not FileAccess.file_exists(file_path):
		return get_default_save_data()
		
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		return get_default_save_data()
	
	var json_string = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if parse_result != OK:
		return get_default_save_data()
	
	return json.data
	
func get_default_save_data() -> Dictionary:
	return {
		"player_name": "New Player",
		"level": 1,
		"health": 100,
		"max_health": 100,
		"experience": 0,
		"gold": 0,
		"inventory": [],
		"current_scene": "res://scenes/MainMenu.tscn",
		"position": {"x": 0, "y": 0},
		"play_time": 0.0,
		"save_date": Time.get_datetime_string_from_system()
	}
	
func save_slot_exists(slot: int) -> bool:
	return FileAccess.file_exists(SAVE_FILE_PATH % slot)

func delete_save(slot: int) -> bool:
	var file_path = SAVE_FILE_PATH % slot
	if FileAccess.file_exists(file_path):
		DirAccess.remove_absolute(file_path)
		return true
	return false
