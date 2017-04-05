extern "C" {
  #include "user_interface.h"
}

void setup() {
  Serial.begin(115200);
}

void loop() {
  int value = system_adc_read();
  Serial.println("Value: " + String(value));
  delay(1000);
}
