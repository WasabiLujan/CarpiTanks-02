extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _on_BotonVolver_pressed():
	get_tree().change_scene("res://Escenas/menu.tscn")





# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Volver_a_Menu_pressed():
	get_tree().change_scene("res://Escenas/Menu.tscn")

