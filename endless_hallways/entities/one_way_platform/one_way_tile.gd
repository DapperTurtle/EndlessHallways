extends TileMap


var one_way_scene = preload("res://entities/one_way_platform/one_way_platform.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("spawn_platform")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func spawn_platform():
	for cell in get_used_cells(0):
		var one_way = one_way_scene.instantiate()
		
		var local_pos = map_to_local(cell)
		one_way.global_position = to_global(local_pos)
		
		var alternative_tile := get_cell_alternative_tile(0, cell);
		var flip_h := alternative_tile & TileSetAtlasSource.TRANSFORM_FLIP_H;
		var flip_v := alternative_tile & TileSetAtlasSource.TRANSFORM_FLIP_V;
		var transpose := alternative_tile & TileSetAtlasSource.TRANSFORM_TRANSPOSE;
		
		if(!flip_h && !flip_v && !transpose): one_way.rotation_degrees = 0.0;
		if( flip_h && !flip_v &&  transpose): one_way.rotation_degrees = 90.0;
		if( flip_h &&  flip_v && !transpose): one_way.rotation_degrees = 180.0;
		if(!flip_h &&  flip_v &&  transpose): one_way.rotation_degrees = 270.0;
		
		add_child(one_way)
