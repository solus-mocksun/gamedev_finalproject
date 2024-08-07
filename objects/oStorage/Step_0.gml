/// @description Insert description here
// You can write your code in this editor

if (room == rGame and !setupM){
	oMComputer.sMonster = computerM;
	oMPlayer.sMonster = playerM;
	if (computerM == sM1){
	oMComputer.hp_score = M1STATS.hp_;
	oMComputer.hp_max = M1STATS.hp_;
	oMComputer.attack_score = M1STATS.attack_;
	oMComputer.upgrade_score = M1STATS.upgrade_;
	oMComputer.first_attack_frame=M1STATS.fAttackFrame;
	oMComputer.first_dogde_frame=M1STATS.fDefendFrame;
	oMComputer.first_upgrade_frame=M1STATS.fUpgradeFrame;
	
	oMPlayer.hp_score = M2STATS.hp_;
	oMPlayer.hp_max = M2STATS.hp_;
	oMPlayer.attack_score = M2STATS.attack_;
	oMPlayer.upgrade_score = M2STATS.upgrade_;
	oMPlayer.first_attack_frame=M2STATS.fAttackFrame;
	oMPlayer.first_dogde_frame=M2STATS.fDefendFrame;
	oMPlayer.first_upgrade_frame=M2STATS.fUpgradeFrame;
	}else{
	oMComputer.hp_score = M2STATS.hp_;
	oMComputer.hp_max = M2STATS.hp_;
	oMComputer.attack_score = M2STATS.attack_;
	oMComputer.upgrade_score = M2STATS.upgrade_;
	oMComputer.first_attack_frame=M2STATS.fAttackFrame;
	oMComputer.first_dogde_frame=M2STATS.fDefendFrame;
	oMComputer.first_upgrade_frame=M2STATS.fUpgradeFrame;
	
	oMPlayer.hp_score = M1STATS.hp_;
	oMPlayer.hp_max = M1STATS.hp_;
	oMPlayer.attack_score = M1STATS.attack_;
	oMPlayer.upgrade_score = M1STATS.upgrade_;
	oMPlayer.first_attack_frame=M1STATS.fAttackFrame;
	oMPlayer.first_dogde_frame=M1STATS.fDefendFrame;
	oMPlayer.first_upgrade_frame=M1STATS.fUpgradeFrame;
	}
	setupM=true;
}



