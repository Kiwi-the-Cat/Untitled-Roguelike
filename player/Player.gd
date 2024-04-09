extends CharacterBody2D

const SPEED : float = 300.0
const JUMP_VELOCITY : float = -400.0

@onready var playerSprite : AnimatedSprite2D = $Sprite

func _physics_process(_delta):
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

func _process(_delta):
	if (velocity == Vector2(0, 0)):
		playerSprite.play("idle")
	elif (velocity.x > 0 or velocity.x < 0) or (velocity.y > .1 or velocity.y < -.1):
		playerSprite.play("walk")
	
	var mouseAngle = rad_to_deg(get_angle_to(get_global_mouse_position()))
	$Sprite.flip_h = mouseAngle > -90 && mouseAngle < 90

func setCameraLimits(top, bottom, left, right):
	$Camera2D.limit_top = top
	$Camera2D.limit_bottom = bottom
	$Camera2D.limit_left = left
	$Camera2D.limit_right = right
