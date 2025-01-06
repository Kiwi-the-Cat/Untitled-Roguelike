extends Node2D
@onready var enemyCount:int = 3

func _ready():
	$Player.setCameraLimits(0, 1050, 0, 760)

func _on_enemy_death():
	enemyCount -= 1
	if(enemyCount <= 0):
		$Exit/CollisionShape2D.disabled = false


func _on_exit_area_entered(area):
	get_tree().change_scene_to_file("res://level/Area_1/bottom_" + str(randi_range(1, 2)) + ".tscn")
