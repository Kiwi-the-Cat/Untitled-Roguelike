extends Node2D
@onready var enemyCount:int = 1

func _ready():
	$Player.setCameraLimits(-60, 420, 0, 1150)

func _on_enemy_death():
	enemyCount -= 1
	if(enemyCount <= 0):
		$Exit/CollisionShape2D.disabled = false

func _on_exit_area_entered(area):
	get_tree().change_scene_to_file("res://level/level_4.tscn")
