// Object Modeling Example Code
float time = 0;   // time is used to move objects from one frame to another
boolean generateImages = false; // For instructors. Automatically generate images (and create a video manually).

void setup() {
  size(1200, 1200, P3D); // If 3D mode is not working on your mac, download the latest version of Processing with a proper version: "Apple Silicon" or "Intel 64-bit".
  
  //g = new GIF(this, "out.gif");
  frameRate(30);      // this seems to be needed to make sure the scene draws properly
  perspective(60 * PI / 180, 1, 0.1, 1000); // 60-degree field of view
}

int camOffsetX = 0;
float burnoutOffset = 0.0;
boolean invertBurnout = false;
float burnAngle = 0.0;
float cieling = PI/6;

float redCarX = 0;
float blueCarX = 0;

float driftAngle = 0;

int frame = 0;
void draw() {
  frame++;
  time += 0.05;
  save("frame" + frame + ".png");

  //camera (0, 0, 100, 0, 0, 0, 0, 1, 0); // position of the virtual camera
  
  background (50, 50, 75);  // clear screen and set background to light blue

  // set up the lights
  ambientLight(50, 50, 50);
  lightSpecular(255, 255, 255);
  directionalLight (100, 100, 100, -0.3, 0.5, -1);

  // set some of the surface properties
  noStroke();
  specular (180, 180, 180);
  shininess (10.0);
  //##########push rotation matrix for debugging#############
  //pushMatrix();
  //rotateY(time); // Rotate around the vertical axis
  
  
  //Take your pick of instanced shapes
  //We got cars, roads, traffic lights, wedges, and what have you.
  //IMPORTANT NOTE: The animation ends at time = 44 after which point it repeats.
  
  pushMatrix();
  road(1200);
  popMatrix();
  
  //shot 1
  
  if (time <= 10){
    camera (100, -25 + time*3, 0, 0, 0, 0, 0, 1, 0);
    
    pushMatrix();
    translate(60, -30, 0);
    rotateY(PI);
    stoplight(0);
    popMatrix();
    
    pushMatrix();
    translate(0, 0, -40);
    car(0, 0, 255);
    popMatrix();
    
    
    pushMatrix();
    translate(0, 0, 40);
    car(200, 0, 0);
    popMatrix();
  }
  
  //shot 2
  if (time > 10 && time <= 13){
    camera (-75, -25 + time*2, 0, 0, 0, 0, 0, 1, 0);
    
    pushMatrix();
    translate(0, 0, -40);
    car(0, 0, 255);
    popMatrix();
    
    pushMatrix();
    translate(0, 0, 40);
    car(200, 0, 0);
    popMatrix();
    
    if(time <= 12){
      pushMatrix();
      translate(60, -30, 0);
      rotateY(PI);
      stoplight(0);
      popMatrix();
    } else {
      pushMatrix();
      translate(60, -30, 0);
      rotateY(PI);
      stoplight(1);
      popMatrix();
    }
  }
  
  //shot 3
  if (time > 13 && time <= 16 ) {
    camera (40 + camOffsetX, 0, 100, 
            40 + camOffsetX, 0, 0, 
            0, 1, 0);
    
    pushMatrix();
    translate(0, 0, -40);
    car(0, 0, 255);
    popMatrix();
    
    pushMatrix();
    translate(0, 0, 40);
    car(200, 0, 0);
    popMatrix();
    
    pushMatrix();
    translate(60, -30, 0);
    rotateY(PI);
    stoplight(1);
    popMatrix();
    
    camOffsetX -= 1;
  }
  
  //shot 4
  if (time > 16 && time <= 18){
    camera (-40, -25, 0, 
            60, -30, 0, 
            0, 1, 0);
    
    if (time <= 17) {
      pushMatrix();
      translate(60, -30, 0);
      rotateY(PI);
      stoplight(1);
      popMatrix();
    } else {
      pushMatrix();
      translate(60, -30, 0);
      rotateY(PI);
      stoplight(2);
      popMatrix();
    }
    
  }
  
  //shot 5
  if (time > 18 && time <= 20) {
    
    if (time <= 19) {
      camera (50, -15, -40, 
              0, -15, -40, 
              0, 1, 0);
    } else {
      camera (50, -15, 40, 
              0, -15, 40, 
              0, 1, 0);
    }
    
    pushMatrix();
    translate(60, -30, 0);
    rotateY(PI);
    stoplight(2);
    popMatrix();
    
    pushMatrix();
    translate(0, 0, -40);
    car(0, 0, 255);
    popMatrix();
    
    pushMatrix();
    translate(0, 0, 40);
    car(200, 0, 0);
    popMatrix();
  }
  
  //shot 6
  if (time > 20 && time <= 22) {
    camera (-40, -25, 0, 
            60, -30, 0, 
            0, 1, 0);
    
    if (time <= 21) {
      pushMatrix();
      translate(60, -30, 0);
      rotateY(PI);
      stoplight(2);
      popMatrix();
    } else {
      pushMatrix();
      translate(60, -30, 0);
      rotateY(PI);
      stoplight(3);
      popMatrix();
    }
    
  }
  
  //shot 7
  if (time > 22 && time <= 28) {
    float burnVel = -1;
    if (burnoutOffset != 0) {
      burnVel = abs(1/(burnoutOffset * 6) * (cieling*2));
    } else {
        burnVel = 1/4;
    }
    
    if (invertBurnout){
      burnAngle -= burnVel;
    } else {
      burnAngle += burnVel;
    }   
    
    if (time < 25) {
      camera (100, -25 + (time % 22) *3, 0, 0, 0, 0, 0, 1, 0);
    } else {
      camera (-75, -25, 0, 0, 0, 0, 0, 1, 0);
    }
    
    pushMatrix();
    translate(60, -30, 0);
    rotateY(PI);
    stoplight(3);
    popMatrix();
    //print(" Burnout: " + burnVel);
    
    
    pushMatrix();
    translate(blueCarX, 0, -40 + burnoutOffset/2);
    rotateY(burnAngle);
    // The Car will be the sequenced shape
    car(0, 0, 255);
    popMatrix();

    
    pushMatrix();
    translate(redCarX, 0, 40);
    car(200, 0, 0);
    popMatrix();
    
    if (invertBurnout){
      burnoutOffset -= 1;
    } else {
      burnoutOffset += 1;
    }
    
    if(burnAngle > cieling || burnAngle < -cieling) {
      //print("Invert Burnout");
      invertBurnout = !invertBurnout;
      cieling = cieling - .07;
      
      if (invertBurnout){
        burnAngle = cieling;
      } else {
        burnAngle = -cieling;
      }
    }
    
    redCarX += 10;
    blueCarX += 6;
  }
  
  
  //shot 8
  if (time > 28 && time <= 34) {
    //pushMatrix();
    //finish(500);
    //popMatrix();
    
    
    float r = random(-1,1);
    if (time < 31) {
    camera (r + 20, 0, 85, 
            0, -r, 0, 
            0, 1, 0);
    } else {
    camera (r , 0, -85, 
            0, -r, 0, 
            0, 1, 0);
    }
    
    pushMatrix();
    translate(-10, 0, -40);
    // The Car will be the sequenced shape
    car(0, 0, 255);
    popMatrix();
    
    pushMatrix();
    translate(0, 0, 40);
    car(200, 0, 0);
    popMatrix();
  }
  
  //shot 9
  
  if(time > 34 && time < 35){
    blueCarX = -300;
    redCarX = -180;
  }
  if (time > 34 && time <= 44) {
    camera (-150, -50, 0, 0, 0, 0, 0, 1, 0);
    
    pushMatrix();
    finish(500);
    popMatrix();
    
    if (blueCarX <= 0) {
      pushMatrix();
      translate(blueCarX, 0, -40);
      car(0, 0, 255);
      popMatrix();
    } else if (driftAngle < 7*PI/6 ){
      driftAngle += .15 / (1+ driftAngle);
      pushMatrix();
      translate(blueCarX, 0, -40 / (driftAngle + 1) );
      rotateY(-driftAngle);
      car(0, 0, 255);
      popMatrix();
    } else {
      pushMatrix();
      translate(blueCarX, 0, -40 / (floor(driftAngle) + 1) );
      rotateY(-driftAngle);
      car(0, 0, 255);
      popMatrix();
    }
    
    
    pushMatrix();
    translate(redCarX, 0, 40);
    car(200, 0, 0);
    popMatrix();
    
    if (driftAngle < 7*PI/6){
      blueCarX += 20 / (floor(driftAngle) + 1);
    }
    redCarX += 50;
    
    
    //if (time > 34) {
    //  //pushMatrix();
    //  translate(24,0,0);
    //  //scale(0.1, 0.1, 0.1);
    //  fill(0, 255,255,255);
    //  textSize(150); 
    //  text("FINISH", 0, 0, 0);
    //  //popMatrix();
    //}

  }
  
  if (time > 44) {
    time = 0;
    delay(3000);
  }
  
  
  

  // Pop debugging rotation
  //popMatrix();

  
  //pushMatrix();
  //translate(0, 40, 0);
  //scale(0.1, 0.1, 0.1);
  //fill(0);
  //textAlign(CENTER);
  //textSize(48); 
  //text("1989 Ferari 640", 0, 0);
  //popMatrix();
  
  // Single frame capture with 'c' key
  if (keyPressed && key == 'c') {
    saveFrame("p2-######.png");
  }
  if (generateImages && frameCount < 300) {
    saveFrame("p2-######.png");
  }
}

