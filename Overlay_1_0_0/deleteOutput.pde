

class deleteOldFiles {
  private
  PrintWriter deleter;

  public
  void deleteFiles() {
    deleter = createWriter("deleteOutput.bat");
    deleter.print("START cmd.exe \"/k rmdir output /s /q & exit");
    deleter.flush();
    deleter.close();

    launch(sketchPath("")+"deleteOutput.bat");
  }
}
