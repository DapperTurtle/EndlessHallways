extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://levels/tutorial/1.tscn")


func _on_spike_pressed():
	get_tree().change_scene_to_file("res://levels/spike/1.tscn")


func _on_cursed_toggled(toggled_on):
	if toggled_on == true:
		Global.cursed = true
	elif toggled_on == false:
		Global.cursed = false
	print(Global.cursed)


func _on_crumble_pressed():
	get_tree().change_scene_to_file("res://levels/crumble/1.tscn")
