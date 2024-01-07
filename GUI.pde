

import controlP5.*;
ControlP5 cp5;

boolean RenderGPS = false;
boolean RenderVel = false;
boolean RenderAlt = false;
boolean RenderAcc = false;
boolean RenderGyr = false;


void makeGUI() {
  PFont font = createFont("arial", 30);
  PFont samllFont = createFont("arial", 14);
  textFont(font);
  textAlign(LEFT, TOP);
  cp5 = new ControlP5(this);

  cp5.addBang("SelectAccelerationData")
    .setPosition(50, 50)
    .setSize(500, 40)
    .setFont(font)
    .setCaptionLabel("1) Select acceleration data")
    .getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER)
    ;

  cp5.addBang("SelectGPSData")
    .setPosition(50, 100)
    .setSize(500, 40)
    .setFont(font)
    .setCaptionLabel("2) Select GPS data")
    .getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER)
    ;

  cp5.addBang("SelectGyrData")
    .setPosition(50, 150)
    .setSize(500, 40)
    .setFont(font)
    .setCaptionLabel("3) Select gyro data")
    .getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER)
    ;

  cp5.addTextfield("VideoFramerate")
    .setPosition(50, 250)
    .setSize(100, 40)
    .setFont(font)
    .setCaptionLabel("")
    .setFocus(true)
    .setColor(color(255, 255, 255))
    ;

  cp5.addBang("SetFramerate")
    .setPosition(50 + 100 + 10, 250)
    .setSize(390, 40)
    .setFont(font)
    .setCaptionLabel("5) Set framerate")
    .getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER)
    ;

  cp5.addBang("SelectOutputFolder")
    .setPosition(50, 200)
    .setSize(500, 40)
    .setFont(font)
    .setCaptionLabel("4) Select output folder")
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

  cp5.addBang("StartRender")
    .setPosition(50, 350)
    .setSize(500, 40)
    .setFont(font)
    .setCaptionLabel("6) Start render")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;
}

public void SelectOutputFolder() {
  delay(250);
  selectFolder("Select output folder", "CheckOutputPath");
}

public void SelectAccelerationData() {
  delay(100);
  selectInput("Select acceleration data (.cvs)", "CheckAccPath");
}

public void SelectGPSData() {
  delay(100);
  selectInput("Select GPS data (.cvs)", "CheckGPSPath");
}

public void SelectGyrData() {
  delay(100);
  selectInput("Select gyro data (.cvs)", "CheckGyrPath");
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


public void SetFramerate() {
  try {
    setFps = Integer.parseInt(cp5.get(Textfield.class, "VideoFramerate").getText());
    myExporter.setFramerate(setFps);
  }
  catch(Exception e) {
  }
}

public void StartRender() {
  menu = menues[1];
  frameRate(999);

  cp5.get(Bang.class, "SelectAccelerationData").hide();
  cp5.get(Bang.class, "SelectGPSData").hide();
  cp5.get(Bang.class, "SelectGyrData").hide();
  cp5.get(Bang.class, "SelectOutputFolder").hide();

  cp5.get(Textfield.class, "VideoFramerate").hide();
  cp5.get(Bang.class, "SetFramerate").hide();
  cp5.get(Bang.class, "StartRender").hide();

  cp5.get(Toggle.class, "RenderGPS").hide();
  cp5.get(Toggle.class, "RenderAcc").hide();
  cp5.get(Toggle.class, "RenderVel").hide();
  cp5.get(Toggle.class, "RenderAlt").hide();
  cp5.get(Toggle.class, "RenderGyr").hide();

  T0 = millis();
}
