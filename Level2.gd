extends Node2D

var attempts = 0;

func _ready():
	$Portal/AnimationPlayer.play("Portal");
	$PaperAirplane/AirplaneAudio.play(0);

func _physics_process(delta):
	if ($PaperAirplane.position == $PaperAirplane.poss):
		attempts+=1
		$UserInterface/Attempts.text = "ATTEMPTS: %s" % attempts
