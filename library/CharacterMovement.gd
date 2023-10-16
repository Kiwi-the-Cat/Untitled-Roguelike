extends CharacterBody2D

#Physics varables
@export var speed:int = 300
@export var friction:float = 0.1
@export var acceleration:float = 0.7

#Variables for rolling
var rolling:bool
var roll_time:float = .5 #How long the player rolls
var roll_timer:Timer #Timer active while rolling
var roll_cooldown:Timer #Timer to prevent consecutive rolling

#Animation Variables
@onready var _player = $CollisionShape2D/AnimatedSprite2D

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
		pass

func roll():
	rolling = !roll_timer.is_stopped()
	if Input.is_action_just_pressed("roll") && roll_cooldown.get_time_left() == 0:
		var tween = get_tree().create_tween()
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
	velocity.normalized()

func _process(delta):
	var rota:String = str($CollisionShape2D.rotation_degrees)
	
	var mousePos:Vector2i = get_global_mouse_position() #Global mouse position
	var screenX:float = get_viewport().size.x #Viewport X axis 
	var screenY:float = get_viewport().size.y #Viewport Y axis
	var xPercent:float = mousePos.x / screenX
	var yPercent:float = mousePos.y / screenY
	
	if   (yPercent >= 0.25) && (velocity.x <= 1 && velocity.y <= 1): #Plays foward idle animation when mouse is on bottom half of player
		_player.play("idle_foward")
		
	elif (yPercent <= -0.25) && (velocity.x <= 1 && velocity.y <= 1) && (xPercent <= -0.5 && xPercent >= 0.5): #Plays back idle animation when mouse is on top half of player
		_player.play("idle_back")
		
	elif (xPercent <= -0.25) && (velocity.x <= 1 && velocity.y <= 1):
		_player.play("idle_left")
		
	else:
		_player.stop()



func _on_exit_body_entered(body):
	get_tree().change_scene_to_file("res://levels/LevelTwo.tscn")
