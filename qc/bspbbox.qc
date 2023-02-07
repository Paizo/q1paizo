/*
    just a simple test entity using a bsp model

*/
void() bbox_die = {
    bprint("bbox_die\n");
    remove(self);
}

void() bbox_touch = {
    bprint("bbox_touch\n");
}

void() item_bbox =
{
    local float oldz;

    bprint("item_bbox\n");

	self.solid = SOLID_BBOX;
	self.movetype = MOVETYPE_PUSH;
    precache_model("maps/modelboxtest.bsp");
	setmodel(self, "maps/modelboxtest.bsp");
//	precache_sound ("weapons/r_exp3.wav");
	self.health = 20;
	self.th_die = bbox_die;
	self.touch = bbox_touch;
	self.takedamage = DAMAGE_AIM;

	self.origin_z = self.origin_z + 2;
	oldz = self.origin_z;
	droptofloor();
	if (oldz - self.origin_z > 250)
	{
		dprint ("item fell out of level at ");
		dprint (vtos(self.origin));
		dprint ("\n");
		remove(self);
	}
}