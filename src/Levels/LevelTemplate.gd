extends Node2D

const SuperStone := preload('res://src/Obstacles/super_stone.tscn')

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed('ui_touch'):
		var mouse_position = get_global_mouse_position()
		var floored = Vector2(int(mouse_position.x / VARS.GRID_SIZE) * VARS.GRID_SIZE, int(mouse_position.y / VARS.GRID_SIZE) * VARS.GRID_SIZE)
		var obstacle = UTILS.create_instance(SuperStone, floored)
		get_tree().current_scene.get_child(0).add_child(obstacle)
