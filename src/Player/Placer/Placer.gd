extends Marker2D

@onready var Player := get_child(0)

var _positions = {
	'f1': position + Vector2(-32, 0),
	'f2': position + Vector2(0, 0),
	'f3': position + Vector2(32, 0)
}

var current_position := 'f2'

func set_container_postion(_position: String) -> void:
	if (current_position == 'f1' and _position == 'f3') or (current_position == 'f3' and _position == 'f1'):
		printerr('cannot replace')
	else:
		var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(Player, 'position', _positions[_position], 0.15)
		current_position = _position

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("f1"):
		set_container_postion('f1')
	elif Input.is_action_just_pressed("f2"):
		set_container_postion('f2')
	elif Input.is_action_just_pressed("f3"):
		set_container_postion('f3')
