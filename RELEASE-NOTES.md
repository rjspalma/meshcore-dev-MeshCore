# Experimental ESP32 + RFM95W Companion BLE

Unofficial MeshCore build for the classic ESP32-WROOM-32 DevKit and HopeRF RFM95W 868 MHz. Uses the GPIO map in `README-ESP32-RFM95W.md`. Not intended for ESP32-S3/C3, SX126x, or a repeater role.

If attached, `meshcore-esp32-rfm95w-companion-ble-merged.bin` is the **combined** ESP32 image for offset `0x0`. Do not use the application-only `firmware.bin` at `0x0`. The supported source-based route is the PlatformIO upload command in the hardware README. Back up the existing device firmware and settings as needed before changing its flash layout.

Development hardware: SX1276 initialization, BLE connection and LoRa reception observed. Release-candidate test results should be added only after testing the final build. End-to-end TX has not been verified in the development tests. See `BUILD-INFO.txt` and `SHA256SUMS.txt` for the binary's provenance and checksum.
