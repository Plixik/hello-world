/// @desc Load game

if (file_exists("save.dat")) {
	instance_destroy(obj_player);
	var fileId = file_text_open_read(working_directory + "\save.dat")
	var saveFileString = file_text_read_string(fileId);
	
	//Decode JSON
	var wrapper = json_decode(saveFileString);
	
	//Declare wrapper pointer
	var rootList = wrapper[? "Root"];
	
	//Declare player map pointer
	var playerMap = rootList[| 0];
	var player = playerMap[? "player"];
	//Load room
	var loadRoom = playerMap[? "room"];
	room_goto(loadRoom);
	
	//Load player
	with (instance_create_layer(0, 0, "Instances_1", asset_get_index(player))) {
		x = playerMap[? "x"];
		y = playerMap[? "y"];
	}
	
	#region Coin load
	//Destroy existing coins
	with (par_coin) instance_destroy();
	
	//Load coins
	//show_message(string(ds_list_size(rootList)));
	var coinList = rootList[| 1];
	//show_message(string(ds_list_size(coinList)));
	for (var i = 0; i < ds_list_size(coinList); i++) {
		var coinMap = coinList[| i];
		var coin = coinMap[? "coin"];
		with (instance_create_layer(0, 0, "Instances_1", asset_get_index(coin))) {
			//room_instance_add(coinMap[? "room"], x, y, self);
			x = coinMap[? "x"];
			y = coinMap[? "y"];
			image_blend = coinMap[? "color"];
			//Place coin into player's coin queue spot from which it was saved
		}
	}
	#endregion
	
	//Nuke the data
	ds_map_destroy(wrapper);
	show_debug_message("Game loaded!");
}