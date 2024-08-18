extends Area2D

@export var speed: float = 800.0
@export var lifespan: float = 3.0  # Time before the sword disappears
var facing = "right"
var velocity: Vector2

func _ready():
	# Set up the sword's initial velocity
	if facing == "right":
		velocity = Vector2(speed, 0)
	else:
		velocity = Vector2(-speed,0)
		$AnimatedSprite2D.flip_h = true
	# Set a timer to remove the sword after its lifespan ends
	set_life_span(lifespan)

func _process(delta: float):
	# Move the sword based on its velocity
	position += velocity * delta

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.take_damage(10)  # Assuming enemies have a take_damage method
		queue_free()  # Destroy the sword on hit

func set_life_span(time: float):
	await get_tree().create_timer(1).timeout
	queue_free()
	#var timer = Timer.new()
	#timer.wait_time = time
	#timer.one_shot = true
	#timer.timeout.connect(_on_timeout)
	#add_child(timer)
	#timer.start()

