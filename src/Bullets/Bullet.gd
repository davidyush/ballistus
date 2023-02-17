extends Area2D
class_name Bullet

var velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	position += velocity * delta
	if position.y > get_viewport_rect().size.y:
		queue_free()
