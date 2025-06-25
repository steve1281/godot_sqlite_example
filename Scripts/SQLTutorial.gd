extends Control

var database : SQLite

@onready var xname: TextEdit = %Name
@onready var score: TextEdit = %Score
@onready var output_text_edit: TextEdit = %OutputTextEdit

var player_table : String = "players"

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
	database.create_table(player_table, table)


func _on_insert_data_pressed() -> void:
	var data = {
		"name" : xname.text,
		"score": int(score.text)
	}
	database.insert_row(player_table, data)
	


func _on_select_data_pressed() -> void:
	var data = database.select_rows(player_table, "score > 10",["id", "name", "score"])
	output_text_edit.text = ""
	for x in data:
		output_text_edit.text += "ID: "+ str(x.id) + " Name: " + x.name + " Score:" + str(x.score) + "\n"


func _on_update_data_pressed() -> void:
	pass # Replace with function body.


func _on_delete_data_pressed() -> void:
	pass # Replace with function body.


func _on_custom_select_pressed() -> void:
	pass # Replace with function body.
