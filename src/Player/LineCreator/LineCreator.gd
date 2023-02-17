extends Node2D

@onready var line = $Line2D
@onready var line2 = $Line2D2
@onready var PlayerBody = get_parent().get_child(0)

signal line_created(vector, speed)

var pressed := false
var position_start := Vector2.ZERO
var position_end := Vector2.ZERO
var max_distance := 200.0
var distance := 0.0
var norm_vector := Vector2.ZERO

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed('ui_touch'):
		pressed = true
		position_start = get_viewport().get_mouse_position() - global_position
	elif Input.is_action_just_released('ui_touch'):
		emit_signal('line_created', norm_vector * -1, distance)
		reset()

	if pressed:
		position_end = get_viewport().get_mouse_position() - global_position
		distance = min(position_start.distance_to(position_end), max_distance)
		norm_vector = position_start.direction_to(PlayerBody.position)
		_draw_line(line, position_start, position_end, Color.ORANGE)
		_draw_line(line2, position_start, position_start + norm_vector * distance, Color.AQUA)

func _draw_line(node: Line2D, start: Vector2, end: Vector2, color: Color) -> void:
	node.points = [start, end]
	node.default_color = color

func reset() -> void:
	pressed = false
	position_start = Vector2.ZERO
	position_end = Vector2.ZERO
	norm_vector = Vector2.ZERO
	line.points = []
	line2.points = []
	distance = 0.0
	
