extends CharacterBody2D

var visited = []
var waiting_for_recalc := false

func _on_hurtbox_hit(damage, attack_type) -> void:
	print('enemy damaged', damage, attack_type)
	get_parent().get_parent().queue_free()
	
func remake_path(obstacle_position: Vector2) -> void:
	get_parent().get_parent().recalculate_path(obstacle_position)
