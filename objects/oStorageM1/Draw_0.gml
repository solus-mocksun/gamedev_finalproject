/// @description Insert description here
// You can write your code in this editor

draw_self();
if (position_meeting(mouse_x, mouse_y, id)){
	draw_set_font(fScore);
	draw_set_color(c_gray);
	draw_text(x+120,y+140,"HP: "+string(hp0)+"\nATTACK: "+string(attack0)+"\nUPGRADE: "+string(upgrade0));
	
}


