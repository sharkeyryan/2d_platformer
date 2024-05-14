extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D

var is_attacking = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations
	if is_on_floor():
		if direction == 0 && is_attacking == false:
			animated_sprite.play("idle")
		elif is_attacking == false:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
		
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed("attack") and is_on_floor():
		animated_sprite.play("attack")
		#print("Animation State: " + animated_sprite.animation)
		is_attacking = true

	move_and_slide()

func _on_animated_sprite_2d_animation_finished():
	#print("animation: " + animated_sprite.animation)
	if animated_sprite.animation == "attack":
		is_attacking = false
