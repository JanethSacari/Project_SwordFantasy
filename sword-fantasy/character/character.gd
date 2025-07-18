extends CharacterBody2D

var _can_attack: bool = true
var _actual_weapon: String = "sword"
var _animation_suffix: String = "_down"

@export var _move_speed: float = 128.0
@export var _character_animation: AnimationPlayer
@export var _action_timer: Timer
@export var _attack_area: Area2D
@export var _weapon_text: Label

func _process(_delta: float) -> void:
	var basic_move = Input.get_vector(
		"move_left", "move_right", "move_up", "move_down")
	
	velocity = basic_move * _move_speed
	move_and_slide()
	
	_animation_suffix = _char_suffix()
	_set_current_weapon()
	_attacking()
	_animation()

func _char_suffix() -> String:
	var _horizontal_action: float = Input.get_axis("move_left", "move_right")
	if _horizontal_action == -1:
		_attack_area.position = Vector2(-15, 0)
		return "_left"
		
	if _horizontal_action == +1:
		_attack_area.position = Vector2(+16, 0)
		return "_right"
		
	var _vertical_action: float = Input.get_axis("move_up", "move_down")
	if _vertical_action == -1:
		_attack_area.position = Vector2(0, -12)
		return "_up"
		
	if _vertical_action == +1:
		_attack_area.position = Vector2(0, +12)
		return "_down"
		
	return _animation_suffix
	
func _attacking() -> void:
	if Input.is_action_just_pressed("attack_mode") and _can_attack:
		set_process(false)
		_character_animation.play("attack_" + _actual_weapon + _animation_suffix)
		_action_timer.start(0.4)
		_can_attack = false
		
func _set_current_weapon() -> void:
	if Input.is_action_just_pressed("sword"):
		_actual_weapon = "sword"
	if Input.is_action_just_pressed("hatchet"):
		_actual_weapon = "hatchet"
	if Input.is_action_just_pressed("axe"):
		_actual_weapon = "axe"
	if Input.is_action_just_pressed("hoe"):
		_actual_weapon = "hoe"
	if Input.is_action_just_pressed("watering_can"):
		_actual_weapon = "watering_can"
	_weapon_text.text = _actual_weapon

func _animation() -> void:
	if _can_attack == false:
		return
		
	if velocity:
		_character_animation.play("walking" + _animation_suffix)
		return
	_character_animation.play("look" + _animation_suffix)

func _on_action_timer_timeout() -> void:
	set_process(true)
	_can_attack = true
