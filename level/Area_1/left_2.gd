extends Node2D
@onready var enemyCount:int = 3

func _ready():
	$Player/Camera2D.zoom = Vector2(3, 3)
	$Player.setCameraLimits(0, 670, 0, 1240)

func _on_enemy_death():
	enemyCount -= 1
	if(enemyCount <= 0):
		$Exit1/CollisionShape2D.disabled = false
		$Exit2/CollisionShape2D.disabled = false


func _on_exit_1_area_entered(area):
	get_tree().change_scene_to_file("res://level/Area_1/left_" + str(randi_range(1, 2)) + ".tscn")


func _on_exit_2_area_entered(area):
	get_tree().change_scene_to_file("res://level/Area_1/bottom_" + str(randi_range(1, 2)) + ".tscn")
