extends KinematicBody2D

export var SPEED: =420
export var JUMP = 890
export var GRAVITY: = 3500
var direction = 1
var velocity = Vector2()
var FLOOR = Vector2(0 , -1)
var pos=Vector2(16,560)
var musicpos=0;

func _ready():
	$AnimationPlayer.play("PlayerMove")

func _physics_process(delta):
	velocity.x = SPEED * direction
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -JUMP
		$AnimationPlayer.play("PlayerJump")
	elif is_on_floor():
		$AnimationPlayer.play("PlayerMove")
		
	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity , FLOOR)
	
	if $CollisionX.is_colliding() or $CollisionY.is_colliding() or $CollisionZ.is_colliding() or $CollisionBack.is_colliding():
		restartt(pos)
	if $CollisionBoost.is_colliding():
		velocity.y = -(JUMP*2)
	if $CollisionBoostBack.is_colliding() or $CollisionBoostX.is_colliding():
		velocity.x = +(SPEED*7 * direction)
		velocity = move_and_slide(velocity , FLOOR)
	if $CollisionDirectionX.is_colliding() or $CollisionDirectionY.is_colliding():
		direction=-1
	if $RevertDirectionY.is_colliding() or $RevertDirectionBack.is_colliding():
		direction=1
		$BallCamera.offset_h=0
	if $CollisionBoostDown.is_colliding():
		velocity.y = +(JUMP*2)
	
func restartt(poss:Vector2):
	if ($BallCamera.offset_h==-6):
		$BallCamera.offset_h=0
	position=poss;
	$BallAudio.stop();
	$BallAudio.play(musicpos);
	direction=1

func _on_Obstacles_tree_entered():
	restartt(pos)
	
func _on_Change_body_entered(body):
	ballToAirplane($".".position)
	
func _on_Savepoint1_body_entered(body):
	pos=get_parent().get_node("Savepoint1").position;
	pos.x=pos.x+50;
	musicpos=$BallAudio.get_playback_position();


func _on_Savepoint2_body_entered(body):
	pos=get_parent().get_node("Savepoint2").position;
	pos.x=pos.x+50;
	musicpos=$BallAudio.get_playback_position();


func _on_Fallzone_body_entered(body):
	restartt(pos)
	
func _on_Area2D_body_entered(body):
	$BallCamera.offset_h=-6


func ballToAirplane(positionAirplane:Vector2):
	var char_tex = load("res://Background/level12.jpg") 
	$".".set_visible(0);
	$".".set_physics_process(false);
	$".".get_node("BallAudio").stop();
	
	get_parent().get_node("Airplane").set_physics_process(true);
	get_parent().get_node("Airplane").set_visible(1);
	get_parent().get_node("Airplane").position=positionAirplane;
	get_parent().get_node("Airplane").get_node("AirplaneCamera").make_current();
	get_parent().get_node("Airplane").get_node("AirplaneAudio").play($BallAudio.get_playback_position());
	get_parent().get_node("Background/ParallaxLayer/Sprite").texture=char_tex
