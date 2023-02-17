extends Node

func create_instance(scene: PackedScene, position: Vector2) -> Node:
	var instance := scene.instantiate()
	instance.global_position = position
	return instance

func get_parent_by_name(current_node: Node, parent_name: String) -> Node:
	var current_parent = current_node.get_parent()
	while current_parent != null:
		if str(current_parent.name).begins_with(parent_name):
			return current_parent
		else:
			current_parent = current_parent.get_parent()
	return null

func move_tween(node: Node, target_position: Vector2) -> bool:
	var tween := create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(node, 'global_position', target_position, 0.15)
	await tween.finished
	return true
