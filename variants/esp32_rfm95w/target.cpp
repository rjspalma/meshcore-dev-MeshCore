#include <Arduino.h>
#include "target.h"

ESP32RFM95WBoard board;
static SPIClass spi;
RADIO_CLASS radio = new Module(
    P_LORA_NSS, P_LORA_DIO_0, P_LORA_RESET, P_LORA_DIO_1, spi
);
WRAPPER_CLASS radio_driver(radio, board);
ESP32RTCClock fallback_clock;
AutoDiscoverRTCClock rtc_clock(fallback_clock);
SensorManager sensors;

bool radio_init() {
    fallback_clock.begin();
    rtc_clock.begin(Wire);

    pinMode(P_LORA_RESET, OUTPUT);
    digitalWrite(P_LORA_RESET, HIGH);
    delay(10);
    digitalWrite(P_LORA_RESET, LOW);
    delay(2);
    digitalWrite(P_LORA_RESET, HIGH);
    delay(10);

    return radio.std_init(&spi);
}

mesh::LocalIdentity radio_new_identity() {
    RadioNoiseListener rng(radio);
    return mesh::LocalIdentity(&rng);
}
