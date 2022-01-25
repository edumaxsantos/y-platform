extends KinematicBody2D


export (int) var speed = 100
export (int) var jump_speed = -150

var velocity = Vector2()
var animation = "idle"
var attacking = false
var jumping = false
var direction: int

onready var sprite = $AnimatedSprite

func _ready():
	sprite.connect("animation_finished", self, "_on_animation_finished")
	

func get_input():
	velocity.x = 0
	
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var jump = Input.is_action_just_pressed("ui_up")
	var attack = Input.is_action_pressed("player_attack")
	var run = Input.is_action_pressed("player_run")
	jumping = !is_on_floor()
	
	if attacking:
		return
	
	if attack:
		velocity.x = 0
		animation = "attack"
		attacking = true
		return
		
	if is_on_wall():
		velocity.y *= 0.95
		jumping = false
		animation = "jump"
	
	if jump and !jumping:
		velocity.y = jump_speed
		animation = "jump"
		jumping = true
	
	if right:
		velocity.x += speed
		direction = Utils.Directions.RIGHT
	elif left:
		direction = Utils.Directions.LEFT
		velocity.x -= speed
	else:
		animation = "idle"
		
	if velocity.x != 0 and !jumping:
		animation = "run"
		
	if run:
		velocity.x *= 2
	
	

	
func _physics_process(delta):
	get_input()
	Utils.change_direction(sprite, $CollisionShape2D, direction)
	velocity.y += delta * Utils.GLOBAL_GRAVITY
	sprite.play(animation)
	
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	
func _on_animation_finished():
	if attacking == true:
		attacking = false
		animation = "idle"