void cylinder() {
  // Helper function to draw a cylinder radius = 1, z range in [-1, 1]
  cylinder(50);
}

void cylinder(int sides) {
  // Helper function to draw a cylinder with the given number of sides.
  
  // first endcap
  beginShape();
  for (int i = 0; i < sides; i++) {
    float theta = i * 2 * PI / sides;
    float x = cos(theta);
    float y = sin(theta);
    vertex(x, y, -1);
  }
  endShape(CLOSE);

  // second endcap
  beginShape();
  for (int i = 0; i < sides; i++) {
    float theta = i * 2 * PI / sides;
    float x = cos(theta);
    float y = sin(theta);
    vertex(x, y, 1);
  }
  endShape(CLOSE);
  
  // round main body
  float x1 = 1;
  float y1 = 0;
  for (int i = 0; i < sides; i++) {
    float theta = (i + 1) * 2 * PI / sides;
    float x2 = cos(theta);
    float y2 = sin(theta);
    beginShape();
    normal (x1, y1, 0);
    vertex (x1, y1, 1);
    vertex (x1, y1, -1);
    normal (x2, y2, 0);
    vertex (x2, y2, -1);
    vertex (x2, y2, 1);
    endShape(CLOSE);
    x1 = x2;
    y1 = y2;
  }
}

