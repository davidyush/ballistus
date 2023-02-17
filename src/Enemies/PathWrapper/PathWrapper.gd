extends Path2D

@onready var Grid : TileMap = UTILS.get_parent_by_name(self, 'Grass')
@onready var Player : Node2D = MAIN.Player 

@onready var PathFollow = $PathFollow2D
@onready var Enemy = $PathFollow2D/Enemy

var current_curve = []
var is_going := true

func _ready() -> void:
	calculate_path()

func calculate_path() -> void:
	var target_position = Player.global_position - VARS.PLAYER_SIZE / 2
	var path = Grid.get_path_to_target(round(Enemy.global_position / VARS.GRID_SIZE) * VARS.GRID_SIZE, target_position)
	PathFollow.progress = 0
	var _curve = Curve2D.new()
	for cell in path:
		_curve.add_point(cell * VARS.GRID_SIZE)
		current_curve.push_back(cell * VARS.GRID_SIZE)
	curve.clear_points()
	curve = _curve

func recalculate_path(obstacle_position: Vector2) -> void:
	if not current_curve.has(obstacle_position): return
	var closest = curve.get_closest_point(floor(Enemy.global_position / VARS.GRID_SIZE) * VARS.GRID_SIZE)
	curve.clear_points()
	PathFollow.progress = 0
	var target_temp = current_curve[current_curve.find(closest) + 1]
	curve.add_point(Enemy.global_position)
	curve.add_point(target_temp)
	Enemy.waiting_for_recalc = true


func _physics_process(delta: float) -> void:
	if is_going:
		PathFollow.progress += randf() * 40.0 * delta
	if PathFollow.progress_ratio == 1 and Enemy.waiting_for_recalc:
		current_curve = []
		calculate_path()
		Enemy.waiting_for_recalc = false
		
