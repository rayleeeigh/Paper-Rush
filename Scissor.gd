extends KinematicBody2D

var is_moving_up = true

var gravity = 10;
var velocity = Vector2(0,0)
var speed = 300

func _ready():
	$AnimationPlayer.play("BatIdle");

func _process(_delta):
	move_bat()
	change_direction()

func move_bat():
	velocity.y = -speed if is_moving_up else speed
	velocity = move_and_slide(velocity,Vector2.UP)

func change_direction():
	if $CollisionZ.is_colliding():
		is_moving_up = !is_moving_up
		scale.y = -scale.y 
