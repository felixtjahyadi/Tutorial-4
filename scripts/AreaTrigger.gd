extends Area2D

export var sceneName: String = "Level 1"

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		get_tree().change_scene(str("res://scenes/" + sceneName + ".tscn"))
