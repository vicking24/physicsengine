//victoria 
//feb 18

//game end

import fisica.*;

boolean up, down, left, right, canjump, start;

float tall1, tall2, tall3, tall4, tall5;

int point=0, starttimer=0, timer=120, countdown=0;

FWorld world;
FCircle player, ball, hole; 
FPoly ground, lwall, rwall, ceiling;
FBox ob1, ob2, ob3, ob4, ob5;

void setup () {
  size (800, 800);
  start=true;
  textAlign (CENTER, CENTER);

  tall1=random (70, 150);
  tall2=random (50, 150);
  tall3=random (50, 150);
  tall4=random (50, 150);
  tall5= random (100, 200);

  Fisica.init(this);
  world=new FWorld();
  world.setGravity (0, 600);

  ground();
  player();
  lwall();
  rwall();
  ceiling();
  ob1();
  ob2();
  ob3();
  ob4();
  ob5();
  ball();
  hole();
}

void draw () {

  canjump=false;

  if (start==true) {

    background (255);

    fill (0);
    textSize (30);
    text ("Time Left:"+timer+"s", 105, 30);

    countdown++;
    if (countdown>60) {
      timer--;
      countdown=0;
    }

    if (ball.getVelocityX()>1500) ball.setVelocity(1500, ball.getVelocityY());
    if (ball.getVelocityY()>1500) ball.setVelocity (ball.getVelocityX(), 1500);

    ArrayList <FContact> contact= player.getContacts();

    for (FContact c : contact) {
      if (c.contains (ground)|| c.contains (ob1)||  c.contains (ob2)|| c.contains (ob3)|| c.contains (ob4)|| c.contains (ob5)) canjump=true;
    }

    if (up&& canjump) player.addImpulse (0, -1200);
    if (left) player.addImpulse (-120, 0);
    if (right) player.addImpulse (120, 0);

    ArrayList <FContact> contactb= ball.getContacts();

    for (FContact b : contactb) {
      if (b.contains (hole)) {
        point++;
        tall1=random (70, 150);
        tall2=random (50, 150);
        tall3=random (50, 150);
        tall4=random (50, 150);
        tall5=random (100, 200);
        ob1.setPosition (random (150, width-150), height-100-tall1/2);
        ob1.setHeight (tall1);
        ob2.setPosition (random (200, width-150), tall2/2);
        ob2.setHeight (tall2);
        ob3.setPosition (tall3/2, random (200, height-150));
        ob3.setWidth(tall3);
        ob4.setPosition (width-tall4/2, random (200, height-150));
        ob4.setWidth (tall4);
        ob5.setPosition (width/2, height/2+100);
        ob5.setWidth (tall5);
        hole.setPosition (random (120, width-120), random (120, height-100-20));
        ball.setPosition (random (0, 500), 300);
        ball.setVelocity (0, 0);
        player.setPosition (random (0, 500), 500);
        player.setVelocity (0, 0);
        start=false;
      }
    }


    textSize (30);
    fill (0);
    text ("Points:"+point, 700, 30);
    
    if (timer<0){
    start=false;
    }

    world.step();
    world.draw();
  } else {
    starttimer++;

    if (timer>0 && starttimer>120) {
      start=true;
      starttimer=0;
    } 
    
    if (timer<=0) {
    background (0);
    fill (255);
    textSize (50);
    text ("SCORE:"+point, width/2, height/2);
    }
    
  }
}

void ground() {
  ground= new FPoly();

  ground.vertex (0, height);
  ground.vertex (0, 700);
  ground.vertex (width, 700);
  ground.vertex (width, height);

  ground.setStatic (true);
  ground.setFill (0);

  world.add (ground);
}

void player() {
  player= new FCircle (50);
  player.setPosition (random (0, 500), 500);
  player.setFill (255, 0, 0);

  world.add (player);
}

void lwall() {

  lwall= new FPoly();

  lwall.vertex (0, 0);
  lwall.vertex (0, height);
  lwall.vertex (-100, height);
  lwall.vertex (-100, 0);

  lwall.setStatic (true);
  lwall.setFill (255);

  world.add(lwall);
}


void rwall () {

  rwall= new FPoly();

  rwall.vertex (width, 0);
  rwall.vertex (width, height);
  rwall.vertex (900, height);
  rwall.vertex (900, 0);

  rwall.setStatic (true);
  rwall.setFill (255);

  world.add(rwall);
}

void ceiling () {
  ceiling = new FPoly();

  ceiling.vertex (0, 0);
  ceiling.vertex (width, 0);
  ceiling.vertex (width, -100);
  ceiling.vertex (0, -100);

  ceiling.setStatic (true);
  ceiling.setFill (0);

  world.add(ceiling);
}

void ob1 () {

  ob1= new FBox(10, tall1);
  ob1.setPosition (random (150, width-150), height-100-tall1/2);

  ob1.setStatic (true);
  ob1.setFill (0);

  world.add(ob1);
}

void ob2() {
  ob2= new FBox(10, tall2);
  ob2.setPosition (random (200, width-150), tall2/2);

  ob2.setStatic (true);
  ob2.setFill (255, 0, 0);

  world.add(ob2);
}

void ob3() {

  ob3= new FBox(tall3, 10);
  ob3.setPosition (tall3/2, random (200, height-150));

  ob3.setStatic (true);
  ob3.setFill (0, 255, 0);

  world.add(ob3);
}

void ob4() {

  ob4= new FBox(tall4, 10);
  ob4.setPosition (width-tall4/2, random (200, height-150));

  ob4.setStatic (true);
  ob4.setFill (0, 0, 255);

  world.add(ob4);
}

void ob5 () {
  ob5= new FBox(tall5, 10);
  ob5.setPosition (width/2, height/2+100);

  ob5.setStatic (true);
  ob5.setFill (255);

  world.add(ob5);
}


void ball () {
  ball= new FCircle (20);
  ball. setPosition (random (0, 500), 300);

  ball.setRestitution (1.2);



  ball.setFill (255);

  world.add (ball);
}

void hole () {
  hole = new FCircle (40);
  hole.setPosition (random (120, width-120), random (120, height-100-20));

  hole.setFill (0);
  hole.setStatic (true);

  world.add (hole);
}


void keyPressed () {
  if (keyCode == UP) up=true;
  if (keyCode == LEFT) left=true;
  if (keyCode == RIGHT) right=true;
}

void keyReleased () {
  if (keyCode == UP) up=false;
  if (keyCode == LEFT) left=false;
  if (keyCode == RIGHT) right=false;
}
