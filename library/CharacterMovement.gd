extends CharacterBody2D

@export var speed = 200
var friction = 0.1
var acceleration = 0.7

var rolling = false
var roll_timer = 0
var roll_cooldown = 0

func get_input():
	#Speed adjustment if rolling
	if roll_timer > 30:
		speed = 800
	else:
		speed = 200
	
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

func roll():
	if Input.is_action_just_pressed("roll") && roll_timer <= 0 && roll_cooldown <= 0:
		roll_timer = 50
	if roll_timer > 0:
		roll_timer -= 1
		roll_cooldown = 100
		rolling = true
	elif roll_cooldown >= 0:
		roll_cooldown -= 1
		rolling = false

func _physics_process(delta):
	roll()
	get_input()
	move_and_slide()
	if rolling:
		rotation += 20 * delta
	else:
		look_at(get_global_mouse_position())
