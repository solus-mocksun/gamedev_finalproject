/// @description Insert description here
// You can write your code in this editor

//IMAGE_INDEX SETTING
//idle loop
if (image_index>=first_attack_frame 
		and image_index<first_attack_frame+1){
	image_index=0;
}
//dogde loop
if (image_index>=first_dogde_frame 
		and image_index<first_dogde_frame+1){
	show_debug_message("dogde");
	image_index=0;
}
//upgrade loop
//if (image_index>=first_upgrade_frame 
		//and image_index<first_upgrade_frame+1){
	if (image_index>=first_upgrade_frame ){
	show_debug_message("upgrade");
	image_index=0;
}
//last loop
if (image_index>=25){
	image_index=0;
}

//set audio:

//------ set aud finished


if (taking_dmg){
	if (oOpp.image_index> oOpp.first_attack_frame+1 and oOpp.image_index< oOpp.first_dogde_frame){
		hp_score-=taking_dmg_score;
		if (oOpp == oMComputer){
			oScore.dmg_take_start(taking_dmg_score,0);
		}if (oOpp == oMPlayer){
			oScore.dmg_take_start(0,taking_dmg_score);
		}
		taking_dmg=false;
	}
}

if (hp_score<=0){
	show_debug_message("hp no more");
	hp_score=0;
	counter_toend++;
}

if (counter_toend>20){
	show_debug_message("DIE!");
	if (sMonster!=oMPlayer.sMonster){
		show_debug_message("playerwon!");
		oStorage.sWinner = oMPlayer.sMonster;
		oStorage.win = true;
	}else{
		show_debug_message("playernot win!");
		oStorage.sWinner = oMComputer.sMonster;
		oStorage.win = false;
	}
	room_goto_next();
	
}
if (hp_score>hp_max)hp_score=hp_max;