class_name Utils

const GLOBAL_GRAVITY = 250

enum Directions {
	RIGHT, LEFT, UP, DOWN
}

static func change_direction(sprite: AnimatedSprite, collision: CollisionShape2D,  direction):
	if direction == Directions.LEFT:
		sprite.flip_h = true
		if collision.position.x < 0:
			collision.position.x *= -1
	elif direction == Directions.RIGHT:
		sprite.flip_h = false
		if collision.position.x > 0:
			collision.position.x *= -1
