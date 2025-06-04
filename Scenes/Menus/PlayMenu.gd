extends Control

@onready var slot_buttons = [
	$VBoxContainer/File1,
	$VBoxContainer/File2,
	$VBoxContainer/File3,
]


func _ready():
	update_all_buttons()
	# Connect all button signals
	for i in range(slot_buttons.size()):
		slot_buttons[i].pressed.connect(_on_slot_button_pressed.bind(i + 1))

func update_all_buttons():
	for i in range(slot_buttons.size()):
		var slot_number = i + 1
		update_slot_button(slot_number, slot_buttons[i])

func update_slot_button(slot: int, button: Button):
	if SaveManager.save_slot_exists(slot):
		# Load save data to show info
		var save_data = SaveManager.load_game(slot)
		button.text = "Slot %d: %s\nLevel %d - Overwrite?" % [
			slot, 
			save_data.get("player_name", "Unknown"), 
			save_data.get("level", 1)
		]
		button.modulate = Color.ORANGE
		button.tooltip_text = "This will overwrite existing save data"
	else:
		button.text = "Slot %d\nNew Game" % slot
		button.modulate = Color.WHITE
		button.tooltip_text = "Start a new adventure"
		
func _on_slot_button_pressed(slot: int):
	if SaveManager.save_slot_exists(slot):
		show_overwrite_confirmation(slot)
	else:
		start_new_game(slot)
		
func show_overwrite_confirmation(slot: int):
	var save_data = SaveManager.load_game(slot)
	var dialog = ConfirmationDialog.new()
	dialog.dialog_text = "Overwrite save in Slot %d?\n\nCurrent save:\n%s - Level %d" % [
		slot,
		save_data.get("player_name", "Unknown"),
		save_data.get("level", 1)
	]
	dialog.title = "Confirm Overwrite"
	add_child(dialog)
	dialog.popup_centered()
	dialog.confirmed.connect(start_new_game.bind(slot))
	dialog.tree_exited.connect(func(): dialog.queue_free())

func start_new_game(slot: int):
   # Store which slot to use
	SaveManager.selected_save_slot = slot
	get_tree().change_scene_to_file("res://scenes/Levels/Cloverwood.tscn")
func _on_file_1_pressed() -> void:
	pass


func _on_file_2_pressed() -> void:
	pass # Replace with function body.


func _on_file_3_pressed() -> void:
	pass # Replace with function body.


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/MainMenu.tscn")
