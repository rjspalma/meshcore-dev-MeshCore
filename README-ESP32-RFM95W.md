# DIY MeshCore Companion BLE: ESP32 + HopeRF RFM95W

An unofficial, headless MeshCore Companion BLE target for a classic ESP32-WROOM-32 DevKit and a HopeRF RFM95W 868 MHz (SX1276 family). No screen, GPS or external sensors are required. This is a Companion, not a repeater.

## Hardware and wiring

Use the radio signal names below; verify the pad numbering and orientation against the documentation for your exact module or breakout before soldering. ESP32 numbers are GPIOs, not header positions.

| RFM95W signal | ESP32 DevKit |
| --- | --- |
| 3.3 V | 3V3 |
| GND | GND |
| SCK | GPIO18 |
| MISO | GPIO19 |
| MOSI | GPIO23 |
| NSS / CS | GPIO5 |
| RESET | GPIO14 |
| DIO0 | GPIO26 |
| DIO1 | GPIO33 |

Use 3.3 V power and logic, common ground and short wires. Keep the ESP32 PCB antenna area clear of wiring and metal. Fit a suitable LoRa antenna before running firmware that can transmit. Use a preset and TX power appropriate to your local network and regulations; the build power setting is not a compliance determination.

## Build and flash from source

Run from the root of this MeshCore fork using PlatformIO Core. The target uses Arduino through PlatformIO, not Arduino IDE. Start with the base commit recorded in `UPSTREAM-COMMIT.txt`.

```sh
pio run -e esp32_rfm95w_companion_radio_ble
```

Close the serial monitor before uploading. Replace `/dev/ttyUSB0` if needed. Reflashing can overwrite the existing application and change its partition layout; back up anything on the device you need first.

```sh
pio run -e esp32_rfm95w_companion_radio_ble -t upload --upload-port /dev/ttyUSB0
pio device monitor -e esp32_rfm95w_companion_radio_ble --port /dev/ttyUSB0 --baud 115200
```

Connect from the MeshCore mobile app over BLE. The build's initial pairing PIN is `123456`; it is public, not a secret. Change the device PIN where supported. Select the local radio preset in the app rather than assuming a universal 868 MHz preset.

## Validation status

The development build on the original hardware initialized the SX1276 and connected to the MeshCore app over BLE. Incoming LoRa traffic was observed. End-to-end TX/acknowledgement was not verified. This clean build compiled successfully with PlatformIO but has not been flashed or hardware-tested. Recheck BLE and RX on the clean build, and report TX separately if tested.

## Credits and licensing

Based on the [upstream MeshCore project](https://github.com/meshcore-dev/MeshCore). Retain the fork's original `license.txt` and copyright notice. Review all included dependencies and the notices and redistribution terms applicable to any binary before releasing it. This is not an official MeshCore firmware build.
