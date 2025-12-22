extends Area2D

#var hud = get_tree().get_root().find_node("HUD") #Para actualizar en el HUD "actualizar_vistas_de_vidas" += 1
#var jugador = get_tree().get_root().find_node("Juagador")


func _on_VidaPower_body_entered(body):
	if body.is_in_group("Jugador"):
		body.sumar_vida(1)
		print("Hola Ando!")
		queue_free()
