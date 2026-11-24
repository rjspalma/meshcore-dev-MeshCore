#pragma once

#include <helpers/ESP32Board.h>

class ESP32RFM95WBoard : public ESP32Board {
public:
    uint32_t getIRQGpio() override { return P_LORA_DIO_0; }
};
