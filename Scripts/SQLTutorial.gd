extends Control

var database : SQLite

@onready var xname: TextEdit = %Name
@onready var score: TextEdit = %Score
@onready var output_text_edit: TextEdit = %OutputTextEdit
@onready var player_picture: TextureRect = $PlayerPicture

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
	database.update_rows(player_table, 
						"name = '" + xname.text + "'" , 
						{ "score": int(score.text) })


func _on_delete_data_pressed() -> void:
	database.delete_rows(player_table, "name = '" + xname.text + "'")
	


func _on_custom_select_pressed() -> void:
	
	if score.text == "": return  
	
	var flag : bool = database.query("
		select * from 
		players a
		join playerInfo b
		on a.playerinfoid = b.id
		where a.score > " + str(score.text))

	
	if !flag: return
	
	output_text_edit.text = ""
	for x in database.query_result:
		output_text_edit.text += "ID: "+ str(x.id) + " Name: " + x.name + " Score:" + str(x.score) + " Address: " + x.address + "\n"


func _on_store_image_pressed() -> void:
	var image := preload("res://Images/Zariel_Descent.jpg")
	var pba:PackedByteArray = image.get_image().save_jpg_to_buffer()

	if xname.text == "" : return
	
	database.update_rows(player_table, 
						"name = '" + xname.text + "'" , 
						{ "picture": pba })
	


func _on_load_image_pressed() -> void:
	if xname.text == "": return
	database.select_rows(player_table, "name = '"+xname.text+"'", ["picture"])
	for i in database.query_result:
		if i.picture == null: continue
		var image = Image.new()
		image.load_jpg_from_buffer(i.picture)
		var texture = ImageTexture.create_from_image(image)
		player_picture.texture = texture
		


func _on_exit_pressed() -> void:
	get_tree().quit()
	
