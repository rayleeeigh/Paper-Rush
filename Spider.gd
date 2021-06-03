extends KinematicBody2D

var is_moving_left = true

var gravity = 10;
var velocity = Vector2(0,0)
export var speed: = 300

func _ready():
	$AnimationPlayer.play("Spider");

func _process(_delta):
	move_spider()
	change_direction()

func move_spider():
	velocity.x = -speed if is_moving_left else speed
	velocity = move_and_slide(velocity,Vector2.UP)

func change_direction():
	if $CollisionX.is_colliding():
		is_moving_left = !is_moving_left
		scale.x = -scale.x 
