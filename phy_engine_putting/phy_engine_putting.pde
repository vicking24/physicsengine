//victoria
//mar 5

//count score, shots
//slope
//

// flappy bird
// pac man

import fisica.*;

PImage map;
int x, y, gridsize= 30;

color rough= color (34, 177, 76);

FWorld world;
FBox b;

void setup () {
  size (800, 800);

  Fisica.init (this);
  world =new FWorld (1000, -1000, 1000, -1000);

  map=loadImage ("green.png");

  while (y<map.height) {
    color c= map.get (x, y);


    if (c==rough) {
      b= new FBox (gridsize, gridsize);
      b.setFillColor (rough);
      b.setSensor (true);
      b.setFriction (1);

      world.add (b);
    }

    x++;

    if (x==map.width) {
      x=0;
      y++;
    }
  }
}


void draw () {
  background (255);





  world.step();
  world.draw();
}
