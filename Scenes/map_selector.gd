extends Control
var levellist ={}

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 2:
		if  !FileAccess.file_exists("user://Levels.tres"):
			var levels = Levels.new()
			ResourceSaver.save(levels,"user://Levels.tres")
			var dir = DirAccess.open("user://")
			dir.make_dir("levels")
			
			
		
		else:
			var file = ResourceLoader.load("user://Levels.tres")
			levellist = file.storage_of_levels
	for i in levellist.keys():
		
		var lvl = load("res://Scenes/levelselect/level.tscn").instantiate()
		lvl.level_name = i
		$"ScrollContainer/GridContainer".add_child(lvl,true)
	$Control/HBoxContainer/current.text = "Current: "+ Global.level
func _process(delta):
	pass
func set_level(level_name):
	$Control/HBoxContainer/current.text = "Current: "+level_name
	


func _on_create_pressed():
	get_tree().change_scene_to_file("res://Scenes/leveleditor.tscn")


func _on_exit_pressed():
	get_tree().change_scene_to_file("res://Scenes/Playersellect.tscn")
