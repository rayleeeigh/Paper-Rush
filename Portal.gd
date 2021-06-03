extends Area2D

onready var anim_player: AnimationPlayer = $TransitionAnimation
export var next_scene: PackedScene

func _ready():
	$PortalAnimation.play("Portal");

func teleport():
	anim_player.play("Fade_In");
	yield(anim_player,"animation_finished");
	get_tree().change_scene_to(next_scene);

func _on_Portal_body_entered(body):
	teleport()
	body.set_visible(0);
	body.set_physics_process(false)
