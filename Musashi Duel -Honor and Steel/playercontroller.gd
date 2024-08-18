extends CharacterBody2D 

var facing
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var attacking
@onready var sprite =$sprite
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const SLASH = preload("res://slash.tscn")


func create_slash():
	var slash = SLASH.instantiate()
	slash.facing = facing
	add_sibling(slash)
	
	slash.global_position = global_position
	
func _physics_process(delta):
	if attacking:
		return
	
	if Input.is_action_just_pressed("attack"):
		attacking = true
		sprite.play("attack")
		await sprite.animation_finished
		print("make slash")
		create_slash()
		#shoot code goes here
		attacking = false
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		
		velocity.x = direction * SPEED
		sprite.play('run')
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		sprite.play('idle')

	if velocity.x >0:
		sprite.flip_h = false
		facing = "right"
	elif velocity.x < 0:
		sprite.flip_h = true
		facing = "left"


	move_and_slide()
