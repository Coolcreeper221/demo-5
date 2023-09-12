extends CharacterBody2D

@export_range(0,3) var Playernumber = 3
@export var SPEED = 300.0
@export var angle = 0.0
@export var guntype = 0
@export var Controller = false
@export var Up = KEY_W
@export var Down = KEY_S
@export var Left = KEY_A
@export var Right = KEY_D
@export var Fire = KEY_SPACE
var firerate = 0.2
var lastfire = 0.0
func _ready():
	$Marker2D/Gun.Type = Global.playerguns[Playernumber-1]
	$Marker2D/Gun._ready()
	firerate = $Marker2D/Gun.Fire_rate
	$Sprite.region_rect.position.y =Global.playercolors[Playernumber-1] * 144
	$Marker2D/Hands.frame = Global.playercolors[Playernumber-1]
	if Global._round == 0:
		
		var leftaction=InputEventKey.new()
		InputMap.add_action("left"+str(Playernumber))
		leftaction.keycode = Left
		InputMap.action_add_event("left"+str(Playernumber),leftaction)
		var rightaction=InputEventKey.new()
		InputMap.add_action("right"+str(Playernumber))
		rightaction.keycode = Right
		InputMap.action_add_event("right"+str(Playernumber),rightaction)
		var upaction=InputEventKey.new()
		InputMap.add_action("up"+str(Playernumber))
		upaction.keycode = Up
		InputMap.action_add_event("up"+str(Playernumber),upaction)
		var Downaction=InputEventKey.new()
		InputMap.add_action("down"+str(Playernumber))
		Downaction.keycode = Down
		InputMap.action_add_event("down"+str(Playernumber),Downaction)
		var Fireaction=InputEventKey.new()
		InputMap.add_action("Fire"+str(Playernumber))
		Fireaction.keycode = Fire
		InputMap.action_add_event("Fire"+str(Playernumber),Fireaction)
		await get_tree().create_timer(0.1).timeout
		Global._round =1
	
	
func _physics_process(delta):


	var direction = Vector2(Input.get_axis("left"+str(Playernumber),"right"+str(Playernumber)),Input.get_axis("up"+str(Playernumber),"down"+str(Playernumber)))
	
	if direction:
		velocity = velocity.move_toward(direction * SPEED,delta*SPEED*4)
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO,delta*SPEED*4)
		
	
	if !Controller and direction:
		angle = wrap(rad_to_deg(direction.angle()),0,360)
		
	if 90 < wrap($Marker2D.rotation_degrees,0,360) and wrap($Marker2D.rotation_degrees,0,360) <270:
		$Marker2D.scale.y = -1
		
	else:
		$Marker2D.scale.y = 1
	if 90< angle and angle <270:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false
	$Marker2D.rotation = lerp_angle($Marker2D.rotation,deg_to_rad(angle),delta*4)
	move_and_slide()
	var fire = false
	if Input.is_action_pressed("Fire"+str(Playernumber)          ) and firerate < lastfire:
		fire = true
		lastfire = 0
		if $"../TileMap".get_cell_tile_data(0,Vector2i($Marker2D/Gun/Marker2D.global_position/16)) != null:
			fire = true
			lastfire = 0
			var bullet = load("res://Scenes/bullet.tscn").instantiate()
			bullet.global_position = $Marker2D/Gun/Marker2D.global_position
			bullet.bsize = $Marker2D/Gun.bullet_Size
			bullet.angle = $Marker2D.rotation
			bullet.hide()
			bullet.color = Global.playercolors[Playernumber-1]
			$"../Bullets".add_child(bullet)
			$AudioStreamPlayer.play()
	lastfire += delta
	_animate(velocity,fire)
	if Global.playerstat[Global.player_count] == true and Global.playerstat[Playernumber] == true:
		$AnimationPlayer.play("Win")
		Global.scores[Playernumber] += 1
		$Marker2D.hide()
		Global.gameover = true
		set_physics_process(false)
func  _animate(dir,firing):
	if firing == true:
		$AnimationPlayer.play("Attack")
	elif $AnimationPlayer.is_playing() and $AnimationPlayer.current_animation == "Attack":
		pass
	else:
		if dir.length() >SPEED/2:
			$AnimationPlayer.play("Run")
		else:
			$AnimationPlayer.play("Idle")



func _on_hitbox_body_entered(body):
	if body is Bullet and is_physics_processing():
		set_physics_process(false)
		$AnimationPlayer.play("Die")
		$Marker2D.hide()
		Global.playerstat[Playernumber] = false
	
		
