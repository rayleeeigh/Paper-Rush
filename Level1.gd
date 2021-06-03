extends Node2D

var attempts = 0;

func _ready():
	$Player/BallAudio.play();
	$Player/BallCamera.make_current();
	$Portal/PortalAnimation.play("Portal");

func _physics_process(delta):
	if ($Player.position == $Player.pos):
		attempts+=1
		$UserInterface/Attempts.text = "ATTEMPTS: %s" % attempts
