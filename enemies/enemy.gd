extends CharacterBody2D

@onready var player = get_parent().get_node("Player")
@onready var sprite = $AnimatedSprite2D

#Combat variables
@export var health:int = 20
@onready var attackTimer:Timer = $Hitbox/AttackTimer
@onready var retreatTimer:Timer = $Hitbox/RetreatTimer
var attacking:bool = true
var state:String = "idle"

#Movement Variables
@onready var navAgent = $NavigationAgent2D
var target:Vector2
@export var speed:float = 200
var currentPos:Vector2
var nextPos:Vector2

func _process(_delta):
	sprite.play(state)
	
	$HealthBar.value = health
	if(player != null && state != "death"):
		move()
	
	#Checks for dying
	if(sprite.animation == "death" && sprite.frame == 4):
		self.free()
	elif(health <= 0):
		state = "death"

func move():
	target = Vector2(player.position.x, player.position.y)
	navAgent.set_target_position(target)
	
	currentPos = global_transform.origin
	nextPos = navAgent.get_next_path_position()
	velocity = (nextPos - currentPos).normalized() * speed
	
	if(state == "attack"):
		velocity *= 0
	elif(!attacking): #Prevents enemy from repeatedly hitting player
		velocity *= -1
	
	move_and_slide()

func _on_retreat_timer_timeout():
	state = "idle"

func _on_attack_timer_timeout():
	attacking = true

func _on_hitbox_area_entered(_area):
	retreatTimer.start(0.5)
	attackTimer.start(1.5)
	attacking = false
	state = "attack"
