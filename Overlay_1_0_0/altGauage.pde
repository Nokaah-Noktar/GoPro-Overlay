

class AltGauage {
  private

  float[] extremum(FloatList data) {
    float[] extr = {data.min(), data.max()};
    return(extr);
  }

  public

  float minAlt, maxAlt, dataSize;
  int sizeX = 200;
  int sizeY = 100;

  void setScale(FloatList data) {
    minAlt = extremum(data)[0];
    maxAlt = extremum(data)[1];
    dataSize = data.size();
  }

  void setSize(int x, int y) {
    sizeX = x;
    sizeY = y;
  }

  float[] getPos(float alt, int dis) {
    float x = map(dis, 0, dataSize, 0, sizeX);
    float y = map(alt, minAlt, maxAlt, sizeY, 0);
    float[] ret = {x, y};
    return(ret);
  }

  void drawGauage(int i) {
    altGraphic.beginDraw();
    altGraphic.clear();
    altGraphic.translate(width/2, height/2);

    altGraphic.fill(0, 100);
    altGraphic.beginShape();

    float[] pos = {-1, -1};
    for (int a = 0; a < i; a++) {
      float alt = myGoPro.getAltFromIndex(a);
      pos = altGau.getPos(alt, a);
      altGraphic.vertex(pos[0], pos[1]);
    }

    altGraphic.vertex(pos[0], altGau.sizeY);
    altGraphic.vertex(0, altGau.sizeY);

    altGraphic.endShape();

    altGraphic.fill(255);
    altGraphic.stroke(0);
    altGraphic.circle(pos[0], pos[1], 8);

    altGraphic.endDraw();
    String formatted = String.format("%06d", i);
    altGraphic.save("output/alt"+formatted+".png");
  }
}
