extends RigidBody2D

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		get_tree().change_scene("res://scenes/Level2.tscn")
