extends TileMap
var levellist ={}

func _ready():
	
	var file = ResourceLoader.load("user://Levels.tres")
	levellist = file.storage_of_levels
	_load(Global.level)


func _load(lvl ="a"):
	self.set_cells_terrain_connect(0,self.get_used_cells(0),0,-1)
	self.set_cells_terrain_connect(0,levellist[lvl],0,0)
