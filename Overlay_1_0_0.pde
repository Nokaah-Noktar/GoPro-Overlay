String version = "1.0.0";

int smoothVal = 1;

GoPro myGoPro = new GoPro();

AccGauage accGau = new AccGauage();
VelGauage velGau = new VelGauage();
GPSGauage GPSGau = new GPSGauage();
AltGauage altGau = new AltGauage();

GyrGauage gyrGau = new GyrGauage();
float roll = 0;
float pitch = 0;

boolean renderingAcc = false;
boolean renderingVel = false;
boolean renderingGPS = false;
boolean renderingAlt = false;
boolean renderingGyr = false;

PGraphics accGraphic;
PGraphics velGraphic;
PGraphics GPSGraphic;
PGraphics altGraphic;
PGraphics gyrGraphic;

int i = 0;
int iAccMax, iVelMax, iGPSMax, iAltMax, iGyrMax, T0;


exporter myExporter = new exporter();
deleteOldFiles myDeleter = new deleteOldFiles();

PFont velFont;

int setFps = 0;

String[] menues = {"Settings", "Render"};
String menu = menues[0];



void setup() {
  PImage icon = loadImage("overlay.jpeg");
  surface.setIcon(icon);

  myDeleter.deleteFiles();

  velFont = createFont("arial", 20);
  makeGUI();

  smooth(0);
  size(600, 600);
  frameRate(60);

  accGraphic = createGraphics(width, height, JAVA2D);
  velGraphic = createGraphics(width, height, JAVA2D);
  GPSGraphic = createGraphics(width, height, JAVA2D);
  altGraphic = createGraphics(width, height, JAVA2D);
  gyrGraphic = createGraphics(width, height, JAVA2D);

  accGraphic.smooth(smoothVal);
  velGraphic.smooth(smoothVal);
  GPSGraphic.smooth(smoothVal);
  altGraphic.smooth(smoothVal);
  gyrGraphic.smooth(smoothVal);
}



void draw() {

  if (menu == "Render") {
    //Acc
    if (i < iAccMax-1 && RenderAcc) {
      accGau.drawGauage(i);
    } else {
      renderingAcc = true;
    }

    //Vel
    if (i < iVelMax-1 && RenderVel) {
      velGau.drawGauage(i);
    } else {
      renderingVel = true;
    }

    //GPS
    if (i < iGPSMax-1 && RenderGPS) {
      GPSGau.drawGauage(i);
    } else {
      renderingGPS = true;
    }

    //Alt
    if (i < iAltMax-1 && RenderAlt) {
      altGau.drawGauage(i);
    } else {
      renderingAlt = true;
    }

    //Gyro
    if (i < iGyrMax-1 && RenderGyr) {
      gyrGau.drawGauage(i);
    } else {
      renderingGyr = true;
    }

    //FFMPEG
    if (renderingVel &&  renderingAcc && renderingGPS && renderingAlt && renderingGyr) {
      myExporter.exportVideo();
      exit();
    }

    //Feedback to user
    background(100);

    fill(0, 255, 0);
    rect(0, 0, map(i, 0, iAccMax+1, 0, width), 10);
    rect(0, 11, map(i, 0, iVelMax+1, 0, width), 10);
    rect(0, 22, map(i, 0, iGyrMax+1, 0, width), 10);

    image(accGraphic, 0, 0, width/2, height/2);
    image(velGraphic, width/2, 0, width/2, height/2);
    image(GPSGraphic, 0, height/2, width/2, height/2);
    image(altGraphic, width/2, height/2, width/2, height/2);
    image(gyrGraphic, width/4, height/4, width/2, height/2);

    fill(255);
    textSize(26);
    float TTG = max(myGoPro.getVelSize() - i, myGoPro.getAccSize() - i, myGoPro.getGyrSize() - i) / frameRate;
    text("Phase 1 || Rendering " + round((frameRate)*10)/10.0 + " fps || TTG: " + round(TTG/6)/10.0 + "min", 20, 33);

    //Itterate
    i++;
  } else if (menu == "Settings") {
    background(100);
    fill(255);
    textSize(16);

    //Feedback to user
    textAlign(LEFT, CENTER);
    text("Acc dat: " + myGoPro.accPath, 50, 400);
    text("GPS dat: " + myGoPro.GPSPath, 50, 420);
    text("Gyr dat: " + myGoPro.gyrPath, 50, 440);
    text("Output: " + myExporter.outputPath, 50, 460);
    text("Acc Len: " + myGoPro.getAccSize(), 50, 480);
    text("GPS Len: " + myGoPro.getGPSSize(), 50, 500);
    text("Vel Len: " + myGoPro.getVelSize(), 50, 520);
    text("Alt Len: " + myGoPro.getAltSize(), 50, 540);
    text("Gyr Len: " + myGoPro.getGyrSize(), 50, 560);
    text("Framerate: " + setFps, 50, 580);

    //controlP5 controll
    Controller render = cp5.getController("StartRender");
    Controller renderGPS = cp5.getController("RenderGPS");
    Controller renderVel = cp5.getController("RenderVel");
    Controller renderAlt = cp5.getController("RenderAlt");
    Controller renderAcc = cp5.getController("RenderAcc");
    Controller renderGyr = cp5.getController("RenderGyr");

    Boolean GPSLoaded = myGoPro.getGPSSize() > 1;
    Boolean AccLoaded = myGoPro.getAccSize() > 1;
    Boolean GyrLoaded = myGoPro.getGyrSize() > 1;
    boolean PathSelected = myExporter.outputPath.length() > 1;
    Boolean OneRender = RenderGPS || RenderVel || RenderAcc || RenderAlt || RenderGyr;

    Boolean notReady = !OneRender || setFps == 0 || !PathSelected;
    renderGPS.setLock(!GPSLoaded);
    renderVel.setLock(!GPSLoaded);
    renderAlt.setLock(!GPSLoaded);
    renderAcc.setLock(!AccLoaded);
    renderGyr.setLock(!GyrLoaded);

    render.setLock(notReady);
    render.setColorForeground((notReady? color(255, 0, 0) : color(0, 255, 0) ));
  }

  textAlign(RIGHT, BOTTOM);
  text("Ver: " + version, width-10, height-10);
}
