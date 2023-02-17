extends Area2D

@export var damage = 1.0
@export_enum('nope', 'common', 'magic') var attack_type = 0

func _on_area_entered(hurtbox: Area2D) -> void:
	hurtbox.emit_signal('hit', damage, attack_type)
