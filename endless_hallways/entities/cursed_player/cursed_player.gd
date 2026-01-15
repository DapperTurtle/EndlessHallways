extends CharacterBody2D


@export var acceleration : float
@export var speed : float


var player_position
var target_position


func _physics_process(delta):
	move_and_slide()


func stop():
	velocity.x = 0
	velocity.y = 0


func move():
	player_position = Global.player_position
	target_position = (player_position - position).normalized()
	
	velocity = velocity.move_toward(target_position * speed, speed * acceleration)


func _on_hitbox_body_entered(body):
	if body.is_in_group("player"):
		get_tree().reload_current_scene()
