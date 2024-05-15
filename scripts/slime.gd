extends Node2D

const SPEED = 60
var direction = 1
var dead = false

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D
@onready var squelch = $Squelch
@onready var slime_collison = $SlimeCollison
@onready var killzone_collision = $killzone/KillzoneCollision

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true

	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false

	position.x += direction * SPEED * delta

func _on_area_entered(area):
	if area.is_in_group("Sword"):
		direction = 0
		dead = true
		squelch.play()
		slime_collison.queue_free()
		killzone_collision.queue_free()
		animated_sprite.play("die")

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "die":
		queue_free()
