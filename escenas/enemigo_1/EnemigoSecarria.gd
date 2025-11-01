extends KinematicBody2D

var movimiento = Vector2.ZERO
var velocidad = 100

var jugador = null #para detectar al jugador y dispararle 

var obstaculo = null #para esquivar objetos

func _physics_process(delta):
	pass


func _on_Detectar_entorno_body_entered(body):
	pass # Replace with function body.


func _on_Timer_timeout():
	pass # Replace with function body.
