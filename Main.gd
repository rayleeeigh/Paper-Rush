extends Node2D
class_name Main

var attempts = 0;

func _ready():
	$Player/BallAudio.play();
	$Player/BallCamera.make_current();
	$Airplane.set_physics_process(false);
	$Airplane.set_visible(0);
	
func _physics_process(delta):
	if ($Player.position == $Player.pos):
		attempts+=1
		$UserInterface/Attempts.text = "ATTEMPTS: %s" % attempts
