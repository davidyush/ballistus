extends Bullet

@onready var Hitbox := $Hitbox
@onready var _Timer := $Timer

const SuperStone := preload('res://src/Obstacles/super_stone.tscn')

var life_time := 0.0
const scaler := 2

func _ready() -> void:
	life_time = max(life_time, 0.1)
	Hitbox.monitoring = false
	_Timer.wait_time = life_time
	_Timer.start()

func _physics_process(delta: float) -> void:
	super(delta)
	if life_time / 2 < _Timer.get_time_left():
		scale = Vector2(scale.x + delta * scaler, scale.y + delta * scaler)
	else:
		scale = Vector2(scale.x - delta * scaler, scale.y - delta * scaler)

func _on_timer_timeout() -> void:
	Hitbox.monitoring = true
	velocity = Vector2.ZERO
	await get_tree().create_timer(0.04).timeout
	#var obstacle = UTILS.create_instance(SuperStone, get_floor_position(position))
	#get_tree().current_scene.get_child(0).add_child(obstacle)
	queue_free()


func get_floor_position(absolute_position: Vector2) -> Vector2:
	return Vector2(
		floor(absolute_position.x / VARS.GRID_SIZE) * VARS.GRID_SIZE,
		floor(absolute_position.y / VARS.GRID_SIZE) * VARS.GRID_SIZE,
	)
