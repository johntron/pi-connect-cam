# Pi Connect Cam

Add an extra camera to Prusa Connect using a Pi + Cam.

## How it works

It installs a systemd service that just captures an image from a connected camera (using libcamera-jpeg) and sends it to Prusa Connect for viewing in the web UI.

It just pipes the output of libcamera-jpeg to a curl command. The curl sends the image to Prusa's Connect API; see [connect-cam.sh.template](./connect-cam.sh.template).

## Prerequisites

* Pi device (tested using Pi Zero W)
* Camera (tested using Pi Cam v2.1)
* Prusa Connect token - login, "Add new other camera", copy token
* Fingerprint for your camera - I captured from Chrome using remote debugging and my phone, but you can try following the [OpenAPI docs for fingerprint](https://connect.prusa3d.com/docs/cameras/openapi/#tag/camera/paths/~1c~1snapshot/put): 16 to 64 characters (inclusive)


## Installation

1. Connect the camera to the Pi
2. Flash Pi OS to your SD card - it's useful to configure WiFi and SSH at this point using Pi Imager.
3. Insert SD card and ensure the device connects to your network
4. Connect to the device via SSH
5. Download this codebase using [the link from the release page](https://github.com/johntron/pi-connect-cam/releases/latest). e.g. `curl -OL https://api.github.com/repos/johntron/pi-connect-cam/tarball/main`
6. Extract: `tar -xzf johntron-pi-connect-cam*.tar.gz`
7. Make executable: `chmod u+x install.sh`
7. Run the install script: `sudo ./install.sh`


## Troubleshooting

It's a pretty simple thing - take a look at connect-cam.sh.template, connect-cam.service.template, and install.sh. There's also reference links below.

## Reference

* [Pi camera software](https://www.raspberrypi.com/documentation/computers/camera_software.html#getting-started)
* [Prusa Connect API docs](https://connect.prusa3d.com/docs/cameras/camera_communication/#sending-images-and-updating-attributes-of-given-camera)
* [Prusa Connect OpenAPI spec](https://connect.prusa3d.com/docs/cameras/openapi/#tag/cameras/paths/~1app~1printers~1%7Bprinter_uuid%7D~1camera/post)