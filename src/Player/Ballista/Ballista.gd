extends Node2D
class_name Ballista

const BulletPlayer := preload('res://src/Bullets/BulletPlayer/BulletPlayer.tscn')

@onready var BallistaBody := $BallistaBody
@onready var Muzzle := $BallistaBody/Muzzle

var is_changing_rotation = true

func start_bullet() -> void:
	is_changing_rotation = false

func release_bullet() -> void:
	is_changing_rotation = true

func _ready() -> void:
	MAIN.Player = self

func _physics_process(_delta: float) -> void:
	if is_changing_rotation:
		var _rotation := get_local_mouse_position().angle()
		BallistaBody.rotation = _rotation
	if Input.is_action_just_pressed('click'):
		start_bullet()

func _on_line_creator_line_created(vector: Vector2, speed: float):
	var instance = UTILS.create_instance(BulletPlayer, Muzzle.global_position)
	release_bullet()
	instance.life_time = speed * 0.006
	instance.velocity = vector.normalized() * speed * 1.4045
	instance.rotation = BallistaBody.rotation
	get_tree().current_scene.add_child(instance)
