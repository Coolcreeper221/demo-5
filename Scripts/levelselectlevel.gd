extends Control

@export var level_name = ""

func _ready():
	$Label.text = level_name
	if level_name == "base":
		var image = Image.load_from_file("res://Scenes/levelselect/base.png")
		var image_texture = ImageTexture.new()
		image_texture.set_image(image)
		$Sprite2D.texture = image_texture
		return
	var image = Image.load_from_file("user://levels/"+level_name+".png")
	var image_texture = ImageTexture.new()
	image_texture.set_image(image)
	$Sprite2D.texture = image_texture
	
	
		


func _on_pressed():
	$"../../..".set_level(level_name)
	Global.level = level_name
	
