# GoPro-Overlay
Creates gauges based on GoPro telemetry. Made with [Processing 4](https://processing.org/download)

GoPro overlay uses data from ["Telemetry Extractor for GoPro (Lite)"](https://goprotelemetryextractor.com/free/) to create five gauges:
* Velocity
* GPS
* Altitude
* Acceleration
* Attitude indicator
  * Based on Gravity vector or gyroscope

Requires:
* ~~Processing 4~~
* ~~ffmpeg~~
* MS Windows

----

# Usage (Telemetry Extractor):
Extract telemetry data using ["Telemetry Extractor for GoPro (Lite)"](https://goprotelemetryextractor.com/free/).
* GPS
* Accelerometer
* Gyroscope
* Gravity vector
* - *
* Frequency: Framerate
* Base Time: MP4
* Export as CSV

# Usage (Program):
* Run Overlay_#_#_#.exe
* Import data downloaded from "Telemetry Extractor".
* Select output folder where the gauges will be stored
* Set the framerate based on the video framerate <ins>(Required by the Attitude indicator based on gyro-data)</ins>
* Optionally it is possible to select/deselect some gauges
* Start render

The program will first create images of each frame for each gauge. When finished it will call ffmpeg which exports the images into a .mov-file.

# Usage (Gauges):
Each gauge consists of a .mov file. The file has an alpha channel creating transparency which allows the user to place it on top of the original GoPro film. Use a video editing software to add the gauges on top of the original video.

----

# "Example":
![example](https://github.com/Nokaah-Noktar/GoPro-Overlay/assets/89448975/17e4b91c-6821-4c25-bdfa-7b81e4b49717)

----

# Usage (Soure code):
The source code can be found in the folder named Source.
Open it in [Processing 4](https://processing.org/download), edit it as wanted and export the application through (File -> export application). You may have to add the library "controlP5" to processing 4 through (Sketch -> import library -> add library).
The program uses FFMPEG to create the gauges: Please [download the full version of ffmpeg](https://www.gyan.dev/ffmpeg/builds/#release-builds), extract and rename fhe folder to "ffmpeg" and place the ffmpeg folder together with the executable file after exporting from processing or <ins> use the ffmpeg folder provided </ins>

--

# To-Do:
* ~~Fix velocity gauge~~
  * ~~Has an offset depending on max-speed~~
* ~~Gyroscope builds up error over time~~
  * ~~Can now use gravity vector to indicate attitude~~
* Acceleration value should maybe be based on a logarithmic scale
* Altitude graph should be based on distance
  * Currently based on time
* GPS data is a bit boring
* Linux / MAC?
  * Currently using command promt and batch files to run ffmpgeg...
  * Processing 4 can nativly export to linux and linux raspberry
* Sign the exe-file
