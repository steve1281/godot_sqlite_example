Integrating SQlite into Godot 4.2

https://www.youtube.com/watch?v=j-BRiTrw_F0 by FinePointCGI

( as always, please see the original work.  I am not associated with the author in anyway)

Useful code snippit

```
var database : SQLite

func _ready() -> void:
	database = SQLite.new()
	database.path= "res://data.db"
	database.open_db()

Opened database successfully (C:/Users/steve/godot_projects/sqlite_tutorial/data.db)

```

Notes:
	
	- need to install the plugin godot-sqlite by 2shady4u (I got the 4.5 version.)
	- remember to enable the plugin in the Projects-Settings-Plugins
	- video talks about a "missing plugin.cfg and gdsqlite.gdextension file".  This now appears to be fixed. (so I will NOT being his work around for now)
	- I deviate from the original code; this is typical of me, sorry.
