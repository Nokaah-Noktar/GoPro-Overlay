

String version = "1.2.0";
//Clean up

int smoothVal = 1;

GoPro myGoPro = new GoPro();

AccGauage accGau = new AccGauage();
VelGauage velGau = new VelGauage();
GPSGauage GPSGau = new GPSGauage();
AltGauage altGau = new AltGauage();
GraGauage graGau = new GraGauage();

GyrGauage gyrGau = new GyrGauage();
float roll = 0;
float pitch = 0;

boolean renderingAcc = false;
boolean renderingVel = false;
boolean renderingGPS = false;
boolean renderingAlt = false;
boolean renderingGyr = false;
boolean renderingGra = false;

PGraphics accGraphic;
PGraphics velGraphic;
PGraphics GPSGraphic;
PGraphics altGraphic;
PGraphics gyrGraphic;
PGraphics graGraphic;

int i = 0;
int iAccMax, iVelMax, iGPSMax, iAltMax, iGyrMax, iGraMax, T0;


exporter myExporter = new exporter();
deleteOldFiles myDeleter = new deleteOldFiles();

PFont velFont;

int setFps = 0;

String[] menues = {"Settings", "Render"};
String menu = menues[0];

String[] gauages = {"Acc", "GPS", "Gra", "Vel", "Alt", "Gyr"};
String showGauage = gauages[0];



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
  graGraphic = createGraphics(width, height, JAVA2D);

  accGraphic.smooth(smoothVal);
  velGraphic.smooth(smoothVal);
  GPSGraphic.smooth(smoothVal);
  altGraphic.smooth(smoothVal);
  gyrGraphic.smooth(smoothVal);
  graGraphic.smooth(smoothVal);
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

    //Gra
    if (i < iGraMax-1 && RenderGra) {
      graGau.drawGauage(i);
    } else {
      renderingGra = true;
    }

    //FFMPEG
    if (renderingVel &&  renderingAcc && renderingGPS && renderingAlt && renderingGyr && renderingGra) {
      myExporter.exportVideo();
      exit();
    }


    //Feedback to user
    background(100);

    fill(0, 255, 0);
    stroke(0);
    strokeWeight(2);
    rect(0, 0, map(i, 0, iAccMax+1, 0, width), 10);
    rect(0, 11, map(i, 0, iVelMax+1, 0, width), 10);
    rect(0, 22, map(i, 0, iGyrMax+1, 0, width), 10);
    rect(0, 33, map(i, 0, iGraMax+1, 0, width), 10);

    fill(0, 0, 0, 100);
    stroke(0);
    strokeWeight(1);
    rect(0, 0, width, 43);

    fill(255);
    textSize(26);
    textAlign(LEFT, BOTTOM);
    float TTG = max(max(myGoPro.getVelSize() - i, myGoPro.getAccSize() - i), max(myGoPro.getGyrSize() - i, myGoPro.getGraSize() - i)) / frameRate;
    text("Phase 1 || Rendering " + round((frameRate)*10)/10.0 + " fps || TTG: " + round(TTG/6)/10.0 + "min", 20, 33);


    switch(showGauage) {
    case "Acc":
      image(accGraphic, 0, 0, width, height);
      break;
    case "Vel":
      image(velGraphic, 0, 0, width, height);
      break;
    case "GPS":
      image(GPSGraphic, 0, 0, width, height);
      break;
    case "Alt":
      image(altGraphic, 0, 0, width, height);
      break;
    case "Gra":
      image(graGraphic, 0, 0, width, height);
      break;
    case "Gyr":
      image(gyrGraphic, 0, 0, width, height);
      break;
    }

    textAlign(LEFT, BOTTOM);
    text("Showing: " + showGauage, 10, height-10);



    //Itterate
    i++;
  } else if (menu == "Settings") {

    //Feedback to user
    background(100);
    fill(255);
    textSize(14);

    int tYOffset = 405;
    int tDist = 16;

    textAlign(LEFT, CENTER);
    text("Acc dat: " + myGoPro.accPath, 50, tYOffset);
    text("GPS dat: " + myGoPro.GPSPath, 50, tDist*1 + tYOffset);
    text("Gyr dat: " + myGoPro.gyrPath, 50, tDist*2 + tYOffset);
    text("Gra dat: " + myGoPro.graPath, 50, tDist*3 + tYOffset);
    text("Output: " + myExporter.outputPath, 50, tDist*4 + tYOffset);
    text("Acc Len: " + myGoPro.getAccSize(), 50, tDist*5 + tYOffset);
    text("GPS Len: " + myGoPro.getGPSSize(), 50, tDist*6 + tYOffset);
    text("Vel Len: " + myGoPro.getVelSize(), 50, tDist*7 + tYOffset);
    text("Alt Len: " + myGoPro.getAltSize(), 50, tDist*8 + tYOffset);
    text("Gyr Len: " + myGoPro.getGyrSize(), 50, tDist*9 + tYOffset);
    text("Gra Len: " + myGoPro.getGraSize(), 50, tDist*10 + tYOffset);
    text("Framerate: " + setFps, 50, tDist*11 + tYOffset);

    //controlP5 controll
    Controller render = cp5.getController("StartRender");
    Controller renderGPS = cp5.getController("RenderGPS");
    Controller renderVel = cp5.getController("RenderVel");
    Controller renderAlt = cp5.getController("RenderAlt");
    Controller renderAcc = cp5.getController("RenderAcc");
    Controller renderGyr = cp5.getController("RenderGyr");
    Controller renderGra = cp5.getController("RenderGra");

    Boolean GPSLoaded = myGoPro.getGPSSize() > 1;
    Boolean AccLoaded = myGoPro.getAccSize() > 1;
    Boolean GyrLoaded = myGoPro.getGyrSize() > 1;
    Boolean GraLoaded = myGoPro.getGraSize() > 1;
    boolean PathSelected = myExporter.outputPath.length() > 1;
    Boolean OneRender = RenderGPS || RenderVel || RenderAcc || RenderAlt || RenderGyr || RenderGra;

    Boolean notReady = !OneRender || setFps == 0 || !PathSelected;
    renderGPS.setLock(!GPSLoaded);
    renderVel.setLock(!GPSLoaded);
    renderAlt.setLock(!GPSLoaded);
    renderAcc.setLock(!AccLoaded);
    renderGyr.setLock(!GyrLoaded);
    renderGra.setLock(!GraLoaded);

    render.setLock(notReady);
    render.setColorForeground((notReady? color(255, 0, 0) : color(0, 255, 0) ));
  }


  textAlign(RIGHT, BOTTOM);
  text("Ver: " + version, width-10, height-10);
}
