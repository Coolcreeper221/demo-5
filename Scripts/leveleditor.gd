extends Control
var levellist ={}
var updatetime = 0
func _ready():
	
	var file = ResourceLoader.load("user://Levels.tres")
	levellist = file.storage_of_levels
			


func _load(lvl ="a"):
	$TileMap.set_cells_terrain_connect(0,$TileMap.get_used_cells(0),0,-1)
	$TileMap.set_cells_terrain_connect(0,levellist[lvl],0,0)
	print($TileMap.get_used_cells(0))
	

func _process(delta):
	updatetime = delta
func _on_save_pressed():
	if $Control/HBoxContainer/LineEdit.text == "" or $Control/HBoxContainer/LineEdit.text.to_lower() == "base":
		print("no")
		return false
		print("bypassed")
		
	levellist[str($Control/HBoxContainer/LineEdit.text).to_lower()] = $TileMap.get_used_cells(0)
	var levels = Levels.new(levellist)
	ResourceSaver.save(levels,"user://Levels.tres")
	for i in [$Control,$TileMap2,$Cursor]:
		i.hide()
	await RenderingServer.frame_post_draw
	var image = get_viewport().get_texture().get_image()
	image.resize(512,288,Image.INTERPOLATE_NEAREST)
	image.flip_y()
	image.crop(512,256)
	
	image.flip_y()
	image.save_png("user://levels/"+str($Control/HBoxContainer/LineEdit.text).to_lower()+".png")
	
	for i in [$Control,$TileMap2,$Cursor]:
		i.show()

func _on_load_pressed():
	_load($Control/HBoxContainer/LineEdit.text.to_lower())


func _on_exit_pressed():
	get_tree().change_scene_to_file("res://Scenes/map_selector.tscn")
