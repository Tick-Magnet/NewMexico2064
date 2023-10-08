/// @description Insert description here
// You can write your code in this editor

if (room != rm_title) {

display_set_gui_size(272, 176);

//Dead Hearts
for (i = 0; i < obj_player.max_hp; i++) {
	
	draw_sprite(spr_heart_hud,1,(28 + (i * 9) - 1),3);
	
}

for (i = 0; i < obj_player.hp; i++) {
	
	draw_sprite(spr_heart_hud,0,(28 + (i * 9) - 1),3);
	
}

draw_sprite(spr_cash_hud,obj_player.cash,170, 4);
draw_sprite(spr_bomb_hud,obj_player.bombs,206, 3);
draw_sprite(spr_key_hud,obj_player.keys,229,3);
draw_sprite(spr_lives,obj_player.life,3,3);

}