void wedge() {
  beginShape();
  vertex(-1, -1, -1);
  vertex( 1, -1, -1);
  vertex(   1,    0,  1);
  vertex(   -1,   0,  1);
  endShape();
  
  beginShape();
  vertex(-1, 1, -1);
  vertex( 1, 1, -1);
  vertex(   1,    0,  1);
  vertex(   -1,   0,  1);
  endShape();
  
  //base
  beginShape();
  vertex(-1, 1, -1);
  vertex( 1, 1, -1);
  vertex( 1, -1, -1);
  vertex(-1, -1, -1);
  endShape();
  
  beginShape();
  vertex(-1,1, -1);
  vertex(-1, -1, -1);
  vertex(-1,    0,  1);
  endShape();
  
  beginShape();
  vertex(1,1, -1);
  vertex(1, -1, -1);
  vertex(1,    0,  1);
  endShape();
  
}


void car(int R, int G, int B) {
  //Front Left
  fill (40, 40, 40);
  pushMatrix();
  translate (25, 5, 20);  
  scale (8, 8, 4);
  cylinder();
  popMatrix();
  
  fill (40,40, 40);
  pushMatrix();
  translate (-25, 5, 20);  
  scale (8, 8, 4);
  cylinder();
  popMatrix();
  
  fill (40, 40, 40);
  pushMatrix();
  translate (-25, 5, -20);  
  scale (8, 8, 4);
  cylinder();
  popMatrix();
  
  fill (40, 40, 40);
  pushMatrix();
  translate (25, 5, -20);  
  scale (8, 8, 4);
  cylinder();
  popMatrix();
  
  //front wing
  fill (R, G, B);
  pushMatrix();
  translate (45,7, 0);  
  rotateY(PI/2);
  scale (17, 3, 10);
  wedge();
  popMatrix();
  
  //Chassis
  fill (R, G, B);
  pushMatrix();
  translate (4, 7, 0);
  scale(13, 1.2, 5);
  box(5);
  popMatrix();
  
  fill (R, G, B);
  pushMatrix();
  translate (3,6,0);  
  rotateX(PI/2);
  scale (30, 15,4);
  cylinder();
  popMatrix();
  
  //Rear wing
  fill (R, G, B);
  pushMatrix();
  translate (-25,-10,0);  
  rotateY(PI/2);
  scale (20,1, 3);
  wedge();
  popMatrix();
  
  fill (0, 0, 0);
  pushMatrix();
  translate (-26, 0, 2);
  scale(2,20,2);
  box(1);
  popMatrix();
  
  fill (0, 0, 0);
  pushMatrix();
  translate (-26, 0, -2);
  scale(2,20,2);
  box(1);
  popMatrix();
  
  //Axels
  fill (40, 40, 40);
  pushMatrix();
  translate (25, 5, 0);  
  scale (1, 1, 20);
  cylinder();
  popMatrix();
  
  fill (40, 40, 40);
  pushMatrix();
  translate (-25, 5, 0);  
  scale (1, 1, 20);
  cylinder();
  popMatrix();
  
  //Intake
  fill (R, G, B);
  pushMatrix();
  translate (-3,1,0);
  //l,h,w
  scale (10, 8, 7);
  rotateY(PI/2);
  cylinder();
  popMatrix();
  
  fill (R, G, B);
  pushMatrix();
  translate (-18,1,0);
  //l,h,w
  scale (10, 5, 5);
  rotateY(PI/2);
  cylinder();
  popMatrix();
  
  //Driver
  fill (255, 250, 255);
  pushMatrix();
  translate(10, 0, 0);
  sphereDetail(60);
  sphere(4);
  popMatrix();
}

