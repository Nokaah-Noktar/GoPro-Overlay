# GoPro-Overlay
Creates gauges based on GoPro telemetry

GoPro overlay uses data from ["Telemetry Extractor for GoPro (Lite)"](https://goprotelemetryextractor.com/free/) to create five gauges:
* Velocity
* GPS
* Altitude
* Acceleration
* Attitude indicator

Requires:
* Processing 4
* FFMPEG
* MS Windows

# Usage (Code):
Download the source code. Open it in [Processing 4](https://processing.org/download) and export the application through (File -> export application). You may have to add the library "controlP5" to processing 4 through (Sketch -> import library -> add library).
The program uses FFMPEG to create the gauges, and can be downloaded from [ffmpeg.org](https://ffmpeg.org/download.html).

# Usage (Telemetry Extractor):
Extract telemetry data using ["Telemetry Extractor for GoPro (Lite)"](https://goprotelemetryextractor.com/free/).
* GPS
* Accelerometer
* Gyroscope

* Frequency: Framerate
* Base Time: MP4
* Export as CSV

# Usage (Program):
After exporting the program processing 4 will create a folder containing an executable file. Follow the steps displayed on the screen:
* Import data downloaded from "Telemetry Extractor".
* Select output folder where the gauges will be stored
* Set the framerate based on the video framerate (Gyro won't work with the wrong value)
* Optionally it is possible to select/deselect some gauges
* Start render

The program will first create images of each frame for each gauge. When finished it will call ffmpeg which exports the images into a .mov-file.

# Usage (Gauges):
Each gauge consists of a .mov file. The file has an alpha channel creating transparency which allows the user to place it on top of the original GoPro film. Use a video editing software to add the gauges on top of the original video.

# "Example":
![example](https://github.com/Nokaah-Noktar/GoPro-Overlay/assets/89448975/17e4b91c-6821-4c25-bdfa-7b81e4b49717)

# To-Do:
* Fix velocity gauge
  * Has an offset depending on max-speed
* Altitude graph should be based on distance
  * Currently based on time
* GPS data is a bit boring
