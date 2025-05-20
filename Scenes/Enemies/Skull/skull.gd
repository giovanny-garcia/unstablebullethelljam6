extends Area2D

#signal bullet_entered(bullet: Bullet)
@onready var healthBar = $HealthBar
@onready var bullet = $Bullet
var health = 4

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	healthBar.init_health(health)

func _set_health(value):
	health = health - value
	healthBar._set_health(health)
	if health <= 0:
		queue_free()
		AudioManager.play_sfx("die", 0.1)
		return
	
func _on_body_entered(body: Node) -> void:
	print("Detected body type: ", body)
	
		

func _on_bullet_entered(_bullet):
	print("Bullet entered skull")
	queue_free()


func _on_area_entered(_area):
	_set_health(1)


func _on_timer_timeout():
	pass # Replace with function body.
	

func shoot(target_position: Vector2):
	#bullet.shoot()
	pass


func _on_detection_zone_body_entered(body:Node2D):
	if body.is_in_group("Player"):
		print("Player detected")
		# shoot at player
		# Get the player position from the GameStateManager
		# Assuming GameStateManager is an autoload singleton
		# and has a method get_player_position()
		#shoot(GameStateManager.get_player_position())
