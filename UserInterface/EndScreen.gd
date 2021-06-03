extends Control

var Level1 = load("res://Level1.tscn");
var Level2 = load("res://Level2.tscn");
var Level3 = load("res://Main.tscn");

func _ready():
	var Levell1= Level1.instance()
	var Levell2= Level2.instance()
	var Levell3= Level3.instance()
	$Score.text = "Level 1: "+str(Levell1.attempts)+" Attempts Level 2: "+str(Levell2.attempts)+" Attempts Level 3: "+str(Levell3.attempts)+" Attempts"
