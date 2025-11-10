extends KinematicBody2D


var motion = Vector2.ZERO

var velocity = 700

func _ready():
	motion = Vector2(0,-1).rotated(rotation)

func _physics_process(delta):
	var velocity_vector = motion * velocity
	move_and_slide(velocity_vector)

func _on_Area2D_body_entered(body):
	self.queue_free()




