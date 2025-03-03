extends CharacterBody2D

@export var _move_speed: float = 128.0

func _physics_process(_delta: float) -> void:
	var basic_move = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = basic_move * 128.0
	move_and_slide()
