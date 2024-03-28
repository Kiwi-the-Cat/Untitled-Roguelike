extends CharacterBody2D

@onready var player = get_parent().get_node("Player")

#Movement Variables
@onready var navAgent = $NavigationAgent2D
var target:Vector2
@export var speed:float = 200
var currentPos:Vector2
var nextPos:Vector2

func _process(delta):
	move()

func move():
	target = Vector2(player.position.x, player.position.y)
	navAgent.set_target_position(target)
	
	currentPos = global_transform.origin
	nextPos = navAgent.get_next_path_position()
	velocity = (nextPos - currentPos).normalized() * speed
	
	move_and_slide()
