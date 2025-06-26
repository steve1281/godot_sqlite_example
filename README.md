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
Useful code snippet: Update Data

```
	database.update_rows(player_table, 
						"name = '" + xname.text + "'" , 
						{ "score": int(score.text) })
```

Useful code snippit: Delete Data

```
database.delete_rows(player_table, "name = '" + xname.text + "'")
```

Usefull code snippit: Custom query

```
	var data = database.query("
		select * from 
		players a
		join playerInfo b
		on a.playerinfoid = b.id
		where a.score > " + str(score.text))

	output_text_edit.text = ""
	for x in database.query_result:
		output_text_edit.text += "ID: "+ str(x.id) + " Name: " + x.name + " Score:" + str(x.score) + "\n"
```
Useful code snippits: update image to blob, and select blob to image:

```

	var image := preload("res://Images/Zariel_Descent.jpg")
	var pba:PackedByteArray = image.get_image().save_jpg_to_buffer()
	database.update_rows(player_table, 
						"name = '" + xname.text + "'" , 
						{ "picture": pba })
	
...

	database.select_rows(player_table, "name = '"+xname.text+"'", ["picture"])
	for i in database.query_result:
		var image = Image.new()
		image.load_jpg_from_buffer(i.picture)
		var texture = ImageTexture.create_from_image(image)
		player_picture.texture = texture
		
```


Notes:
	
	- need to install the plugin godot-sqlite by 2shady4u (I got the 4.5 version.)
	- remember to enable the plugin in the Projects-Settings-Plugins
	- video talks about a "missing plugin.cfg and gdsqlite.gdextension file".  This now appears to be fixed. (so I will NOT being his work around for now)
	- I deviate from the original code; this is typical of me, sorry.
	- he also uses DB Browser for SQlite; its a good tool to have for SQlite installations.
	- he misspells auto in auto_increment.  Easy to fix in db browser.  (I didn't)

He creates a table is DB Browser.  The code is:

```
	CREATE TABLE "playerInfo" (
		"id"	INTEGER NOT NULL,
		"address"	TEXT,
		PRIMARY KEY("id" AUTOINCREMENT)
	);
```

	- so an id and a single text field for storing address data, np :)
	- adds a playerinfoid to players
	- manually assigns a player record so its id points to a playerinfo
	- repeat for other players (so every player points to a playerinfo)
	- comment: a better example would to have two players sharing an address. I digress though.
	
So you could do a select with:
	
```
	select * from 
		players a, 
		playerInfo b 
		where a.playerinfoid = b.id;
```

Or, using what video does:

```
	select * from 
		players a
		join playerInfo b
		on a.playerinfoid = b.id;
```

- also note you need to use write changes with db browser (like a commit)

Next, working with image (using BLOB as your data type)

- in db browser, modify players table, add row called picture with datatype of BLOB
