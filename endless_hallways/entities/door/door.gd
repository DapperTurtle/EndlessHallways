extends Area2D


@export var next_level : String


var open = false


@onready var sprite = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.door_position = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if open == false:
		sprite.frame = 0
	elif open == true:
		sprite.frame = 1


func _on_body_entered(body):
	if body.is_in_group("player"):
		if open == true:
			if next_level:
				get_tree().change_scene_to_file(next_level)


func _on_area_entered(area):
	if area.is_in_group("key"):
		open = true
		Global.emit_signal("door_unlock")
