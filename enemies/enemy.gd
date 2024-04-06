extends CharacterBody2D

@onready var player = get_parent().get_node("Player")

#Combat variables
@export var health:int = 20
signal enemyAttack
#var firstHit:bool = true #Fixes enemy instantly hitting on scene start
var attacking:bool = true
@onready var attackTimer:Timer = $Hitbox/AttackTimer

#Movement Variables
@onready var navAgent = $NavigationAgent2D
var target:Vector2
@export var speed:float = 200
var currentPos:Vector2
var nextPos:Vector2

func _process(_delta):
	if(attacking):
		$AnimatedSprite2D.play("attack")
	elif(health <= 0):
		$AnimatedSprite2D.play("death")
	else:
		$AnimatedSprite2D.play("idle")
	if(player != null):
		move()

func move():
	target = Vector2(player.position.x, player.position.y)
	navAgent.set_target_position(target)
	
	currentPos = global_transform.origin
	nextPos = navAgent.get_next_path_position()
	velocity = (nextPos - currentPos).normalized() * speed
	
	if(!attacking): #Prevents enemy from repeatedly hitting player
		velocity *= -1
	
	move_and_slide()

func _on_attack_timer_timeout():
	attacking = true

func _on_hitbox_area_entered(_area):
	attacking = false
	attackTimer.start(0.5)
