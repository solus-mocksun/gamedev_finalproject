

// draw sprite
if (image_index>first_attack_frame and image_index <first_dogde_frame){
	depth-=1;
}else{
	depth=0;
}
draw_sprite_ext(sMonster, image_index, x, y,set_image_xscale,image_yscale, image_angle, image_blend, image_alpha);



