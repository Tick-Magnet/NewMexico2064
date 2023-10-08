/// @description Insert description here
// You can write your code in this editor
switch (image_index) {

	//North
	case 0: {
		
		if (y != obj_player.y - 16) and (x != obj_player.x) {
			y = obj_player.y - 16;
			x = obj_player.x;
		}
		break;	
	}
	
	
	//South
	case 1: {
		
		if (y != obj_player.y + 16) and (x != obj_player.x) {
			y = obj_player.y + 16;
			x = obj_player.x;
		}
		break;	
	}
	
	
	//East
	case 2: {
		
		if (x != obj_player.x + 16) and (y != obj_player.y)  {
			y = obj_player.y;
			x = obj_player.x + 16;
			}
		break;	
	}
	
	//West
	case 3: {
		
		if (x != obj_player.x - 16) and (y != obj_player.y) {
			y = obj_player.y;
			x = obj_player.x - 16;
		}
		break;	
	}


	
}


