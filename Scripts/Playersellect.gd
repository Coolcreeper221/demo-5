extends Control
@export var focusscale = 1.0
var basesize = Vector2(0,1)
var basepos = Vector2(0,0)

func _ready() -> void:
	get_viewport().connect("gui_focus_changed",_on_focus_changed)
	$HBoxContainer/Left/VBoxContainer/HBoxContainer/Control/Sprite.region_rect.position.y = Global.playercolors[1]*144
	$HBoxContainer/Right/VBoxContainer/HBoxContainer/Control/Sprite.region_rect.position.y = Global.playercolors[0]*144
	$HBoxContainer/Left/VBoxContainer/HBoxContainer2/Control/Gun.frame = Global.playerguns[1]
	$HBoxContainer/Right/VBoxContainer/HBoxContainer2/Control/Gun.frame = Global.playerguns[0]
	await  get_tree().create_timer(.2).timeout
	$HBoxContainer/Left/VBoxContainer/HBoxContainer/LB.grab_focus()
	$Hover/NinePatchRect/AnimationPlayer.play("new_animation")

	
		
func _on_focus_changed(control:Control) -> void:
	if control != null:
		
		basesize = control.size
		basepos = control.global_position  
		


func _on_lb_pressed():
	Global.playercolors[1] = wrap(Global.playercolors[1]-1,0,5)
	$HBoxContainer/Left/VBoxContainer/HBoxContainer/Control/Sprite.region_rect.position.y = Global.playercolors[1]*144
	

func _on_lf_pressed():
	Global.playercolors[1] = wrap(Global.playercolors[1]+1,0,5)
	$HBoxContainer/Left/VBoxContainer/HBoxContainer/Control/Sprite.region_rect.position.y = Global.playercolors[1]*144
	

func _on_rb_pressed():
	Global.playercolors[0] = wrap(Global.playercolors[0]-1,0,5)
	$HBoxContainer/Right/VBoxContainer/HBoxContainer/Control/Sprite.region_rect.position.y = Global.playercolors[0]*144
	

func _on_rf_pressed():
	Global.playercolors[0] = wrap(Global.playercolors[0]+1,0,5)
	$HBoxContainer/Right/VBoxContainer/HBoxContainer/Control/Sprite.region_rect.position.y = Global.playercolors[0]*144
	
func _physics_process(_delta):

	$Hover/NinePatchRect.size = basesize * focusscale
	$Hover/NinePatchRect.position = (basepos + basesize/2) - ($Hover/NinePatchRect.size/2)


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/test.tscn")


func _on_quit_pressed():
	$AudioStreamPlayer.stream = load("res://Assets/Exit.wav")
	$AudioStreamPlayer.play()
	await $AudioStreamPlayer.finished
	get_tree().quit()


func _on_glb_pressed():
	Global.playerguns[1] = wrap(Global.playerguns[1]-1,0,45)
	$HBoxContainer/Left/VBoxContainer/HBoxContainer2/Control/Gun.frame = Global.playerguns[1]
	

func _on_glf_pressed():
	Global.playerguns[1] = wrap(Global.playerguns[1]+1,0,45)
	$HBoxContainer/Left/VBoxContainer/HBoxContainer2/Control/Gun.frame = Global.playerguns[1]


func _on_grb_pressed():
	Global.playerguns[0] = wrap(Global.playerguns[0]-1,0,45)
	$HBoxContainer/Right/VBoxContainer/HBoxContainer2/Control/Gun.frame = Global.playerguns[0]


func _on_grf_pressed():
	Global.playerguns[0] = wrap(Global.playerguns[0]+1,0,45)
	$HBoxContainer/Right/VBoxContainer/HBoxContainer2/Control/Gun.frame = Global.playerguns[0]


func _on_maps_pressed():
	get_tree().change_scene_to_file("res://Scenes/map_selector.tscn")
