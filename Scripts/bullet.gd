
extends CharacterBody2D
class_name Bullet
@export var speed = 150
@export var angle = 0.00001
@export_range(0,2) var  bsize:int = 0
@export var color:int
@export var colors:Array[Color]

var lifetime = 31
var time = 0
func _ready():
	if $"../../TileMap".get_cell_tile_data(0,$"../../TileMap".local_to_map(global_position))!= null:
		show()
	else:
		queue_free()
	while angle ==  0.00001:
		pass
	set_velocity(Vector2(speed,0).rotated(angle))
	$Sprite2D.frame = bsize
	$CollisionShape2D.shape.radius = pow(2,bsize+1)
	
func _physics_process(delta):
	$Sprite2D.material.set_shader_parameter("Replace",colors[color])
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	time += delta
	if time > lifetime:
		queue_free()
