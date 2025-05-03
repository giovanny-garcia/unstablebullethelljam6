extends Node

var current_scene: Node = null

func _ready() -> void:
	current_scene = get_tree().current_scene

func change_scene(scene_path: String) -> void:
	var scene = load(scene_path)
	if scene is PackedScene:
		get_tree().change_scene_to_packed(scene)
	else:
		push_error("Failed to load scene: " + scene_path)

func swap_scene(scene_path: String, parent_node: Node):
	if current_scene:
		current_scene.queue_free()

	var scene = load(scene_path)
	if scene is PackedScene:
		current_scene = scene.instatiate()
		parent_node.add_child(current_scene)
		return current_scene
	else:
		push_error("Failed to load scene: " + scene_path)
		return null