void road(int length){
  pushMatrix();
  fill(100,100,100);
  pushMatrix();
  scale(length, 1,150);
  translate(0,13,0);
  box(1);
  popMatrix();
  
  for (int i = 0; i < length; i++){
    if (i % 25  == 0){
      fill(255,255,255);
      //pointLight(255, 255, 255, i - length/2,12.9,0);
      pushMatrix();
      translate(i - length/2,12.9,0);
      scale(10, 1,4);
      box(1);
      popMatrix();
    }
  }
  popMatrix();
}

void stoplight(int light) {
  pushMatrix();
  
  fill(0,0,0);
  pushMatrix();
  scale(1, 4, 1);
  box(5);
  popMatrix();
  
  //Redlights
  
  if (light <= 2){
    fill(255,0,0);
    pointLight(255, 0, 0, 5, -3, 0);
    pushMatrix();
    translate(2,-6 + (light * 4),0);
    rotateY(PI/2);
    scale(2, 2, 1);
    cylinder();
    popMatrix();
  } else {
    fill(0,255,0);
    pointLight(0, 255, 0, 5, -3, 0);
    pushMatrix();
    translate(2,-6 + (light * 4),0);
    rotateY(PI/2);
    scale(2, 2, 1);
    cylinder();
    popMatrix();
  }
  
  
  //Greenlight
  
  popMatrix();
}

void finish(int length) {
  pushMatrix();
  
  pushMatrix();
  road(length);
  popMatrix();
  
  fill(255,255,255);
  pushMatrix();
  translate(0,12.9,0);
  scale(10, 1, 150);
  box(1);
  popMatrix();
  
  //pushMatrix();
  //translate(24,12,0);
  //scale(0.1, 0.1, 0.1);
  //fill(255,255,255);
  //textAlign(CENTER);
  //textSize(48); 
  //text("FINISH", 0, 0);
  //popMatrix();
  
  popMatrix();
}
