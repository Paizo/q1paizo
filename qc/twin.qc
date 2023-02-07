/*  Copyright (C) 1996-1997  Id Software, Inc.

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

    See file, 'COPYING', for details.
*/
/*
==============================================================================

KNIGHT

==============================================================================
*/

$cd id1/models/knight
$origin 0 0 24
$base base
$skin badass3

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8 stand9

$frame runb1 runb2 runb3 runb4 runb5 runb6 runb7 runb8

$frame runattack1 runattack2 runattack3 runattack4 runattack5
$frame runattack6 runattack7 runattack8 runattack9 runattack10
$frame runattack11

$frame pain1 pain2 pain3

$frame painb1 painb2 painb3 painb4 painb5 painb6 painb7 painb8 painb9
$frame painb10 painb11

$frame attackb1 attackb2 attackb3 attackb4 attackb5 attackb6
$frame attackb7 attackb8 attackb9 attackb10 attackb11

$frame walk1 walk2 walk3 walk4 walk5 walk6 walk7 walk8 walk9
$frame walk10 walk11 walk12 walk13 walk14

$frame kneel1 kneel2 kneel3 kneel4 kneel5

$frame standing2 standing3 standing4 standing5

$frame death1 death2 death3 death4 death5 death6 death7 death8
$frame death9 death10

$frame deathb1 deathb2 deathb3 deathb4 deathb5 deathb6 deathb7 deathb8
$frame deathb9 deathb10 deathb11

void() ai_run_closer;

void()	twin_stand1	=[	$stand1,	twin_stand2	] {ai_stand();};
void()	twin_stand2	=[	$stand2,	twin_stand3	] {ai_stand();};
void()	twin_stand3	=[	$stand3,	twin_stand4	] {ai_stand();};
void()	twin_stand4	=[	$stand4,	twin_stand5	] {ai_stand();};
void()	twin_stand5	=[	$stand5,	twin_stand6	] {ai_stand();};
void()	twin_stand6	=[	$stand6,	twin_stand7	] {ai_stand();};
void()	twin_stand7	=[	$stand7,	twin_stand8	] {ai_stand();};
void()	twin_stand8	=[	$stand8,	twin_stand9	] {ai_stand();};
void()	twin_stand9	=[	$stand9,	twin_stand1	] {ai_stand();};

void()	twin_walk1	=[	$walk1,		twin_walk2	]
{
	if (random() < 0.2)
		sound (self, CHAN_VOICE, "knight/idle.wav", 1,  ATTN_IDLE);
	ai_walk(3);
};
void()	twin_walk2	=[	$walk2,		twin_walk3	] {ai_walk(2);};
void()	twin_walk3	=[	$walk3,		twin_walk4	] {ai_walk(3);};
void()	twin_walk4	=[	$walk4,		twin_walk5	] {ai_walk(4);};
void()	twin_walk5	=[	$walk5,		twin_walk6	] {ai_walk(3);};
void()	twin_walk6	=[	$walk6,		twin_walk7	] {ai_walk(3);};
void()	twin_walk7	=[	$walk7,		twin_walk8	] {ai_walk(3);};
void()	twin_walk8	=[	$walk8,		twin_walk9	] {ai_walk(4);};
void()	twin_walk9	=[	$walk9,		twin_walk10	] {ai_walk(3);};
void()	twin_walk10	=[	$walk10,	twin_walk11	] {ai_walk(3);};
void()	twin_walk11	=[	$walk11,	twin_walk12	] {ai_walk(2);};
void()	twin_walk12	=[	$walk12,	twin_walk13	] {ai_walk(3);};
void()	twin_walk13	=[	$walk13,	twin_walk14	] {ai_walk(4);};
void()	twin_walk14	=[	$walk14,	twin_walk1	] {ai_walk(3);};


void()	twin_run1	=[	$runb1,		twin_run2	]
{
	if (random() < 0.2)
		sound (self, CHAN_VOICE, "knight/idle.wav", 1,  ATTN_IDLE);
	ai_run(16);
};
void()	twin_run2	=[	$runb2,		twin_run3	] {ai_run(20);};
void()	twin_run3	=[	$runb3,		twin_run4	] {ai_run(13);};
void()	twin_run4	=[	$runb4,		twin_run5	] {ai_run(7);};
void()	twin_run5	=[	$runb5,		twin_run6	] {ai_run(16);};
void()	twin_run6	=[	$runb6,		twin_run7	] {ai_run(20);};
void()	twin_run7	=[	$runb7,		twin_run8	] {ai_run(14);};
void()	twin_run8	=[	$runb8,		twin_run1	] {ai_run(6);};


