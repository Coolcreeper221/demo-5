extends Node2D
@export var colors:Array[Color] = [Color(0.996078, 0.996078, 0.996078, 1), Color(0.847656, 0.339844, 0.386719, 1), Color(0.371094, 0.800781, 0.890625, 1), Color(0.597656, 0.894531, 0.3125, 1), Color(0.515625, 0.492188, 0.527344, 1), Color(0.839844, 0.480469, 0.726563, 1)]
var lastsceene
var f = true
var timer = 0
func _physics_process(delta):
	if get_tree().current_scene.name == "Test":
		$CanvasLayer/HBoxContainer.show()
		$CanvasLayer/HBoxContainer2.hide()
	elif get_tree().current_scene.name == "Menu":
		$CanvasLayer/HBoxContainer2.show()
		$CanvasLayer/HBoxContainer.hide()
		timer = 1
	else:
		$CanvasLayer/HBoxContainer.hide()
		$CanvasLayer/HBoxContainer2.hide()
	if Global.gameover ==true:
		$CanvasLayer/ColorRect.material.set_shader_parameter("line_color_b",colors[Global.playercolors[0]])
		$CanvasLayer/ColorRect.material.set_shader_parameter("line_color_a",colors[Global.playercolors[1]])
		
		if timer < 1:
			timer+=delta
		else:
			
			$CanvasLayer/ColorRect.material.set_shader_parameter("y_threshold", move_toward($CanvasLayer/ColorRect.material.get_shader_parameter("y_threshold"),2,delta*1.5))
		if $CanvasLayer/ColorRect.material.get_shader_parameter("y_threshold") >= 2:
			lastsceene = get_tree().current_scene
			if Global._round < 5:
				get_tree().change_scene_to_file("res://Scenes/test.tscn")
				Global._round += 1
				$CanvasLayer/HBoxContainer/Label.text = str(Global.scores[0])
				$CanvasLayer/HBoxContainer/Label2.text = str(Global.scores[1])
				
			else:
				get_tree().change_scene_to_file("res://Scenes/Playersellect.tscn")
				Global._round = 1
				if Global.scores[0] > Global.scores[1]:
					$CanvasLayer/HBoxContainer2/Label.text = "Winner"
					$CanvasLayer/HBoxContainer2/Label2.text = "Loser"
				else:
					$CanvasLayer/HBoxContainer2/Label.text = "Loser"
					$CanvasLayer/HBoxContainer2/Label2.text = "Winner"
				Global.scores = [0,0]
				
			Global.gameover = !true
			timer = 0
			f = false
	if f == false:
		$CanvasLayer/ColorRect.material.set_shader_parameter("y_threshold", move_toward($CanvasLayer/ColorRect.material.get_shader_parameter("y_threshold"),0,delta*1.5))
		if $CanvasLayer/ColorRect.material.get_shader_parameter("y_threshold") <= 0:
			lastsceene = get_tree().current_scene
			f=true
	
func _input(_event):
	if f==false:
		get_viewport().set_input_as_handled()
		
	
