extends Area2D

#signal bullet_entered(bullet: Bullet)
@onready var healthBar = $HealthBar
@onready var bullet = $Bullet
@onready var detectionZone = $DetectionZone
@onready var fire_timer = $Timer
@export var bullet_speed: float = 200.0
@export var max_bullet_distance: float = 500.0
@export var fire_cooldown: float = 1.0

var health = 4
var bullet_active: bool = false
var bullet_start_position: Vector2
var distance_traveled: float = 0.0
var can_shoot: bool = true
var bullet_direction: Vector2
var player_in_zone := false

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	healthBar.init_health(health)
	#detectionZone.body_entered.connect(_on_detection_zone_body_entered)
	#detectionZone.body_exited.connect(_on_detection_zone_body_exited)
	bullet_start_position = bullet.position
	bullet.set_deferred("monitoring", false)
	bullet.set_deferred("monitorable", false)
	bullet.visible = false

	fire_timer.wait_time = fire_cooldown
	fire_timer.one_shot = false
	fire_timer.autostart = false
	fire_timer.connect("timeout", Callable(self, "_on_fire_timer_timeout"))
	# timer setup

func _physics_process(delta):
	if bullet_active:
		#move the bullet
		bullet.position += bullet_direction * bullet_speed * delta
		#update the distance traveled
		distance_traveled += bullet_speed * delta
		#check if the bullet has traveled the maximum distance
		if distance_traveled >= max_bullet_distance:
			disable_bullet()

func _process(_delta):
	pass

func _set_health(value): #handles the skull health as well as updating the health bar and freeing the skull
	health = health - value
	healthBar._set_health(health)
	if health <= 0:
		queue_free()
		AudioManager.play_sfx("die", 0.1)
		return
	
func _on_body_entered(body: Node) -> void: #not implemented
	print("Detected body type: ", body)

func _on_bullet_entered(_bullet):
	print("Bullet entered skull")
	queue_free()


func _on_area_entered(_area): #when a bullet hits skull it takes one damage.. maybe change this so that its set to a 
	_set_health(1)				#global variable that obtains the players damage or calculated damage.. maybe we could make this
								#into a case where local variable is uncalculated stats.


func _on_timer_timeout(): #not implemented just on some bull
	if player_in_zone:
		fire_bullet()

func _on_detection_zone_body_entered(body:Node2D):
	if body.is_in_group("Player"):
		print("Player detected")
		player_in_zone = true
		fire_timer.start()	
		
func disable_bullet():
	# Reset bullet to initial state
	bullet_active = false
	bullet.position = bullet_start_position
	bullet.set_deferred("monitoring", false)
	bullet.set_deferred("monitorable", false)
	bullet.visible = false
	distance_traveled = 0.0

func try_firing():
	if can_shoot and not bullet_active and player_in_zone:
		fire_bullet()

func fire_bullet():
	# First, reset bullet position to skull's position
	bullet.global_position = global_position

	# Now calculate the direction to the player from the skull's current position
	var player_position = GameStateManager.get_player_position()
	bullet_direction = (player_position - bullet.global_position).normalized()
	
	# Set bullet to active and reset its state
	bullet_active = true
	bullet.set_deferred("monitoring", true)
	bullet.set_deferred("monitorable", true)
	bullet.visible = true
	distance_traveled = 0.0

	# Start cooldown
	can_shoot = false
	fire_timer.start(fire_cooldown)
	await fire_timer.timeout
	can_shoot = true
	if player_in_zone == true:
		print("Player in zone, firing bullet")
		try_firing()

func _on_bullet_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		print("Bullet hit player")
		# Emit signal to notify that the bullet has hit the player
		#emit_signal("bullet_entered", body)
		# Disable the bullet
		disable_bullet()


func _on_detection_zone_body_exited(body: Node2D):
	if body.is_in_group("Player"):
		print("Player left detection zone")
		player_in_zone = false