void()	twin_runatk1	=[	$runattack1,		twin_runatk2	]
{
	if (random() > 0.5)
		sound (self, CHAN_WEAPON, "knight/sword2.wav", 1, ATTN_NORM);
	else
		sound (self, CHAN_WEAPON, "knight/sword1.wav", 1, ATTN_NORM);
	ai_charge(20);
};
void()	twin_runatk2	=[	$runattack2,	twin_runatk3	] {ai_charge_side();};
void()	twin_runatk3	=[	$runattack3,	twin_runatk4	] {ai_charge_side();};
void()	twin_runatk4	=[	$runattack4,	twin_runatk5	] {ai_charge_side();};
void()	twin_runatk5	=[	$runattack5,	twin_runatk6	] {ai_melee_side();};
void()	twin_runatk6	=[	$runattack6,	twin_runatk7	] {ai_melee_side();};
void()	twin_runatk7	=[	$runattack7,	twin_runatk8	] {ai_melee_side();};
void()	twin_runatk8	=[	$runattack8,	twin_runatk9	] {ai_melee_side();};
void()	twin_runatk9	=[	$runattack9,	twin_runatk10	] {ai_melee_side();};
void()	twin_runatk10	=[	$runattack10,	twin_runatk11	] {ai_charge_side();};
void()	twin_runatk11	=[	$runattack11,	twin_run1	] {ai_charge(10);};

void()	twin_atk1	=[	$attackb1,		twin_atk2	]
{
	sound (self, CHAN_WEAPON, "knight/sword1.wav", 1, ATTN_NORM);
	ai_charge(0);
};
void()	twin_atk2	=[	$attackb2,		twin_atk3	] {ai_run_closer();};
void()	twin_atk3	=[	$attackb3,		twin_atk4	] {ai_run_closer();};
void()	twin_atk4	=[	$attackb4,		twin_atk5	] {ai_run_closer();};
void()	twin_atk5	=[	$attackb5,		twin_atk6	] {ai_run_closer();};
void()	twin_atk6	=[	$attackb6,		twin_atk7	] {ai_run_closer(); ai_melee();};
void()	twin_atk7	=[	$attackb7,		twin_atk8	] {ai_run_closer(); ai_melee();};
void()	twin_atk8	=[	$attackb8,		twin_atk9	] {ai_run_closer(); ai_melee();};
void()	twin_atk9	=[	$attackb9,		twin_atk10] {ai_run_closer();};
void()	twin_atk10=[	$attackb10,		twin_run1	] {ai_run_closer();};

void() ai_run_closer =
{
    if (self.lefty)
        ai_run_offset(45);

    ai_run_offset(45);
};

//===========================================================================

void()	twin_pain1	=[	$pain1,		twin_pain2	] {};
void()	twin_pain2	=[	$pain2,		twin_pain3	] {};
void()	twin_pain3	=[	$pain3,		twin_run1	] {};

void()	twin_painb1	=[	$painb1,	twin_painb2	] {ai_painforward(0);};
void()	twin_painb2	=[	$painb2,	twin_painb3	] {ai_painforward(3);};
void()	twin_painb3	=[	$painb3,	twin_painb4	] {};
void()	twin_painb4	=[	$painb4,	twin_painb5	] {};
void()	twin_painb5	=[	$painb5,	twin_painb6	] {ai_painforward(2);};
void()	twin_painb6	=[	$painb6,	twin_painb7	] {ai_painforward(4);};
void()	twin_painb7	=[	$painb7,	twin_painb8	] {ai_painforward(2);};
void()	twin_painb8	=[	$painb8,	twin_painb9	] {ai_painforward(5);};
void()	twin_painb9	=[	$painb9,	twin_painb10	] {ai_painforward(5);};
void()	twin_painb10	=[	$painb10,	twin_painb11	] {ai_painforward(0);};
void()	twin_painb11	=[	$painb11,	twin_run1	] {};

