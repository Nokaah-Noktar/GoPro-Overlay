

class AccGauage {
  private
  float[] extremum(FloatList data) {
    float[] extr = {data.min(), data.max()};
    return(extr);
  }


  public
  FloatList scale = new FloatList();
  int sizeX, sizeY, sizeZ = 100;

  void setScale(FloatList dataX, FloatList dataY, FloatList dataZ) {
    scale.clear();
    float[] minmax = extremum(dataX);
    scale.append(minmax[0]);
    scale.append(minmax[1]);

    minmax = extremum(dataY);
    scale.append(minmax[0]);
    scale.append(minmax[1]);

    minmax = extremum(dataZ);
    scale.append(minmax[0]);
    scale.append(minmax[1]);
  }

  void setSize(int x, int y, int z) {
    sizeX = x;
    sizeY = y;
    sizeZ = z;
  }

  float[] getPos(float accX, float accY, float accZ) {
    float posX = map(accX, scale.get(0), scale.get(1), -sizeX/2, sizeX/2);
    float posY = map(accY, scale.get(2), scale.get(3), -sizeY/2, sizeY/2);
    float posZ = map(accZ, scale.get(4), scale.get(5), -sizeZ/2, sizeZ/2);
    float[] ret = {posX, posY, posZ};
    return(ret);
  }

  void drawGauage(int i) {
    float accel[] = myGoPro.getAccFromIndex(i);
    float[] pos = accGau.getPos(accel[1], accel[2], accel[3]);

    accGraphic.beginDraw();
    accGraphic.clear();
    accGraphic.translate(width/2, height/2);
    accGraphic.noFill();
    accGraphic.stroke(0);
    accGraphic.strokeWeight(2);
    accGraphic.rect(-50, -50, 100, 100);
    accGraphic.fill(255);
    accGraphic.circle(pos[0], pos[1], 8);
    accGraphic.circle(70, pos[2], 8);
    accGraphic.endDraw();

    String formatted = String.format("%06d", i);
    accGraphic.save("output/acc"+formatted+".png");
  }
}
