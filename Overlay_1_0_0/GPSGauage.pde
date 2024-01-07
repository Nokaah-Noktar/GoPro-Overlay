

class GPSGauage {
  private
  float[] extremum(FloatList data) {
    float[] extr = {data.min(), data.max()};
    return(extr);
  }

  public

  float minLat = 0;
  float minLon = 0;
  float maxLat = 1;
  float maxLon = 1;

  int sizeX, sizeY = 100;

  FloatList lat = new FloatList();
  FloatList lon = new FloatList();

  void setScale(FloatList lon, FloatList lat) {
    minLat = extremum(lat)[0];
    maxLat = extremum(lat)[1];
    minLon = extremum(lon)[0];
    maxLon = extremum(lon)[1];
  }

  void setSize(int x, int y) {
    sizeX = x;
    sizeY = y;
  }

  float[] getPos(float lat, float lon) {
    float dLon = maxLon - minLon;
    float dLat = maxLat - minLat;
    float largDiv = (dLat > dLon ? dLat : dLon);

    float posLon = (lon-minLon) * (sizeX/largDiv) + (largDiv-lon-minLon)/2;
    float posLat = (lat-minLat) * (sizeY/largDiv) + (largDiv-lat-minLat)/2;

    float[] temp = {posLon, posLat};
    return(temp);
  }

  void drawGauage(int i) {
    float[] GPS = myGoPro.getGPSFromIndex(i);
    float[] pos = GPSGau.getPos(GPS[0], GPS[1]);
    float x = pos[0];
    float y = pos[1];

    GPSGraphic.beginDraw();
    GPSGraphic.translate(width/2, height/2);

    GPSGraphic.fill(255);
    GPSGraphic.stroke(0);
    GPSGraphic.strokeWeight(1);

    GPSGraphic.circle(x, y, 8);

    GPSGraphic.endDraw();

    String formatted = String.format("%06d", i);
    GPSGraphic.save("output/GPS"+formatted+".png");
  }
}
