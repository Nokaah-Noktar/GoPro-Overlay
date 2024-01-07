# GoPro-Overlay
Creates gauages based on GoPro telemetry

GoPro overlay uses data from ["Telemetry Extractor for GoPro (Lite)"](https://goprotelemetryextractor.com/free/) to create five gauages:
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
The program uses FFMPEG to create the gauages, and can be dowloaded from [ffmpeg.org](https://ffmpeg.org/download.html).

# Usage (Telemetry Extracto):
Extract telemetry data using ["Telemetry Extractor for GoPro (Lite)"](https://goprotelemetryextractor.com/free/).
* GPS
* Accelerometer
* Gyroscpoe

* Frequency: Framerate
* Base Time: MP4
* Export as CVS

# Usage (Program)
After exporting the program processing 4 will create a folder containting an executable file. Follow the steps displayed on the scree:
* Import data downloaded from "Telemetry Extaxtor".
* Select output folder where the gauages will be stored
* Set the framerate based on the video framerate (Gyro won't work with wrong value)
* Optionaly it is possible to select/deselect some gauages
* Start render

The program will first create images of each frame for each gauage. When finnished it will call ffmpeg wich exports the images into a .mov-file.

# Usage (Gauages)
Each gauage consists of a .mov file. The file has a alpha channel creating transparrency wich allows the user to place it on top of the original GoPro film. Use a video editing softare to add the gauages on top of the original video.
