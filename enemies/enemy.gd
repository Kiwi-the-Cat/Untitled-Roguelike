extends CharacterBody2D

@onready var player = get_parent().get_node("Player")

#Combat variables
@export var health:int = 20
@onready var attackTimer:Timer = $Hitbox/AttackTimer
var attacking:bool = true
var dying = false

#Movement Variables
@onready var navAgent = $NavigationAgent2D
var target:Vector2
@export var speed:float = 200
var currentPos:Vector2
var nextPos:Vector2

func _process(_delta):
	#Animations
	if(attacking):
		$AnimatedSprite2D.play("attack")
	elif(health <= 0):
		$AnimatedSprite2D.play("death")
		dying = true
	else:
		$AnimatedSprite2D.play("idle")
	
	#Other updates
	$HealthBar.value = health
	if(player != null && !dying):
		move()
	else:
		attacking = false

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
	attackTimer.start(1)

func _on_animated_sprite_2d_animation_changed():
	if(dying):
		self.queue_free()
