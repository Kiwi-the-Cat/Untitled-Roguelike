class_name StateMachine
extends Node

# Emmited when transitioning to a new state
signal Transitioned(state_name)

@export var initial_state := NodePath()

var _facing = null
var _moving = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
