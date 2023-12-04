extends CharacterBody2D

#Combat variables
signal knife_active

@export var health:int = 20

#Physics variables
@export var speed:int
@export var friction:float = 0.1
@export var acceleration:float = 0.7

#Variables for rolling
var rolling:bool
var roll_time:float = .5 #How long the player rolls
@onready var roll_timer:Timer = $RollTimer #Timer active while rolling
@onready var roll_cooldown:Timer = $RollCooldown #Timer to prevent consecutive rolling

#Animation Variables
@onready var _player = $PlayerCollision/AnimatedSprite2D
@onready var animation_tree:AnimationTree = $AnimationTree

func _physics_process(delta):
	move()

func roll():
	rolling = !roll_timer.is_stopped()
	if Input.is_action_just_pressed("roll") && roll_cooldown.get_time_left() == 0:
		var tween = get_tree().create_tween()
		roll_timer.start(roll_time)
		roll_cooldown.start(roll_time * 5)
		tween.tween_property($PlayerCollision, "rotation_degrees", 360, 0.5)
		$PlayerCollision.rotation_degrees = 0

func move(): #All stuff to make character move
	#Speed adjustment if rolling
	if rolling:
		speed = 300
	else:
		speed = 150
	
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
	print(rad_to_deg(get_angle_to(get_global_mouse_position())))
	var rota:String = str($PlayerCollision.rotation_degrees)
	
	var mousePos:Vector2i = get_global_mouse_position() #Global mouse position
	var screenX:float = get_viewport().size.x #Viewport X axis 
	var screenY:float = get_viewport().size.y #Viewport Y axis
	var xPercent:float = mousePos.x / screenX
	var yPercent:float = mousePos.y / screenY
	

	#Enables knife attack when mouse is clicked
	if Input.is_action_pressed("attack"):
		$Knife.visible = true
		$Knife/KnifeCollision.disabled = false
		$Knife.look_at(Vector2(mousePos.x, mousePos.y))
	else:
		$Knife.visible = false
		$Knife/KnifeCollision.disabled = true

func _on_exit_body_entered(body): #Level Transistions
	match get_tree().current_scene.name:
		"LevelOne":
			get_tree().change_scene_to_file("res://levels/LevelTwo.tscn")
		"LevelTwo":
			get_tree().change_scene_to_file("res://levels/LevelThree.tscn")

func update_animation_parameters():
	pass

func _on_knife_body_entered(body):
	knife_active.emit()

func hurt():
	health -= 2;
	print("Player: ", health)

func _on_enemy_enemy_attack():
	hurt();
