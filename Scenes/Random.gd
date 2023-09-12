
extends AudioStreamPlayer
@export var sequence = false
@export var List:Array[AudioStream]
# Called when the node enters t he scene tree for the first time.
func _ready():
	if sequence == false:
		randomize()
		var random = randi_range(0,List.size()-1)
		stream = List[random]
		play()
	else:
		for i in List.size():
			stream = List[i]
			play()
	
			await finished
			
	for i in 22:
		volume_db = -10+i/2
		await get_tree().create_timer(0.2).timeout
