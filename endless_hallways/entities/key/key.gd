extends CharacterBody2D


@export var speed : float


var collected = false
var door_position
var target_position


func _ready():
	pass


func _process(delta):
	if collected == false:
		stop()
	if collected == true:
		move()
	
	move_and_slide()


func stop():
	velocity = Vector2.ZERO


func move():
	door_position = Global.door_position
	target_position = (door_position - position).normalized()
	
	velocity += target_position * speed


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		collected = true
		Global.emit_signal("key_collect")


func _on_area_2d_area_entered(area):
	if area.is_in_group("door"):
		queue_free()
