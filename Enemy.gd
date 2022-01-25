extends KinematicBody2D

export (int) var speed = 100
var velocity = Vector2()
var direction: int
var move_left: Tween
var move_right: Tween

func _ready():
	direction = Utils.Directions.LEFT
	Utils.change_direction($AnimatedSprite, $CollisionShape2D, direction)
	var initial_position = self.get_position()
	move_left = $MoveLeft
	move_left.interpolate_property(self, "position",
	initial_position, Vector2(100, 100), 5,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	
	move_right = $MoveRight
	move_right.interpolate_property(self, "position",
	Vector2(100, 100), initial_position, 5,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	move_left.start()
	


func _on_MoveLeft_tween_completed(object, key):
	direction = Utils.Directions.RIGHT
	Utils.change_direction($AnimatedSprite, $CollisionShape2D, direction)
	move_left.reset(object, key)
	move_right.start()
	


func _on_MoveRight_tween_completed(object, key):
	direction = Utils.Directions.LEFT
	Utils.change_direction($AnimatedSprite, $CollisionShape2D, direction)
	move_right.reset(object, key)
	move_left.start()
