extends CharacterBody2D

@onready var player = get_parent().get_node("Player")

#Combat variables
@export var health:int = 20
signal enemyAttack

#Movement
@onready var navAgent = $NavigationAgent2D
var target:Vector2;
var speed:int = 100

func _process(delta):
	move()

func move():
	target = Vector2(player.position.x, player.position.y)
	navAgent.set_target_position(target)
	
	if(position.distance_to(target) > 0.5):
		var currentPos = global_transform.origin
		var nextPos = navAgent.get_next_path_position()
		velocity = (nextPos - currentPos).normalized() * speed
		move_and_slide()

func hurt():
	health -= 2
	print("Enemy: ", health)
	if(health <= 0):
		print("Dead")
		get_parent().remove_child(self)

func _on_player_knife_active():
	hurt()

func _on_enemy_area_body_entered(body):
	enemyAttack.emit()
