

class VelGauage {
  private

  float[] extremum(FloatList data) {
    float[] extr = {data.min(), data.max()};
    return(extr);
  }

  public

  FloatList scale = new FloatList();
  int radius = 100;
  float startAngle = 0;
  float stopAngle = TWO_PI;

  void setScale(FloatList data) {
    scale.clear();

    scale.append(extremum(data)[0]);
    scale.append(extremum(data)[1]);
  }

  void setSize(int r, float sta, float sto) {
    radius = r;
    startAngle = sta;
    stopAngle = sto;
  }

  float[] getPos(float vel) {
    float x = radius * cos( map(vel, 0, scale.get(1), startAngle, stopAngle) + PI );
    float y = radius * sin( map(vel, 0, scale.get(1), startAngle, stopAngle) + PI );

    float[] ret = {x, y};
    return(ret);
  }

  void drawGauage(int i) {
    float vel = myGoPro.getVelFromIndex(i);
    float[] pos = velGau.getPos(vel);

    velGraphic.beginDraw();
    velGraphic.clear();
    velGraphic.translate(width/2, height/2);

    velGraphic.stroke(0);
    velGraphic.strokeWeight(3);
    velGraphic.line(0, 0, pos[0], pos[1]);
    velGraphic.stroke(255);
    velGraphic.strokeWeight(1);
    velGraphic.line(0, 0, pos[0], pos[1]);

    velGraphic.textFont(velFont);
    velGraphic.textAlign(CENTER, CENTER);

    float topSpeed = myGoPro.velData.max() * 3.6; //km/h
    for (int num = 0; num <= topSpeed; num += 10) {
      float x = 110 * cos(map(num, 0, topSpeed, PI, 0));
      float y = - 110 * sin(map(num, 0, topSpeed, PI, 0));

      velGraphic.fill(0);
      velGraphic.textSize(23);
      velGraphic.text(num, x, y);
      velGraphic.fill(0);
      velGraphic.textSize(17);
      velGraphic.text(num, x, y);

      velGraphic.fill(255);
      velGraphic.textSize(20);
      velGraphic.text(num, x, y);
    }

    velGraphic.endDraw();

    String formatted = String.format("%06d", i);
    velGraphic.save("output/vel"+formatted+".png");
  }
}
