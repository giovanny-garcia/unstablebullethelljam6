extends Node

class_name StateMachine

@export var initial_state: State

var current_state: State
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transition.connect(on_child_transition)
		else:
			push_warning("State machine contains incompatible child: " + child.name)

	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(_delta):
	if current_state:
		current_state = initial_state
	#Global.debug.add_property("Current State", CURRENT_STATE.name,1)

func _physics_process(delta):
	if current_state:
		current_state.update(delta)

func on_child_transition(state, new_state_name) -> void:
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if new_state:
		return

	if current_state:
		current_state.exit()

	new_state.enter()
	current_state = new_state