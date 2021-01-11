var hor = keyboard_check_direct(ord("D")) - keyboard_check_direct(ord("A"));

if !(jump) && !(roll) then ver = keyboard_check_pressed(ord("W"));
if !(roll) && !(jump) then rollnow = keyboard_check_pressed(vk_shift);

#region jump + physics + roll
if !(jump) {
	if(ver) {
		if (place_meeting(x, y+1, obj_wall) || prejump > 0) {
			jump = true;
		
			ver = 4
			
			yy = y;
		}
	}
	
	if prejump > 0 then prejump--;
	if (rollcooldown > 0 && roll = false) then rollcooldown--;
	
	if !place_meeting(x, yy+1, obj_wall) {
		yy+=down;
		
		if down < 4 then down+=grav;
		
		if place_meeting(x, yy+down, obj_wall) {
			for(i=down+1; i>0; i-=0.2) {
				if !place_meeting(x, yy+i, obj_wall) {
					yy+=i;
					break;
				}
			}
		}
		
		y = floor(yy);
	}else{
		prejump = 5;
		
		down = 1;
		
		yy = y;
	}
	
	if(rollnow = 1) && roll = false {
		roll = true;
		
		rollcooldown = 30;
	}
	
	if roll = true {
		rollcooldown-=1;
		
		iimage_angle-=12*horprev;
		
		if !place_meeting(x+(horprev*rollspd), y, obj_wall) {
			x+=horprev*rollspd;	
		}else{
			for(i=rollspd; i>0; i--) {
				if !place_meeting(x+(horprev*i), y, obj_wall) {
					x+=i*horprev;
					break;
				}
			}	
		}
		
		if rollcooldown <= 0 {
			rollcooldown = 30;
			
			roll = false;
			
			spdnow = rollspd;
		}
	}
}else{
	if ver > 0 {
		if !place_meeting(x, yy-ver, obj_wall) {
			yy-=ver;
		}else{
			for(i=ver; i>0; i-=0.2) {
				if !place_meeting(x, yy-i, obj_wall) {	
					yy-=i;
					break;
				}
			}
		}
		
		ver-=grav;
		
		y = floor(yy+1);
		
		if ver <= 0 then yy++;
	}else{
		if place_meeting(x, yy+abs(ver), obj_wall) {
			for(i=abs(ver); i>0; i-=0.2) {
				if !place_meeting(x, yy+i, obj_wall) {
					yy+=i;
					break;
				}
			}
		}else{
			yy-=ver;
			ver-=grav;	
		}
		
		if place_meeting(x, y+1, obj_wall) {
			jump = false;
		}
		
		y = floor(yy);
	}
}

#endregion

if (hor != 0) && !(roll) {
	if spdnow < spd then spdnow+=1;
	
	if !place_meeting(x+(hor*spdnow), y, obj_wall) {
		x+=hor*spdnow;
	}else{
		if spdnow < 4 {
			for(i=spdnow+1; i>0; i--) {
				if !place_meeting(x+(hor*i), y, obj_wall) {
					x+=i*hor;
					break;
				}
			}
		}
	}

	horprev = hor;
}

if (hor = 0) {
	spdnow = 0;
}