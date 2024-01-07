

class GoPro {
  private
  Table accTable;
  Table GPSTable;
  Table gyrTable;

  float[] getTime (String date) {
    date = date.substring(0, date.length() - 1);
    String dateTime[] = date.split("T");
    String time[] = dateTime[1].split(":");
    float fin[] = {Float.parseFloat(time[0]), Float.parseFloat(time[1]), Float.parseFloat(time[2])};
    return(fin);
  }

  float hmsToMillis(float hms[]) {
    float mill = 0;
    mill += hms[0]*60*60*1000;
    mill += hms[1]*60*1000;
    mill += hms[2]*1000;
    return(mill);
  }


  public
  FloatList accData = new FloatList();
  FloatList GPSLonData = new FloatList();
  FloatList GPSLatData = new FloatList();
  FloatList GPSAltData = new FloatList();
  FloatList velData = new FloatList();
  FloatList gyrXData = new FloatList();
  FloatList gyrYData = new FloatList();
  FloatList gyrZData = new FloatList();

  String accPath = "";
  String GPSPath = "";
  String gyrPath = "";


  //Acceleration
  void loadAccData() {
    accTable = loadTable(accPath, "header");
    accData.clear();

    boolean first = true;
    float accT0 = 0;

    //println(accTable.getColumnTitle(2), accTable.getColumnTitle(2).equals("Accelerometer [m/s2]"));

    if (accTable.getColumnTitle(2).equals("Accelerometer [m/s2]")) {
      for (TableRow row : accTable.rows()) {
        float t = hmsToMillis( getTime( row.getString("date") ));
        if (first) {
          accT0 = t;
          first = false;
        }
        t -= accT0;
        float x = Float.parseFloat( row.getString("1") );
        float y = Float.parseFloat( row.getString("2") );
        float z = Float.parseFloat( row.getString("Accelerometer [m/s2]") );

        accData.append(t);
        accData.append(x);
        accData.append(y);
        accData.append(z);
      }
    }
  }

  //GPS
  void loadGPSData() {
    GPSTable = loadTable(GPSPath, "header");

    GPSLonData.clear();
    GPSLatData.clear();
    GPSAltData.clear();
    velData.clear();

    if (GPSTable.getColumnTitle(2).equals("GPS (Lat.) [deg]")) {
      for (TableRow row : GPSTable.rows()) {

        //float cts = Float.parseFloat( row.getString("cts") );
        float lat = Float.parseFloat( row.getString("GPS (Lat.) [deg]") );
        float lon = Float.parseFloat( row.getString("GPS (Long.) [deg]") );
        float alt = Float.parseFloat( row.getString("GPS (Alt.) [m]") );
        float vel = Float.parseFloat( row.getString("GPS (3D speed) [m/s]") );

        //GPSData.append(cts);
        GPSLatData.append(lat);
        GPSLonData.append(lon);
        GPSAltData.append(alt);

        velData.append(vel);
      }
    }
  }


  //Gyro
  void loadGyrData() {
    gyrTable = loadTable(gyrPath, "header");

    gyrXData.clear();
    gyrYData.clear();
    gyrZData.clear();

    if (gyrTable.getColumnTitle(2).equals("Gyroscope [rad/s]")) {
      for (TableRow row : gyrTable.rows()) {
        float z = Float.parseFloat( row.getString("Gyroscope [rad/s]") );
        float x = Float.parseFloat( row.getString("1") );
        float y = Float.parseFloat( row.getString("2") );

        gyrXData.append(x);
        gyrYData.append(y);
        gyrZData.append(z);
      }
    }
  }




  float[] getAccFromIndex(int idx) {
    idx *= 4;
    float ret[] = {accData.get(idx), accData.get(idx+1), accData.get(idx+2), accData.get(idx+3)};
    return(ret);
  }

  float getVelFromIndex(int idx) {
    return(velData.get(idx));
  }

  float[] getGPSFromIndex(int idx) {
    float ret[] = {GPSLonData.get(idx), GPSLatData.get(idx), GPSAltData.get(idx)};
    return(ret);
  }

  float getAltFromIndex(int idx) {
    float ret = GPSAltData.get(idx);
    return(ret);
  }

  float[] getGyrFromIndex(int idx) {
    float[] ret = {gyrXData.get(idx), gyrYData.get(idx), gyrZData.get(idx)};
    return(ret);
  }

  int getAccSize() {
    int len = (accData.size())/4;
    return(len);
  }

  int getVelSize() {
    return(velData.size());
  }

  int getGPSSize() {
    int len = GPSLatData.size();
    return(len);
  }

  int getAltSize() {
    int len = GPSAltData.size();
    return(len);
  }

  int getGyrSize() {
    int len = gyrXData.size();
    return(len);
  }

  FloatList getAccXYZ(int ofset) {
    FloatList set = new FloatList();
    for (int i = 0; i < accData.size(); i+=4) {
      set.append(accData.get(i + ofset));
    }
    return(set);
  }
}
