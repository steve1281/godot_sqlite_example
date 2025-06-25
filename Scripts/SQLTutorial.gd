extends Control

var database : SQLite

func _ready() -> void:
	database = SQLite.new()
	database.path= "res://data.db"
	database.open_db()

func _on_create_table_pressed() -> void:
	var table = {
		"id": {"data_type": "int", "primary_key": true, "not_null":true, "auto_increment": true },
		"name": {"data_type": "text"},
		"score": {"data_type": "int"}
	}
	database.create_table("players", table)


func _on_insert_data_pressed() -> void:
	pass # Replace with function body.


func _on_select_data_pressed() -> void:
	pass # Replace with function body.


func _on_update_data_pressed() -> void:
	pass # Replace with function body.


func _on_delete_data_pressed() -> void:
	pass # Replace with function body.


func _on_custom_select_pressed() -> void:
	pass # Replace with function body.
