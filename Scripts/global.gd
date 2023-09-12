extends Node

@export var playerstat:Array[bool] = []
@export var player_count = 100
@export var playercolors:Array[int] = [0,0]
@export var playerguns:Array[int] = [0,0]
@export var gameover = false
@warning_ignore("unused_private_class_variable")
@export var _round = 0
@export var scores = [0,0]
@export var level = "base"
func _ready():
	_statsreset()
func _statsreset():
	playerstat = []
	playerstat.resize(player_count+1)
	for i in playerstat.size()-1:
		if i != player_count:
			playerstat[i] = true
func _physics_process(_delta):
	var living = 0
	for i in playerstat.size()-1:
		if playerstat[i] != false:
			living +=1

	if living <2:
		playerstat[player_count] = true
