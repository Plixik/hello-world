/// @desc Save game

//Create a root list
var rootList = ds_list_create();

//Save player
var playerMap = ds_map_create();
ds_list_add(rootList, playerMap);
ds_list_mark_as_map(rootList, ds_list_size(rootList)-1);
var player = object_get_name(obj_player.object_index);
var currentRoom = room;
ds_map_add(playerMap, "player", player); 
ds_map_add(playerMap, "room", currentRoom); //Current Room
ds_map_add(playerMap, "x", obj_player.x); //x coordinate
ds_map_add(playerMap, "y", obj_player.y);  //y coordinate

#region Coin save
var coinList = ds_list_create(); //Make a list for all the coin maps
ds_list_add(rootList, coinList); //Add the list to the root list
ds_list_mark_as_list(rootList, ds_list_size(rootList)-1); //Mark the last created list as a list
with (par_coin) { //Do this with each coin instance
	var coinMap = ds_map_create(); //Create coin map for a coin
	ds_list_add(coinList, coinMap); //Add that map to the coin list
	ds_list_mark_as_map(coinList, ds_list_size(coinList)-1); //Mark the last added map as a map
	var currentRoom = room; //Store current room id
	//show_message(string(room));
	
	var obj = object_get_name(object_index); //Store a string of the object name
	ds_map_add(coinMap, "coin", obj); //Save that string as a value with a key in the coin map
	ds_map_add(coinMap, "room", currentRoom); //Save the room id in the coin map as a value with a key
	ds_map_add(coinMap, "x", x); //Save x loc
	ds_map_add(coinMap, "y", y); //Save y loc
	ds_map_add(coinMap, "color", randColor); //Save it's color value
	//Save the player's coin queue
}
#endregion

//Wrap the root list in a map
var wrapper = ds_map_create();
ds_map_add_list(wrapper, "Root", rootList);

//Save all of this to a string
var jsonString = json_encode(wrapper);
var file = file_text_open_write(working_directory + "\save.dat");
file_text_write_string(file, jsonString);
file_text_close(file);

//Nuke the data
ds_map_destroy(wrapper);

show_debug_message("Game saved!");