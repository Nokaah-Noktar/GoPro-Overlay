

import controlP5.*;
ControlP5 cp5;

boolean RenderGPS = false;
boolean RenderVel = false;
boolean RenderAlt = false;
boolean RenderAcc = false;
boolean RenderGyr = false;
boolean RenderGra = false;


void makeGUI() {
  PFont font = createFont("arial", 30);
  PFont samllFont = createFont("arial", 14);
  textFont(font);
  textAlign(LEFT, TOP);
  cp5 = new ControlP5(this);

  int bDist = 45;
  int yOffset = 25;

  //Settings

  cp5.addBang("SelectAccelerationData")
    .setPosition(50, yOffset)
    .setSize(500, 40)
    .setFont(font)
    .setCaptionLabel("Select acceleration data")
    .setTriggerEvent(Bang.RELEASE)
    .getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER)
    ;

  cp5.addBang("SelectGPSData")
    .setPosition(50, bDist*1 + yOffset)
    .setSize(500, 40)
    .setFont(font)
    .setCaptionLabel("Select GPS data")
    .setTriggerEvent(Bang.RELEASE)
    .getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER)
    ;

  cp5.addBang("SelectGyrData")
    .setPosition(50, bDist*2 + yOffset)
    .setSize(500, 40)
    .setFont(font)
    .setCaptionLabel("Select gyro data")
    .setTriggerEvent(Bang.RELEASE)
    .getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER)
    ;

  cp5.addBang("SelectGraData")
    .setPosition(50, bDist*3 + yOffset)
    .setSize(500, 40)
    .setFont(font)
    .setCaptionLabel("Select gravity vector data")
    .setTriggerEvent(Bang.RELEASE)
    .getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER)
    ;

  cp5.addTextfield("VideoFramerate")
    .setPosition(50, bDist*4 + yOffset)
    .setSize(100, 40)
    .setFont(font)
    .setCaptionLabel("")
    .setFocus(true)
    .setColor(color(255, 255, 255))
    ;

  cp5.addBang("SetFramerate")
    .setPosition(50 + 100 + 10, bDist*4 + yOffset)
    .setSize(390, 40)
    .setFont(font)
    .setCaptionLabel("Set framerate")
    .setTriggerEvent(Bang.RELEASE)
    .getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER)
    ;


  cp5.addBang("SelectOutputFolder")
    .setPosition(50, bDist*5 + yOffset)
    .setSize(500, 40)
    .setFont(font)
    .setCaptionLabel("Select output folder")
    .setTriggerEvent(Bang.RELEASE)
    .getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER)
    ;

  cp5.addToggle("RenderGPS")
    .setPosition(50, 300)
    .setCaptionLabel("GPS")
    .setSize(120, 20)
    .setValue(false)
    .getCaptionLabel().setFont(samllFont).align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addToggle("RenderVel")
    .setPosition(175, 300)
    .setCaptionLabel("Velocity")
    .setSize(120, 20)
    .setValue(false)
    .getCaptionLabel().setFont(samllFont).align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addToggle("RenderAcc")
    .setPosition(300, 300)
    .setCaptionLabel("Acceleration")
    .setSize(120, 20)
    .setValue(false)
    .getCaptionLabel().setFont(samllFont).align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addToggle("RenderAlt")
    .setPosition(425, 300)
    .setCaptionLabel("Altitude")
    .setSize(120, 20)
    .setValue(false)
    .getCaptionLabel().setFont(samllFont).align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addToggle("RenderGyr")
    .setPosition(50, 325)
    .setCaptionLabel("Gyroscope")
    .setSize(120, 20)
    .setValue(false)
    .getCaptionLabel().setFont(samllFont).align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addToggle("RenderGra")
    .setPosition(175, 325)
    .setCaptionLabel("Gra. vect.")
    .setSize(120, 20)
    .setValue(false)
    .getCaptionLabel().setFont(samllFont).align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addBang("StartRender")
    .setPosition(50, 350)
    .setSize(500, 40)
    .setFont(font)
    .setCaptionLabel("Start render")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;



  //Rendering

  int showOffset = 50;

  cp5.addBang("ShowAcc")
    .setSize(100, 20)
    .setPosition(2, 2 + showOffset)
    .setVisible(false)
    .setFont(samllFont)
    .setCaptionLabel("Accel")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addBang("ShowGPS")
    .setSize(100, 20)
    .setPosition(2, 24 + showOffset)
    .setVisible(false)
    .setFont(samllFont)
    .setCaptionLabel("GPS")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addBang("ShowGra")
    .setSize(100, 20)
    .setPosition(2, 46 + showOffset)
    .setVisible(false)
    .setFont(samllFont)
    .setCaptionLabel("Gravity")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addBang("ShowGyr")
    .setSize(100, 20)
    .setPosition(2, 68 + showOffset)
    .setVisible(false)
    .setFont(samllFont)
    .setCaptionLabel("Gyro")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addBang("ShowVel")
    .setSize(100, 20)
    .setPosition(2, 90 + showOffset)
    .setVisible(false)
    .setFont(samllFont)
    .setCaptionLabel("Velocity")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addBang("ShowAlt")
    .setSize(100, 20)
    .setPosition(2, 112 + showOffset)
    .setVisible(false)
    .setFont(samllFont)
    .setCaptionLabel("Altitude")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;
}



public void SelectOutputFolder() {
  selectFolder("Select output folder", "CheckOutputPath");
}

public void SelectAccelerationData() {
  selectInput("Select acceleration data (.cvs)", "CheckAccPath");
}

public void SelectGPSData() {
  selectInput("Select GPS data (.cvs)", "CheckGPSPath");
}

