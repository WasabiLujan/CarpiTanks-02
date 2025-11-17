extends StaticBody2D

var jugador = null

func _on_Area_de_impacto_body_entered(body):
	if body.is_in_group("Jugador"):
		jugador = body
		print("aya")
		self.queue_free()
