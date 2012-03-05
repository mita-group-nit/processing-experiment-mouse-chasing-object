float drag = 100;
float duration = 10;
float countdown = 0;
Monster m;

void setup() {
  size(400,400);
  countdown = duration;
  m = new Monster();
  m.incTrust(100);
  m.paint();
}

boolean mouseIsPressed = false;

void mousePressed() {
  mouseIsPressed = true;
}

void mouseReleased() {
  mouseIsPressed = false;
}

void mouseMoved() {
  m.resetStart();
}

void draw() {
  background(255);
  /*
  if (countdown > 0) {
    m.move();
  }
  countdown--;
  */
  if (!mouseIsPressed) {
    m.decTrust(1000);
  } else {
    m.incTrust(100);
  }
  m.move();
  m.paint();
}

class Monster {
  boolean resetStart = true;
  int xpos = 0;
  int ypos = 0;
  float velocity = 0;  
  float trust = 0;
  
  void resetStart() {
    resetStart = true;
  }
  
  void incTrust(float amount) {
    trust += amount;
    if (trust < 0) {
      trust = 0;
    }
    if (trust > 1000) {
      trust = 1000;
    }
  }
  
  void decTrust(float amount) {
    trust -= amount;
    if (trust < 0) {
      trust = 0;
    }
    if (trust > 1000) {
      trust = 1000;
    }
  }

  void calcVelocity() {
    velocity += trust;
    float ddrag = (velocity / drag);
    velocity -= ddrag;
    if (velocity < 0) {
      velocity = 0;
    }
    if (velocity > 1000) {
      velocity = 1000;
    }
    println("Velocity: " + velocity + " - Trust: " + trust + " - Drag: " + ddrag);
  }
  
  void move() {
    calcVelocity();
    int movX = 0;
    int movY = 0;
    if (mouseX > 0) {
      int distX = abs(mouseX - xpos);
      int distY = abs(mouseY - ypos);
      println("DistanceX: " + distX);
      println("DistanceY: " + distY);
      float distance = sqrt(pow(distX,2)+pow(distY,2));
      println("Distance: " + distance);
      if (distY != 0) {
        movX = (int)distance / distY;
        if (mouseX < xpos)
          movX *= -1;
      }
      if (distX != 0) {
        movY = (int)distance / distX;
        if (mouseY < ypos)
          movY *= -1;
      }
      delay(((abs(movX)-1)+(abs(movY)-1))*10);
      println("Moving " + movX + " to the X and " + movY + " to the Y");
    }
    xpos += movX;
    ypos += movY;
    //delay(1000-(int)velocity);
    if (xpos > width || ypos > height) {
      xpos = -50;
      ypos = -50;
      resetStart = true;
    }
  }
  
  void paint() {
    color c = color(100);
    fill(c);
    rect(xpos, ypos, 50, 50);  
  }
  
}
