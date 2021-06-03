extends Actor

var poss=Vector2(16,280)
var musicpos=0;

func _ready():
	$AnimationPlayer.play("PlayerFall")

func _physics_process(_delta: float) -> void:
	var direction: = get_direction()
	
	velocity = calculate_velocity(velocity,direction,speed)
	velocity = move_and_slide(velocity,FLOOR_NORMAL)
	
	if Input.is_action_just_pressed("jump"):
		$AnimationPlayer.play("PlayerRise")
	elif Input.is_action_just_released("jump"):
		$AnimationPlayer.play("PlayerFall")
		
	if $CollisionX.is_colliding() or $CollisionY.is_colliding() or $CollisionZ.is_colliding():
		restartt()
		
func get_direction() -> Vector2:
	return Vector2(1.0,
	-1.0 if Input.is_action_pressed("jump")else 1.0
	)

func calculate_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2
	) -> Vector2:
	
	var new_velocity = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity*get_physics_process_delta_time()
	
	if direction.y ==-1.0:
		new_velocity.y = speed.y * direction.y
	
	return new_velocity

func restartt():
	if get_tree().get_current_scene().get_name() == "Main":
		var player=get_parent().get_node("Player");
		$AirplaneAudio.stop();
		$AirplaneAudio.play();
		airplaneToBall(player.pos,player.musicpos);
	
	elif get_tree().get_current_scene().get_name() == "Level2":
		get_parent().get_node("Darken/ColorRect").set_visible(0);
		get_parent().get_node("ParallaxBackground/Foreground/Sprite").set_visible(0);
		$AirplaneAudio.stop();
		$AirplaneAudio.play();
		$".".speed = Vector2(300,300)
	
	else:
		$AirplaneAudio.stop();
		$AirplaneAudio.play();
	position=poss

func _on_Default_body_entered(body):
	airplaneToBall($".".position,$AirplaneAudio.get_playback_position());


func _on_Fallzone_body_entered(body):
	restartt();
	
func airplaneToBall(posParam:Vector2,music:float):
	var char_tex = load("res://Background/level11.jpg") 
	$".".set_physics_process(false);
	$".".set_visible(0);
	$AirplaneAudio.stop();
	
	get_parent().get_node("Background/ParallaxLayer/Sprite").texture=char_tex
	get_parent().get_node("Player").position=posParam;
	get_parent().get_node("Player").set_physics_process(true);
	get_parent().get_node("Player").get_node("BallCamera").make_current();
	get_parent().get_node("Player").get_node("BallAudio").play(music);
	get_parent().get_node("Player").set_visible(1);


func _on_Portal_body_entered(body):
	$".".position=Vector2(24,-266.454);


func _on_Portal2_body_entered(body):
	$".".position=Vector2(6901,328);
	get_parent().get_node("Darken/ColorRect").set_visible(1);
	get_parent().get_node("ParallaxBackground/Foreground/Sprite").set_visible(1);
	$".".speed = Vector2(150,150)


func _on_Portal3_body_entered(body):
	$".".position=Vector2(4961,-316);
	get_parent().get_node("Darken/ColorRect").set_visible(0);
	get_parent().get_node("ParallaxBackground/Foreground/Sprite").set_visible(0);
	$".".speed = Vector2(300,300)
