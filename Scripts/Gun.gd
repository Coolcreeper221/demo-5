@tool
extends Node2D

class_name Gun

var Offest = Vector2.ZERO
@export_range(0,44) var Type:int = 0
@export_range(0,2) var bullet_Size = 0


@export var Fire_rate = 0.2

var offsets = [Vector2(2, -2), Vector2(4, -1), Vector2(3, -1), Vector2(4, -2), Vector2(2, -1), Vector2(4, -1), Vector2(4, -1), Vector2(4, -1), Vector2(3, -1), Vector2(3, -1), Vector2(3, -1), Vector2(3, 0), Vector2(2, -1), Vector2(2, -2), Vector2(9, -2), Vector2(5, -2), Vector2(2, -3), Vector2(4, -1), Vector2(4, -1), Vector2(3, -1), Vector2(3, -1), Vector2(6, -3), Vector2(6, -3), Vector2(1, -1), Vector2(7, -3), Vector2(7, -3), Vector2(8, -3), Vector2(6, -2), Vector2(9, -1), Vector2(6, -3), Vector2(6, -3), Vector2(6, -3), Vector2(9, -4), Vector2(3, -5), Vector2(3, -7), Vector2(6, -5), Vector2(2, -3), Vector2(4, -2), Vector2(9, -1), Vector2(4, -2), Vector2(1, 0), Vector2(0, -2), Vector2(2, -3), Vector2(6, -3), Vector2(4, -3), Vector2(0, 0)]

var bullet_offsets:Array[Vector2] = [Vector2(8, -2), Vector2(12, -3), Vector2(10, -1), Vector2(12, -1), Vector2(7, -2), Vector2(12, -1), Vector2(13, 0), Vector2(12, -1), Vector2(9, -2), Vector2(10, -1), Vector2(10, -2), Vector2(11, -1), Vector2(12, -2), Vector2(10, -4), Vector2(22, -3), Vector2(15, -1), Vector2(14, -3), Vector2(12, -1), Vector2(14, -1), Vector2(11, -2), Vector2(9, -2), Vector2(17, -3), Vector2(18, -3), Vector2(5, -2), Vector2(21, -4), Vector2(18, -3), Vector2(23, -4), Vector2(18, -2), Vector2(23, -2), Vector2(19, -3), Vector2(19, -4), Vector2(18, -4), Vector2(25, -7), Vector2(17, -3), Vector2(22, -7), Vector2(22, -5), Vector2(12, -2), Vector2(13, -2), Vector2(25, -2), Vector2(17, -2), Vector2(18, -2), Vector2(17, -2), Vector2(15, -3), Vector2(23, -5), Vector2(19, -3), Vector2(0, 0)]
var Firerates = [0.43, 0.5, 0.5, 0.2, 0.5, 0.4, 0.3, 0.5, 0.3, 0.5, 0.6, 0.7, 0.4, 0.8, 0.5, 0.4, 0.4, 0.4, 0.4, 0.5, 0.3, 0.3, 0.2, 0.7, 0.6, 0.4, 0.6, 0.25, 0.8, 0.7, 0.5, 0.3, 0.2, 0.4, 0.4, 0.4, 0.1, 0.7, 0.4, 0.7, 0.4, 0.3, 0.4, 0.4, 0.2, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4]
var bsizes = [1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 2, 1, 2, 1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
@export var update = false
var pretype = 0
var lastfire = 0.0
func _ready():
	$Sprite.frame = Type
	Offest = offsets[Type]
	$Sprite.position = Offest
	$Marker2D.position = bullet_offsets[Type]
	Fire_rate = Firerates[Type]
	bullet_Size = bsizes[Type]
	for i in $Marker2D.get_children():
		i.queue_free()
func _physics_process(_delta):
	if Engine.is_editor_hint():
	
		if pretype != Type:
			pretype = Type
			$Sprite.frame = pretype
			Offest = offsets[pretype]
			Fire_rate = Firerates[Type]
			bullet_Size = bsizes[Type]
			$Marker2D.position = bullet_offsets[Type]
		else:
			offsets[Type] = $Sprite.position
			bullet_offsets[Type] = $Marker2D.position
			Firerates[Type] = Fire_rate
			bsizes[Type] = bullet_Size
			#if Fire_rate < lastfire:
				#lastfire = 0
				#var bullet = load("res://Scenes/bullet.tscn").instantiate()
				#bullet.global_position = $Marker2D.position
				#bullet.bsize = bullet_Size
				#bullet.angle = 0
				#$Marker2D.add_child(bullet)
			#lastfire += delta
			
			
