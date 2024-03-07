extends CharacterBody2D

const SPEED : float = 300.0
const JUMP_VELOCITY : float = -400.0

@onready var playerSprite : AnimatedSprite2D = $Sprite


func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX = Input.get_axis("ui_left", "ui_right")
	if directionX:
		velocity.x = directionX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var directionY = Input.get_axis("ui_up", "ui_down")
	if directionY:
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()


func _process(delta):
	#print(velocity)
	if (velocity.x < .1 and velocity.x > -.1) and (velocity.y < .1 and velocity.y > -.1):
		playerSprite.play("idle")
	elif (velocity.x > .1 or velocity.x < -.1) and (velocity.y > .1 or velocity.y < -.1):
		playerSprite.play("walk")
