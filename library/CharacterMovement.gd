extends CharacterBody2D

#Physics varables
var speed:int = 200
var friction:float = 0.1
var acceleration:float = 0.7

#Variables for rolling
var rolling:bool
var roll_time:float = .5 #How long the player rolls
var roll_timer:Timer #Timer active while rolling
var roll_cooldown:Timer #Timer to prevent consecutive rolling

func _ready():
	#Sets variables to coressponding timers
	roll_timer = $RollTimer
	roll_cooldown = $RollCooldown

func _physics_process(delta):
	move()
	if rolling: #Spins while rolling
#		$CollisionShape2D.rotation += 12.6 * delta
		pass
	else:
		look_at(get_global_mouse_position())

func roll():
	rolling = !roll_timer.is_stopped()
	var tween = get_tree().create_tween()
	if Input.is_action_just_pressed("roll") && roll_cooldown.get_time_left() == 0:
		roll_timer.start(roll_time)
		roll_cooldown.start(roll_time * 5)
		tween.tween_property($CollisionShape2D, "rotation_degrees", 360, 0.5)
		$CollisionShape2D.rotation_degrees = 0


func move(): #All stuff to make character move
	#Speed adjustment if rolling
	if rolling:
		speed = 400
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
	
	#Calling other nessicary movement functions
	roll()
	move_and_slide()

func _process(delta):
	var rota:String = str($CollisionShape2D.rotation_degrees)
	$Control/Label.set_text(rota)
	$Control/Label2.set_text(str(delta))
