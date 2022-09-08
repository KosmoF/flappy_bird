extends KinematicBody2D

const UP = Vector2(0, -1)
const FLAP = 200
const MAX_FALL_SPEED = 200
const GRAVITY = 10

var motion = Vector2()
var wall = preload("res://WallNode.tscn")
var score = 0

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	motion.y += GRAVITY
	if motion.y > MAX_FALL_SPEED:
		motion.y = MAX_FALL_SPEED
		
	if Input.is_action_just_pressed("FLAP"):
		motion.y = -FLAP
		
	motion = move_and_slide(motion, UP)
	
	get_node("Label").text = str(score)

func Wall_reset():
	var Wall_instance = wall.instance()
	Wall_instance.position = Vector2(270 * 4, rand_range(-80, 80))
	get_parent().call_deferred("add_child", Wall_instance)

func _on_Resetter_body_entered(body):
	if body.name == "WallBody":
		body.queue_free()
		Wall_reset()

func _on_Detect_area_entered(area):
	if area.name == "PointArea":
		score += 1

func _on_Detect_body_entered(body):
	if body.name == "WallBody":
		get_tree().reload_current_scene()
