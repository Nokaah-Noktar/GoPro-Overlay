

class exporter {
  private
    PrintWriter accExport;
  PrintWriter velExport;
  PrintWriter GPSExport;
  PrintWriter altExport;
  PrintWriter graExport;

  public

    String outputPath = "";


  void setFramerate(int fps) {
    accExport = createWriter("accExport.bat");
    accExport.print("START cmd.exe \"/k cd ffmpeg\\bin && ffmpeg -framerate " + fps +  " -i ..\\..\\output\\acc%%06d.png -c:v qtrle -pix_fmt argb \"" + outputPath +"\\accOutput.mov\" -y & exit & exit\"");
    accExport.flush();
    accExport.close();

    velExport = createWriter("velExport.bat");
    velExport.print("START cmd.exe \"/k cd ffmpeg\\bin && ffmpeg -framerate " + fps +  " -i ..\\..\\output\\vel%%06d.png -c:v qtrle -pix_fmt argb \"" + outputPath +"\\velOutput.mov\" -y & exit & exit\"");
    velExport.flush();
    velExport.close();

    GPSExport = createWriter("GPSExport.bat");
    GPSExport.print("START cmd.exe \"/k cd ffmpeg\\bin && ffmpeg -framerate " + fps +  " -i ..\\..\\output\\GPS%%06d.png -c:v qtrle -pix_fmt argb \"" + outputPath +"\\GPSOutput.mov\" -y & exit & exit\"");
    GPSExport.flush();
    GPSExport.close();

    altExport = createWriter("altExport.bat");
    altExport.print("START cmd.exe \"/k cd ffmpeg\\bin && ffmpeg -framerate " + fps +  " -i ..\\..\\output\\alt%%06d.png -c:v qtrle -pix_fmt argb \"" + outputPath +"\\altOutput.mov\" -y & exit & exit\"");
    altExport.flush();
    altExport.close();

    altExport = createWriter("gyrExport.bat");
    altExport.print("START cmd.exe \"/k cd ffmpeg\\bin && ffmpeg -framerate " + fps +  " -i ..\\..\\output\\gyr%%06d.png -c:v qtrle -pix_fmt argb \"" + outputPath +"\\gyrOutput.mov\" -y & exit & exit\"");
    altExport.flush();
    altExport.close();

    altExport = createWriter("graExport.bat");
    altExport.print("START cmd.exe \"/k cd ffmpeg\\bin && ffmpeg -framerate " + fps +  " -i ..\\..\\output\\gra%%06d.png -c:v qtrle -pix_fmt argb \"" + outputPath +"\\graOutput.mov\" -y & exit & exit\"");
    altExport.flush();
    altExport.close();
  }

  void exportVideo() {
    if (RenderVel) {
      launch(sketchPath("")+"velExport.bat");
      delay(1000);
    }
    if (RenderAcc) {
      launch(sketchPath("")+"accExport.bat");
      delay(1000);
    }
    if (RenderGPS) {
      launch(sketchPath("")+"GPSExport.bat");
      delay(1000);
    }
    if (RenderAlt) {
      launch(sketchPath("")+"altExport.bat");
      delay(1000);
    }
    if (RenderGyr) {
      launch(sketchPath("")+"gyrExport.bat");
      delay(1000);
    }
    if (RenderGra) {
      launch(sketchPath("")+"graExport.bat");
      delay(1000);
    }
  }
}
