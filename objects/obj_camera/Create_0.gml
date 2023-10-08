//window_set_fullscreen(true);

view_enabled = true;
view_visible[0] = true;
view_hport[0] = 176;
view_wport[0] = 272;

switch (room) {
	
	case rm_New_Mexico:
		view_camera[0] = camera_create_view (0,704,272,176);
		break;
		
	case rm_A5_Cave:
		view_camera[0] = camera_create_view (0,0,272,176);
		break;
	
	
}

global.active_room = -1; 

