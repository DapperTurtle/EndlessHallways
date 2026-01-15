extends StaticBody2D


@onready var animation = $Art/AnimationPlayer
@onready var timer = $Timer


func _ready():
	animation.play("default")


func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		animation.play("crumble")
		timer.start(2)


func _on_timer_timeout():
	animation.play_backwards("crumble")