void(entity attacker, float damage)	twin_pain =
{
	local float r;

	if (self.pain_finished > time)
		return;

	r = random();

	sound (self, CHAN_VOICE, "knight/khurt.wav", 1, ATTN_NORM);
	if (r < 0.85)
	{
		twin_pain1 ();
		self.pain_finished = time + 1;
	}
	else
	{
		twin_painb1 ();
		self.pain_finished = time + 1;
	}

};

//===========================================================================

void()	twin_bow1	=[	$kneel1,		twin_bow2	] {ai_turn();};
void()	twin_bow2	=[	$kneel2,		twin_bow3	] {ai_turn();};
void()	twin_bow3	=[	$kneel3,		twin_bow4	] {ai_turn();};
void()	twin_bow4	=[	$kneel4,		twin_bow5	] {ai_turn();};

void()	twin_bow5	=[	$kneel5,		twin_bow5	] {ai_turn();};

void()	twin_bow6	=[	$kneel4,		twin_bow7	] {ai_turn();};
void()	twin_bow7	=[	$kneel3,		twin_bow8	] {ai_turn();};
void()	twin_bow8	=[	$kneel2,		twin_bow9	] {ai_turn();};
void()	twin_bow9	=[	$kneel1,		twin_bow10	] {ai_turn();};
void()	twin_bow10	=[	$walk1,		twin_walk1	] {ai_turn();};



void()	twin_die1	=[	$death1,	twin_die2	] {};
void()	twin_die2	=[	$death2,	twin_die3	] {};
void()	twin_die3	=[	$death3,	twin_die4	]
{
	self.solid = SOLID_NOT;
};
void()	twin_die4	=[	$death4,	twin_die5	] {};
void()	twin_die5	=[	$death5,	twin_die6	] {};
void()	twin_die6	=[	$death6,	twin_die7	] {};
void()	twin_die7	=[	$death7,	twin_die8	] {};
void()	twin_die8	=[	$death8,	twin_die9	] {};
void()	twin_die9	=[	$death9,	twin_die10] {};
void()	twin_die10=[	$death10,	twin_die10] {};


void()	twin_dieb1	=[	$deathb1,	twin_dieb2	] {};
void()	twin_dieb2	=[	$deathb2,	twin_dieb3	] {};
void()	twin_dieb3	=[	$deathb3,	twin_dieb4	]
{
	self.solid = SOLID_NOT;
};
void()	twin_dieb4	=[	$deathb4,	twin_dieb5	] {};
void()	twin_dieb5	=[	$deathb5,	twin_dieb6	] {};
void()	twin_dieb6	=[	$deathb6,	twin_dieb7	] {};
void()	twin_dieb7	=[	$deathb7,	twin_dieb8	] {};
void()	twin_dieb8	=[	$deathb8,	twin_dieb9	] {};
void()	twin_dieb9	=[	$deathb9,	twin_dieb10] {};
void()	twin_dieb10 = [	$deathb10,	twin_dieb11] {};
void()	twin_dieb11 = [	$deathb11,	twin_dieb11] {};


void() twin_die =
{
	// check for gib
	if (self.health < -40)
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowHead ("progs/h_knight.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		return;
	}

	// regular death
	sound (self, CHAN_VOICE, "knight/kdeath.wav", 1, ATTN_NORM);
	if (random() < 0.5)
		twin_die1 ();
	else
		twin_dieb1 ();
};


/*QUAKED monster_knight (1 0 0) (-16 -16 -24) (16 16 40) Ambush
*/
void() monster_twin =
{
	if (deathmatch)
	{
		remove(self);
		return;
	}
	precache_model ("progs/knight.mdl");
	precache_model ("progs/h_knight.mdl");

	precache_sound ("knight/kdeath.wav");
	precache_sound ("knight/khurt.wav");
	precache_sound ("knight/ksight.wav");
	precache_sound ("knight/sword1.wav");
	precache_sound ("knight/sword2.wav");
	precache_sound ("knight/idle.wav");

	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;

	setmodel (self, "progs/knight.mdl");

	setsize (self, '-16 -16 -24', '16 16 40');
	self.health = 75;

	self.th_stand = twin_stand1;
	self.th_walk = twin_walk1;
	self.th_run = twin_run1;
	self.th_melee = twin_atk1;
	self.th_pain = twin_pain;
	self.th_die = twin_die;

	walkmonster_start ();
};
