extends Area2D

@onready var slime = $".."
@onready var animated_sprite = $"../AnimatedSprite2D"

var dead = false

func _on_area_entered(area):
	if area.is_in_group("Sword"):
		dead = true
		animated_sprite.play("die")
		slime.queue_free()
