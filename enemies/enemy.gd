extends CharacterBody2D

@onready var player = get_parent().get_node("Player")

#Combat variables
@export var health:int = 20
signal enemyAttack
var firstHit:bool = true #Fixes enemy instantly hitting on scene start
var attacking:bool = true
@onready var attackTimer:Timer = $EnemyArea/AttackTimer

#Movement Variables
@onready var navAgent = $NavigationAgent2D
var target:Vector2
@export var speed:float = 200
var currentPos:Vector2
var nextPos:Vector2

func _process(delta):
	move()
	$HealthBar.value = health

func move():
	target = Vector2(player.position.x, player.position.y + 10)
	navAgent.set_target_position(target)
	
	currentPos = global_transform.origin
	nextPos = navAgent.get_next_path_position()
	velocity = (nextPos - currentPos).normalized() * speed
	
	if(!attacking): #Prevents enemy from repeatedly hitting player
		velocity *= -1
	
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
	if(!firstHit):
		enemyAttack.emit()
		attacking = false
		attackTimer.start(0.5)
	else:
		firstHit = false


func _on_attack_timer_timeout():
	attacking = true
