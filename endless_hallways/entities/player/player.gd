extends CharacterBody2D


## Movement Variables
@export var move_speed : float
@export var acceleration : float
@export var deceleration : float


## Jump Variables
@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float


@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0


@export var max_fall_speed : float
@export var sustain : float


var can_jump = false
var jump_pressed = false
var jump_cut_applied = false
var jump_buffered = false
var mirrored = true


## Nodes
@onready var sprite = $Art/Sprite2D
@onready var animation = $Art/AnimationPlayer


## Core Process
func _physics_process(delta):
	if is_on_floor():
		can_jump = true
		jump_cut_applied = false
		if jump_pressed:
			if not Input.is_action_pressed("jump"):
				jump_cut_applied = true
	
	if not is_on_floor():
		coyote_time()
	
	screen_wrap()
	
	move_and_slide()


## Movement
func move():
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * move_speed, move_speed * acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed * deceleration)
	
	if velocity.x < 0 and mirrored == true: 
		sprite.flip_h = true
		mirrored = false
	elif velocity.x > 0 and mirrored == false: 
		sprite.flip_h = false
		mirrored = true


func stop():
	velocity = Vector2(0, 0)


## Gravity
func gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity


func apply_gravity(delta):
	velocity.y += gravity() * delta
	if velocity.y >= max_fall_speed:
		velocity.y = max_fall_speed


## Jumping
func jump():
	velocity.y = jump_velocity
	jump_cut_applied = false
	jump_pressed = false
	jump_buffered = false
	
	if not Input.is_action_pressed("jump"):
		velocity.y /= sustain
		jump_cut_applied = true


func jump_sustain():
	if Input.is_action_just_released("jump") and velocity.y < 0.0 and not jump_cut_applied:
		velocity.y /= sustain
		jump_cut_applied = true


func coyote_time():
	await get_tree().create_timer(0.1).timeout
	can_jump = false


func jump_buffer():
	await get_tree().create_timer(0.1).timeout
	jump_pressed = false
	jump_buffered = false



func screen_wrap():
	if position.x <= -10:
		position.x = get_viewport_rect().size.x
	if position.x >= get_viewport_rect().size.x + 10:
		position.x = 0
	if position.y <= -10:
		position.y = get_viewport_rect().size.y
	if position.y >= get_viewport_rect().size.y + 10:
		position.y = 0
