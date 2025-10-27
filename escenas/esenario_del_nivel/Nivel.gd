extends Node2D

var pausa_ui = preload("res://escenas/UI/Pausa UI.tscn")
var pausa = null

func _ready():
	set_pause_mode(Node.PAUSE_MODE_PROCESS)
	pass

#Función para pausr el juego
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		
		if get_tree().paused:
			pausa = pausa_ui.instance()
			add_child(pausa)
		else:
			pausa.queue_free()

