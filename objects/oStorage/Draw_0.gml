/// @description Insert description here
// You can write your code in this editor
if (room==rStart){
	draw_set_font(fScore);
	draw_set_color(c_gray);
	draw_set_halign(fa_center);
	draw_text(x,y-70,"PICK YOUR MONSTER");
}
if (image_index>=2)image_index=0;

if (room==rEnd){
	draw_set_font(fScore);
	draw_sprite(playerM,image_index,x,y);
	if (win){
		draw_text(x,y-100,"you won");
	}
	else{
		draw_text(x,y-100,"booo you lost");
	}
	draw_text(x,y+100,"[space] to restart");
	if (keyboard_check(vk_space)){
		game_restart();
	}
}