public void SelectGyrData() {
  selectInput("Select gyro data (.cvs)", "CheckGyrPath");
}

public void SelectGraData() {
  selectInput("Select gravity vector data (.cvs)", "CheckGraPath");
}



void CheckOutputPath(File selection) {
  if (selection != null)
    myExporter.outputPath = selection.getAbsolutePath();
}



void CheckAccPath(File selection) {
  Boolean AccLoaded = false;

  if (selection != null) {
    myGoPro.accPath = selection.getAbsolutePath();
    myGoPro.loadAccData();
    AccLoaded = myGoPro.getAccSize() > 1;
    iAccMax = myGoPro.getAccSize();
    if (AccLoaded) {
      accGau.setScale(myGoPro.getAccXYZ(1), myGoPro.getAccXYZ(2), myGoPro.getAccXYZ(3));
      accGau.setSize(100, 100, 100);
    }
  }
  Controller renderAcc = cp5.getController("RenderAcc");
  renderAcc.setValue(int(AccLoaded));
}

void CheckGPSPath(File selection) {
  Boolean GPSLoaded = false;

  if (selection != null) {
    myGoPro.GPSPath = selection.getAbsolutePath();

    myGoPro.loadGPSData();
    GPSLoaded = myGoPro.getGPSSize() > 1;
    iAltMax = myGoPro.getGPSSize();

    if (GPSLoaded) {
      velGau.setScale(myGoPro.velData);
      velGau.setSize(100, 0, PI);
      iVelMax = myGoPro.getVelSize();

      GPSGau.setScale(myGoPro.GPSLatData, myGoPro.GPSLonData);
      GPSGau.setSize(100, 100);
      iGPSMax = myGoPro.getGPSSize();

      altGau.setScale(myGoPro.GPSAltData);
      altGau.setSize(200, 100);
    }
  }

  Controller renderGPS = cp5.getController("RenderGPS");
  Controller renderVel = cp5.getController("RenderVel");
  Controller renderAlt = cp5.getController("RenderAlt");
  renderGPS.setValue(int(GPSLoaded));
  renderVel.setValue(int(GPSLoaded));
  renderAlt.setValue(int(GPSLoaded));
}

void CheckGyrPath(File selection) {
  Boolean GyrLoaded = myGoPro.getGyrSize() > 1;
  if (selection != null) {
    myGoPro.gyrPath = selection.getAbsolutePath();
    myGoPro.loadGyrData();
    iGyrMax = myGoPro.getGyrSize();
    GyrLoaded = myGoPro.getGyrSize() > 1;
    if (GyrLoaded) {
      gyrGau.setScale(myGoPro.gyrXData, myGoPro.gyrYData, myGoPro.gyrZData);
      gyrGau.setSize(100, 100, 100);
    }
  }
  Controller renderGyr = cp5.getController("RenderGyr");
  renderGyr.setValue(int(GyrLoaded));
}

void CheckGraPath(File selection) {
  Boolean GraLoaded = myGoPro.getGraSize() > 1;
  if (selection != null) {
    myGoPro.graPath = selection.getAbsolutePath();
    myGoPro.loadGraData();
    iGraMax = myGoPro.getGraSize();
    GraLoaded = myGoPro.getGraSize() > 1;
    if (GraLoaded) {
      graGau.setSize(100, 100, 100);
    }
  }
  Controller renderGra = cp5.getController("RenderGra");
  renderGra.setValue(int(GraLoaded));
}


public void SetFramerate() {
  try {
    setFps = Integer.parseInt(cp5.get(Textfield.class, "VideoFramerate").getText());
  }
  catch(Exception e) {
  }
}



void ShowAcc() {
  showGauage = gauages[0];
}

void ShowGPS() {
  showGauage = gauages[1];
}

void ShowGra() {
  showGauage = gauages[2];
}

void ShowVel() {
  showGauage = gauages[3];
}

void ShowAlt() {
  showGauage = gauages[4];
}

void ShowGyr() {
  showGauage = gauages[5];
}



public void StartRender() {
  menu = menues[1];
  frameRate(999);

  cp5.get(Bang.class, "SelectAccelerationData").hide();
  cp5.get(Bang.class, "SelectGPSData").hide();
  cp5.get(Bang.class, "SelectGyrData").hide();
  cp5.get(Bang.class, "SelectGraData").hide();
  cp5.get(Bang.class, "SelectOutputFolder").hide();

  cp5.get(Textfield.class, "VideoFramerate").hide();
  cp5.get(Bang.class, "SetFramerate").hide();
  cp5.get(Bang.class, "StartRender").hide();

  cp5.get(Toggle.class, "RenderGPS").hide();
  cp5.get(Toggle.class, "RenderAcc").hide();
  cp5.get(Toggle.class, "RenderVel").hide();
  cp5.get(Toggle.class, "RenderAlt").hide();
  cp5.get(Toggle.class, "RenderGyr").hide();
  cp5.get(Toggle.class, "RenderGra").hide();

  cp5.get(Bang.class, "ShowAcc").show().setLock(!RenderAcc);
  cp5.get(Bang.class, "ShowGPS").show().setLock(!RenderGPS);
  cp5.get(Bang.class, "ShowGra").show().setLock(!RenderGra);
  cp5.get(Bang.class, "ShowVel").show().setLock(!RenderVel);
  cp5.get(Bang.class, "ShowAlt").show().setLock(!RenderAlt);
  cp5.get(Bang.class, "ShowGyr").show().setLock(!RenderGyr);

  myExporter.setFramerate(setFps);

  T0 = millis();
}
