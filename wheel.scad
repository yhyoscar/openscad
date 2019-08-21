

r = 20;
hext = 3;
hin = 2;
wbar = 3;

nhole = 5;
holeoffset = 3;
axisr1 = 2.5;
axisr2 = 4;
axish = 5;
axisrr = 1.5;
wheelthick = 1.4;

teeththick = 0.6;
teethgap = 0.8;

fn1 = 54;
fnaxis = 32;

pointarc=[for (ang=[0:1:fn1/nhole-1]) [cos(-360/nhole/2 + ang*nhole*(360/nhole)/fn1)*(r-wheelthick-teeththick),sin(-360/nhole/2 + ang*nhole*(360/nhole)/fn1)*(r-wheelthick-teeththick)] ];

union() {
difference() {
    union(){
        difference() {    
        cylinder(r=r, h=hext, $fn=fn1);
        translate([0,0,hin]) { 
            cylinder(r=r-wheelthick-teeththick, h=hext, $fn=fn1); 
            }
        
        for (i=[0:1:fn1-1]) {
            rotate(i*360/fn1, [0,0,1]) {
                translate([r-teeththick/2,0,-0.1]) {
                    rotate(45, [1,0,0]) {
                        cube([teeththick+0.1, teethgap, hext*sqrt(2)+teethgap], center=true);
                        }
                    translate([0,0,hext]) {
                    rotate(-45, [1,0,0]) {
                        cube([teeththick+0.1, teethgap, hext*sqrt(2)+teethgap], center=true);
                        }
                    }
                    }
                }
            }
            
        for (ihole=[0:1:nhole-1]) {
            rotate(ihole*360/nhole, [0,0,1]) {
                translate([0,0,-0.1]) {
                    linear_extrude(height = hext+0.2, twist = 0) {
                        
                        offset(r=holeoffset, $fn=32) {
                            offset(r=-holeoffset-wbar/2) {
                                polygon(points=concat([[0,0]], pointarc) );
                                }
                            }

                        }
                    }
                }
            }
        }
        cylinder(r=axisr2, h=axish, $fn=fnaxis);
        
        for (ia=[0:1:nhole-1]) {
            rotate(ia*360/nhole+360/nhole/2-3, [0,0,1]) {
            translate([axisr2+axish-hin-0.15, 1, axish-0.1]) {
            rotate(180, [0,0,1]) {
            rotate(-90, [1,0,0]) {
            difference() {
                cube([axish-hin, axish-hin, 2], center=false);
                translate([0,0,-0.5]){cylinder(r=axish-hin, h=3, $fn=32);} }}}}}}
    }
translate([0,0,-0.1]) {cylinder(r=axisr1, h=axish+0.2, $fn=fnaxis);}
}

translate([2.5,0,axish/2]) {cube([1,5,axish], center=true); }
translate([-2.5,0,axish/2]) {cube([1,5,axish], center=true); }

}

