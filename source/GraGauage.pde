

class GraGauage{
  public
  
  int sizeX, sizeY, sizeZ = 100;
  
  void setSize(int x, int y, int z){
    sizeX = x;
    sizeY = y;
    sizeZ = z;
  }
  
  void drawGauage(int i){
    float[] val = myGoPro.getGraFromIndex(i);
    float x = val[0];
    float y = val[1];
    float z = val[2];
    
    graGraphic.beginDraw();
    graGraphic.translate(width/2, height/2);
    graGraphic.clear();
    
    graGraphic.stroke(0);
    graGraphic.strokeWeight(1);
    
    float roll = atan2(z, x);
    float pitch = (atan2(z, y) - PI/2) *180/PI;

    float posY = 0;
    if (pitch > 0) {
      posY = (cos(pitch*PI/180.0) > 0 ? (sin(pitch*PI/180.0) > 0 ? pitch%90 : -90+pitch%90) : (sin(pitch*PI/180.0) > 0 ? 90-pitch%90 : -pitch%90)); //Holy hell...
    } else {
      posY = (cos(pitch*PI/180.0) > 0 ? (sin(pitch*PI/180.0) > 0 ? 90+pitch%90 : pitch%90) : (sin(pitch*PI/180.0) > 0 ? -pitch%90 : -90-pitch%90)); //Holy hell two...
    }

    graGraphic.push();
    graGraphic.rotate(roll-PI/2);
    
    graGraphic.fill(100, 50, 50);
    graGraphic.rect(-width/2, posY, width, height/2);
    graGraphic.fill(0, 255, 255);
    graGraphic.rect(-width/2, posY, width, -height/2);

    for (int a = -90; a <= 90; a+=15) {
      graGraphic.fill(0);
      graGraphic.textSize(15);
      graGraphic.textAlign(CENTER, CENTER);
      if (a != 0) graGraphic.text(-a, 0, a+posY);
    }

    PGraphics mask = createGraphics(width, height, JAVA2D);
    mask.beginDraw();
    mask.translate(width/2, height/2);
    mask.clear();
    mask.fill(255, 255, 255);
    mask.circle(0, 0, 200);
    graGraphic.pop();
    
    graGraphic.push();
    graGraphic.strokeWeight(3);
    graGraphic.stroke(255, 255, 0);
    graGraphic.noFill();
    //graGraphic.text(pitch, 50, 0);
    graGraphic.line(-75, 0, -25, 0);
    graGraphic.line(-25, 0, -25, 10);
    graGraphic.line(25, 0, 75, 0);
    graGraphic.line(25, 0, 25, 10);
    graGraphic.circle(0, 0, 20);
    graGraphic.pop();
    graGraphic.mask(mask);    
    
    graGraphic.endDraw();
    String formatted = String.format("%06d", i);
    graGraphic.save("output/gra"+formatted+".png");
  }
}
