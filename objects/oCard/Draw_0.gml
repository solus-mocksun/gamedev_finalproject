
//if the card is farther than 1 from its target
if(abs(x - target_x) > 1) {
	depth = -200;
	x = lerp(x, target_x, moveSpeed);
} else {
	//set its x to the target as well as the depth
	x = target_x;
	depth = target_depth;
}

//if the card is farther than 1 from its target
if(abs(y - target_y) > 1) {
	depth = -200;
	y = lerp(y, target_y, moveSpeed);
	if (moveSound and !hover){
		audio_play_sound(sCard,10,false); 
		moveSound = false;
	}
} else {
	//set the y to the target as well as the depth
	y = target_y;
	depth = target_depth;
	moveSound=true;
}

//draw the card to the target depth (this is for staggered effects)
//depth = target_depth;
draw_set_alpha(1);
//show the card's face based on its index
if(face_index == 0){
	sprite_index=sAttack;
	//draw_sprite_ext(sAttack,image_index, x, y,1,1,image_angle, image_blend, 1);
}if(face_index == 1){
	sprite_index=sDefend;
	//draw_sprite_ext(sDefend,image_index, x, y,1,1,image_angle, image_blend, 1);
}if(face_index == 2){
	sprite_index=sUpgrade;
	//draw_sprite_ext(sUpgrade,image_index, x, y,1,1,image_angle, image_blend, 1);
}

//BUT if the card is face up, just show the card back
if(!face_up){
	sprite_index=sCardBack;
	//draw_sprite_ext(sCardBack,image_index, x, y,1,1,image_angle, image_blend, 1);
	}
	//draw the card

	draw_sprite_ext(sprite_index, image_index, x, y,image_xscale,image_yscale,image_angle, image_blend, dotrickincomparealpha);


if (hover_counter >40) {
	draw_set_font(Font1);
	draw_set_alpha(hover_fade_alpha);
	if (start_fade){
		hover_fade_alpha-=0.1;
		if (hover_fade_alpha<=0){
			hover_counter=0;
			start_fade = false;
		}
	}
	depth=-200;
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_sprite_ext(sDesc,image_index,x-40,y-130,1,1,image_angle, image_blend, hover_fade_alpha);
	if(face_index == 0) {
		draw_set_color(make_color_rgb(147, 53, 62));
		draw_text(x+40,y-90,"deal " + string(oMPlayer.attack_score) + " dmg");
	}
	if(face_index == 1) {
		draw_set_color(make_color_rgb(58, 93, 145));
		draw_text(x+35,y-100,"deflect 50% of\nenemy attack");
	}
	if(face_index == 2) {
		draw_set_color(make_color_rgb(206, 184, 130));
		draw_text_ext(x+40,y-110,"upgrade attack\n"+ 
				string(oMPlayer.attack_score)+" -> "+
				string(oMPlayer.attack_score+oMPlayer.upgrade_score)+
				"\nheal: "+string(int64(oMPlayer.upgrade_score/2)),23,200);
	}
	
}
