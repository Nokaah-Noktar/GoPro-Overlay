

class GyrGauage {
  private
  float[] extremum(FloatList data) {
    float[] extr = {data.min(), data.max()};
    return(extr);
  }

  public

  int sizeX, sizeY, sizeZ = 100;
  float maxX, maxY, maxZ, minX, minY, minZ = 0;


  void setScale(FloatList x, FloatList y, FloatList z) {
    float[] exX = extremum(x);
    float[] exY = extremum(y);
    float[] exZ = extremum(z);

    minX = exX[0];
    maxX = exX[1];
    minY = exY[0];
    maxY = exY[1];
    minZ = exZ[0];
    maxZ = exZ[1];
  }

  void setSize(int x, int y, int z) {
    sizeX = x;
    sizeY = y;
    sizeZ = z;
  }

  float[] getPos(float x, float y, float z) {
    float posX = map(x, minX, maxX, 0, sizeX);
    float posY = map(y, minY, maxY, 0, sizeY);
    float posZ = map(z, minZ, maxZ, 0, sizeZ);

    float[] ret = {posX, posY, posZ};
    return(ret);
  }

  void drawGauage(int i) {
    float[] val = myGoPro.getGyrFromIndex(i);
    gyrGraphic.beginDraw();
    gyrGraphic.translate(width/2, height/2);
    gyrGraphic.clear();


    pitch -= (val[0]*180/PI) / setFps;
    roll += (val[1] / setFps);

    gyrGraphic.push();
    gyrGraphic.rotate(roll + (cos(pitch*PI/180.0) < 0 ? PI : 0));

    float posY = 0;
    if (pitch > 0) {
      posY = (cos(pitch*PI/180.0) > 0 ? (sin(pitch*PI/180.0) > 0 ? pitch%90 : -90+pitch%90) : (sin(pitch*PI/180.0) > 0 ? 90-pitch%90 : -pitch%90)); //Holy hell...
    } else {
      posY = (cos(pitch*PI/180.0) > 0 ? (sin(pitch*PI/180.0) > 0 ? 90+pitch%90 : pitch%90) : (sin(pitch*PI/180.0) > 0 ? -pitch%90 : -90-pitch%90)); //Holy hell two...
    }

    gyrGraphic.fill(100, 50, 50);
    gyrGraphic.rect(-width/2, posY, width, height/2);
    gyrGraphic.fill(0, 255, 255);
    gyrGraphic.rect(-width/2, posY, width, -height/2);

    for (int a = -90; a <= 90; a+=15) {
      gyrGraphic.fill(0);
      gyrGraphic.textSize(15);
      gyrGraphic.textAlign(CENTER, CENTER);
      if (a != 0) gyrGraphic.text(-a, 0, a+posY);
    }

    PGraphics mask = createGraphics(width, height, JAVA2D);
    mask.beginDraw();
    mask.translate(width/2, height/2);
    mask.clear();
    mask.fill(255, 255, 255);
    mask.circle(0, 0, 200);
    gyrGraphic.pop();

    gyrGraphic.push();
    gyrGraphic.strokeWeight(3);
    gyrGraphic.stroke(255, 255, 0);
    gyrGraphic.noFill();
    //gyrGraphic.text(pitch, 50, 0);
    gyrGraphic.line(-75, 0, -25, 0);
    gyrGraphic.line(-25, 0, -25, 10);
    gyrGraphic.line(25, 0, 75, 0);
    gyrGraphic.line(25, 0, 25, 10);
    gyrGraphic.circle(0, 0, 20);
    gyrGraphic.pop();

    mask.endDraw();
    gyrGraphic.mask(mask);

    gyrGraphic.endDraw();
    String formatted = String.format("%06d", i);
    gyrGraphic.save("output/gyr"+formatted+".png");
  }
}
