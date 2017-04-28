int pinnum = 12;

void setup(){
  pinMode(pinnum,INPUT);
  Serial.begin(115200);
}

void loop() {
  int val = digitalRead(pinnum);
  Serial.println(val);
  delay(100);
}
