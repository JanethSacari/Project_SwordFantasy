extends CharacterBody2D
var _animation_suffix: String = "_baixo"

@export var _move_speed: float = 128.0

func _physics_process(_delta: float) -> void:
	var basic_move = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = basic_move * _move_speed
	move_and_slide()
	
	_animation_suffix = _char_suffix()
	print(_animation_suffix)

func _char_suffix() -> String:
	var _horizontal_action: float = Input.get_axis("move_left", "move_right")
	if _horizontal_action == -1:
		return "_left"
		
	if _horizontal_action == +1:
		return "_right"
		
	var _vertical_action: float = Input.get_axis("move_up", "move_down")
	if _vertical_action == -1:
		return "_up"
		
	if _vertical_action == +1:
		return "_down"
		
	return "_animation_suffix"
