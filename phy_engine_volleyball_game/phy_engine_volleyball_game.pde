//victoria 
// jan 9

import fisica.*;

boolean up, down, left, right, w, s, d, a, lcanjump, rcanjump;

FWorld world;
FCircle lplayer, rplayer, ball;
FPoly lplatform, rplatform, lwall, rwall, net;

void setup () {
  size (800, 800);


  Fisica.init (this);
  world = new FWorld ();
  world.setGravity (0, 900);

  lplatform();
  rplatform();
  lwall();
  rwall();
  net ();
  lplayer ();
  rplayer ();
  ball();
}

void draw () {
  background (255);
  lcanjump =false;
  rcanjump=false;
  
 ArrayList <FContact> lcontact = lplayer.getContacts();
 ArrayList <FContact> rcontact= rplayer.getContacts();
  
  //int i=0;
  //while (i<contact.size()){
  //  FContact c= contact.get(i);
  //  if (c.contains (lplatform)) lcanjump=true;
  // i++;
  
  //}
  
  for (FContact c: lcontact) {
   if (c.contains (lplatform)) lcanjump=true;
  }
  
  for (FContact d: rcontact) {
   if (d.contains (rplatform)) rcanjump= true;
  }
  
  println(lcanjump);
  
  if (w&& lcanjump) lplayer.addImpulse (0,-1200);
  if (a) lplayer.addImpulse (-100, 0);
  if (d) lplayer.addImpulse (100, 0);
  if (s) ;
  
  if (up&& rcanjump) rplayer.addImpulse (0, -1200);
  if (left) rplayer.addImpulse (-100,0);
  if (right) rplayer.addImpulse (100, 0);
  if (down);
  
  
  world.step ();
  world.draw();
  
}

void lplatform () {
  lplatform= new FPoly();

  lplatform.vertex (0, height);
  lplatform.vertex (0, 700);
  lplatform.vertex (width/2, 700);
  lplatform.vertex (width/2, height);



  lplatform.setStatic (true);
  lplatform.setFill (0);

  world.add(lplatform);
}

void rplatform () {
  rplatform= new FPoly();

  rplatform.vertex (width/2, 700);
  rplatform.vertex (width/2, height);
  rplatform.vertex (width, height);
  rplatform.vertex (width, 700);

  rplatform.setStatic (true);
  rplatform.setFill (0);

  world.add(rplatform);
}

void lwall(){
  
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


void net () {

  net= new FPoly();

  net.vertex (width/2-5, 650);
  net.vertex (width/2-5, 700);
  net.vertex (width/2+5, 700);
  net.vertex (width/2+5, 650);

  net.setStatic (true);
  net.setFill (255);

  world.add(net);

}

void lplayer() {
 lplayer= new FCircle(50);
 lplayer.setPosition (random (0, width/2), 300);
 
 lplayer.setFill (255, 0, 0);
 
 world.add (lplayer);
 

}

void rplayer () {
 rplayer= new FCircle(50);
 rplayer.setPosition (random (width/2, width), 300);
 
 rplayer.setFill (0, 255, 0);
 
 world.add (rplayer);

}

void ball () {
ball= new FCircle (20);
ball. setPosition (width/2, 300);

ball.setFill (255);

world.add (ball);

}


void keyPressed () {
if (keyCode == UP) up=true;
  if (keyCode == DOWN) down=true;
  if (keyCode == LEFT) left=true;
  if (keyCode == RIGHT) right=true;
  if (key =='w') w=true;
  if (key =='s') s=true;
  if (key =='a') a=true;
  if (key =='d') d=true;
}

void keyReleased () {
if (keyCode == UP) up=false;
  if (keyCode == DOWN) down=false;
  if (keyCode == LEFT) left=false;
  if (keyCode == RIGHT) right=false;
  if (key =='w') w=false;
  if (key =='s') s=false;
  if (key =='a') a=false;
  if (key =='d') d=false;

}
