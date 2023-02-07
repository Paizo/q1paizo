/*
==============================================================================

SPIDER

==============================================================================
*/
$cd /raid/quake/id1/models/spider
$origin 0 0 -24
$base base
$skin skin
$scale 0.7

$frame frame1 frame2 frame3 frame4 frame5 frame6 frame7 frame8 frame9 frame10
$frame death1 death2 death3 death4 death5 death6 death7 death8 death9 death10
$frame pain1 pain2 pain3 pain4 pain5 pain6 pain7 pain8 pain9 pain10 pain11

void() printText;
void() draw_char_as_pixel_art;

void() particle_stand1    =[      $pain1,       particle_stand2    ] {printText();};
void() particle_stand2    =[      $pain2,       particle_stand1    ] {ai_face();};

void(entity attacker, float damage) particle_pain =
{
    particle_stand1();
};

void() printText =
{
    if (self.enemy)
        return;
    draw_char_as_pixel_art();
};

//        void particle(vector origin,
//        vector dir, float color,
//        float count)
//origin = initial position
//dir = initial direction
//color = color index (73,75...)
//count = time to live, in seconds .Create a particle effect (small dot that flies away).
//color = 0 for chunk
//color = 75 for yellow
//color = 73 for blood red
//color = 225 for entity damage
void() draw_char_as_pixel_art =
{
//  bprint (" draw_char_as_pixel_art\n");
  makevectors (self.angles);
  local float row = 0.0;
  local float col = 0.0;
  local vector where;
  local vector tmpwhere = self.origin + '32 32 32';

  local vector dir = self.enemy.origin - tmpwhere;
  local float scale = 1.0;


  while (row < 8.0)
  {
    while (col < 8.0)
    {
        where.x = tmpwhere_x + col;
        where.y = tmpwhere_y + row;
        where.z = tmpwhere_z;
        particle(where, dir, 79, 2);
        col = col + 1.0;
    }
    row = row + 1.0;
  }
};

void() particleDie =
{
    self.think = SUB_Remove;
    self.nextthink = time + 0.1;
};
//=================================================================

void() monster_particle =
{
	if (deathmatch)
	{
		remove(self);
		return;
	}
	precache_model2 ("progs/spider.mdl");

	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	
	setmodel (self, "progs/spider.mdl");
	setsize (self, '-32 -32 -24', '32 32 5');
	self.health = 200;

    self.th_stand = particle_stand1;
    self.th_walk = particle_stand1;
    self.th_run = particle_stand1;
    self.th_melee = particle_stand1;
    self.th_pain = particle_pain;
    self.th_die = SUB_Remove;

	self.think = walkmonster_start;
    self.nextthink = time + 0.1 + random()*0.1;
};
