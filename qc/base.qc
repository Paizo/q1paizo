
//	public double dot(Vec3 v) {
//		return (this.x * v.x) + (this.y * v.y) + (this.z * v.z);
//	}

vector(vector a, vector b) crossproduct =
{
	local vector result;

	result_x = a_y * b_z - a_z * b_y;
	result_y = a_z * b_x - a_x * b_z;
	result_z = a_x * b_y - a_y * b_x;

	return result;
};

/*
=============
ai_run_offset

Strafe sideways ofs = 90
no strafe ofs = 0
=============
*/
void(float ofs) ai_run_offset =
{
	self.ideal_yaw = enemy_yaw;
	ChangeYaw ();
	if (self.lefty)
		ofs = 45;
	else
		ofs = -45;

	if (walkmove (self.ideal_yaw + ofs, movedist))
		return;

	self.lefty = 1 - self.lefty;

	walkmove (self.ideal_yaw - ofs, movedist);
};

/*
Same as ai_charge_side but instead of aiming 30 units to the left
you can specify how many unit, negative number aim right
*/
void(float angle) ai_charge_side_offset =
{
	local vector dtemp;
	local float heading;

	// aim to the left of the enemy for a flyby

	self.ideal_yaw = vectoyaw(self.enemy.origin - self.origin);
	ChangeYaw ();

	makevectors (self.angles);
	dtemp = self.enemy.origin - 30*v_right;
	heading = vectoyaw(dtemp - self.origin);

	walkmove(heading, 20);
};
/*
    Vnew = b * ( -2*(V dot N)*N + V )
    bugged, always point towards bottom
*/
void(entity ball, entity obj) bounce_off =
{
	local vector normal, tmp, tmp2, tmp3;
	local float f1;
	//bounce speed, how much force is lost; 1.0 = no loss
    local float b = 1.0;

    traceline (ball.origin, obj.origin, FALSE, ball);

    bprint(vtos(trace_plane_normal));
    //normal = normalize(trace_plane_normal);
    normal = trace_plane_normal;

//    self.velocity = b * ( - 2.0 * (crossproduct(self.velocity, normal)) * normal + self.velocity);
    tmp = crossproduct(ball.velocity, normal);
    bprint(vtos(tmp));
    tmp2 = tmp * -2;
    bprint(vtos(tmp2));
    f1 = tmp2 * normal;

    tmp3 = ball.velocity * f1; // should be +
    ball.velocity = tmp3 * b;
    bprint(vtos(ball.velocity));
    ball.angles = vectoangles(ball.velocity);

//    newmis.nextthink = time + 5;
//    newmis.think = SUB_Remove;
//    newmis.touch = Laser_Touch;
};

