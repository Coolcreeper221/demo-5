extends Node2D

func _ready():
	var children = get_children()
	var players = 0
	for i in children:
		if "Player" in i.name:
			players += 1
	Global.player_count = players-1
	Global._statsreset()
	
