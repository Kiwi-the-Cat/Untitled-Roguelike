extends Node2D
@onready var enemyCount:int = 2

func _ready():
	$Player.setCameraLimits(0, 670, 0, 1180)

func _on_enemy_death():
	enemyCount -= 1
	if(enemyCount <= 0):
		$Exit1/CollisionShape2D.disabled = false
		$Exit2/CollisionShape2D.disabled = false
