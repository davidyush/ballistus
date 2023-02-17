extends TileMap

var astar = AStar2D.new()
var neighbors := [Vector2.RIGHT, Vector2.LEFT, Vector2.DOWN, Vector2.UP]
var obstacles := []

func get_id(point: Vector2) -> int:
	var a := int(point.x)
	var b := int(point.y)
	return (a + b) * (a + b + 1) / 2 + b

func connect_points(cells: Array) -> void:
	for cell in cells:
		for neighbor in neighbors:
			var next_cell: Vector2 = Vector2(cell) + neighbor 
			if cells.has(Vector2i(next_cell)):
				astar.connect_points(get_id(cell), get_id(next_cell), false)

func add_points(cells: Array) -> void:
	for cell in cells:
		astar.add_point(get_id(cell), cell, 1.0)

func init() -> void:
	astar.clear()
	var used_cells = get_used_cells(0)
	add_points(used_cells)
	connect_points(used_cells)

func add_obstacle(obstacle: Object) -> void:
	obstacles.append(obstacle)
	if not obstacle.is_connected("tree_exiting", remove_obstacle):
		obstacle.connect("tree_exiting", remove_obstacle)

func remove_obstacle(obstacle: Object) -> void:
	obstacles.erase(obstacle)

func set_obstacles_points_disabled(value: bool) -> void:
	for obstacle in obstacles:
		astar.set_point_disabled(get_id(obstacle.global_position / VARS.GRID_SIZE), value)

func update() -> void:
	init()
	var obstacleNodes = get_tree().get_nodes_in_group("Obstacle")
	for obstacleNode in obstacleNodes:
		add_obstacle(obstacleNode)

func update_obs() -> void: #expremental
	var obstacleNodes = get_tree().get_nodes_in_group("Obstacle")
	for obstacleNode in obstacleNodes:
		astar.set_point_disabled(get_id(obstacleNode.global_position), false)

func get_path_to_target(start: Vector2, end: Vector2) -> PackedVector2Array:
	update()
	set_obstacles_points_disabled(true)
	var _start = start / VARS.GRID_SIZE
	var _end = end / VARS.GRID_SIZE
	var path = astar.get_point_path(get_id(_start), get_id(_end))
	return path
