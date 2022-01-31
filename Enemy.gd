extends KinematicBody2D

export (int) var speed = 100
var velocity = Vector2()
var direction: int

func _ready():
	direction = Utils.Directions.LEFT
	Utils.change_direction($AnimatedSprite, $CollisionShape2D, direction)


