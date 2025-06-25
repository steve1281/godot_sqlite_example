Integrating SQlite into Godot 4.2

https://www.youtube.com/watch?v=j-BRiTrw_F0 by FinePointCGI

( as always, please see the original work.  I am not associated with the author in anyway)

Useful code snippit: Create DB

```
var database : SQLite

func _ready() -> void:
	database = SQLite.new()
	database.path= "res://data.db"
	database.open_db()

Opened database successfully (C:/Users/steve/godot_projects/sqlite_tutorial/data.db)

```
Useful code snippit: Create Table

```
	var table = {
		"id": {"data_type": "int", "primary_key": true, "not_null":true, "auto_increment": true },
		"name": {"data_type": "text"},
		"score": {"data_type": "int"}
	}
	database.create_table("players", table)
	
```
Useful code snippit: Insert Data

```
	var data = {
		"name" : xname.text,
		"score": int(score.text)
	}
	database.insert_row(player_table, data)
```
Useful code snippet: Select Data

```
	var data = database.select_rows(player_table, "score > 10",["id", "name", "score"])
	output_text_edit.text = ""
	for x in data:
		output_text_edit.text += "ID: "+ str(x.id) + " Name: " + x.name + " Score:" + str(x.score) + "\n"
```


Notes:
	
	- need to install the plugin godot-sqlite by 2shady4u (I got the 4.5 version.)
	- remember to enable the plugin in the Projects-Settings-Plugins
	- video talks about a "missing plugin.cfg and gdsqlite.gdextension file".  This now appears to be fixed. (so I will NOT being his work around for now)
	- I deviate from the original code; this is typical of me, sorry.
	- he also uses DB Browser for SQlite; its a good tool to have for SQlite installations.
	- he misspells auto in auto_increment.  Easy to fix in db browser.  (I didn't)
