extends Node2D

func _ready():
	$Player/Camera2D.limit_top = -60
	$Player/Camera2D.limit_left = 0
	$Player/Camera2D.limit_right = 1150
	$Player/Camera2D.limit_bottom = 420
