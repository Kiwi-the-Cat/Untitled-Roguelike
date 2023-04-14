extends CharacterBody2D

@export var speed:float = 400.
@export var friction:float = 0.1
@export var acceleration:float = 0.7

func get_input():
	#Horizontal movement
	var xDir = Input.get_axis("left", "right")
	if xDir != 0:
		velocity.x = lerp(velocity.x, xDir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
	#Vertical movement
	var yDir = Input.get_axis("up", "down")
	if yDir != 0:
		velocity.y = lerp(velocity.y, yDir * speed, acceleration)
	else:
		velocity.y = lerp(velocity.y, 0.0, friction)


func _physics_process(_delta):
	get_input()
	move_and_slide()
	look_at(get_global_mouse_position())
