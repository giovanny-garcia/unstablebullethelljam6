extends AnimatedSprite2D
@onready var timer = $Timer

var animatedsprite = self
var dance: bool = false
var random_int: = 0

func _ready():
	animatedsprite.play("blink")
	timer.start()

func _process(delta: float):
	if random_int == 6:
		animatedsprite.play("dance")
		random_int = 0;
	else:
		animatedsprite.play("blink")
		timer.start()
		

func _on_timer_timeout() -> void:
	random_int = randi_range(1,6)
