extends CanvasLayer
	

#Si presiona btn nuevo juego recarga la pantalla de la escena del juego
func _on_nuevo_juego_pressed():
	get_tree().reload_current_scene()
	visible = false

#Si presiona btn salir redirige al menu principal del juego
func _on_salir_pressed():
	get_tree().change_scene("res://escenas/menu/menu.tscn")
	visible = false

