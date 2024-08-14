extends Node2D
@onready var enemyCount:int = 3

func _ready():
	$Player.setCameraLimits(0, 1050, 0, 760)

func _on_enemy_death():
	enemyCount -= 1
	if(enemyCount <= 0):
		pass
