extends State

func enter() -> void:
	print("Entering Idle State")

func update(_delta: float) -> void:
	# Idle state logic, e.g., checking for input or animations
	pass #replace with actual logic that checks from the GameStateManager if the player is moving
    
    #transition.emit(self, "move") #emit the transition signal to move state
