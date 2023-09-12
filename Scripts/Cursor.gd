extends Node2D

@warning_ignore("integer_division")
var target = Vector2(256,144)
var tiles:Array[Vector2]
# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(0.1).timeout
	get_viewport().warp_mouse(Vector2(256,144))
func _physics_process(delta):
	position = position.move_toward(target,delta*1280)
func _input(event):
	if event is InputEventKey or event is InputEventJoypadMotion or event is InputEventJoypadButton:
		if Input.is_action_just_pressed("ui_left"):
			target.x -= 16
		if Input.is_action_just_pressed("ui_right"):
			target.x += 16
		if Input.is_action_just_pressed("ui_down"):
			target.y += 16
		if Input.is_action_just_pressed("ui_up"):
			target.y -= 16
		if Input.is_action_pressed("ui_accept"):
			var pos = $"../TileMap".local_to_map(self.position)
			tile(pos,false)
		if Input.is_action_pressed("ui_cancel"):
			var pos = $"../TileMap".local_to_map(self.position)
			tile(pos,true)
	if event is InputEventMouse:
		var pos = $"../TileMap".local_to_map(event.position)
		if tile(pos,true,true):
			target=pos*16

		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		if event is InputEventMouseMotion:
			
			if event.pressure > 0 and event.button_mask == 1:
				tile(pos,false)
				Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
			elif event.button_mask == 2:
				tile(pos,true)
				Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
			
		else:
			
			if event.is_pressed() and event.button_index==1:
				tile(pos,false)
				Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
			elif event.is_pressed() and event.button_index==2:
				tile(pos,true)
				Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
			else:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
func tile(pos,block,test = false):

	var no = [Rect2(0,128,64,64),Rect2(448,128,64,64),Rect2(0,-16,512,80),Rect2(0,288-32,512,32),Rect2(-16,0,48,288),Rect2(512-32,0,48,288)]
	
	for i in no:
		if i.has_point(pos*16):
			
			return false
	
	if test == false:	
		if block != true:
			$"../TileMap".set_cells_terrain_connect(0,[pos],0,-1)
		else:
			$"../TileMap".set_cells_terrain_connect(0,[pos],0,0)
	return true
