#include <ESP8266WiFi.h>

const char* ssid     = "****";
const char* password = "****";

const char* host = "192.168.1.106";//RPi
const char* streamId   = "123";
const char* privateKey = "0000";

void setup() {
  Serial.begin(115200);
  delay(10);
  Serial.println();
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi connected");  
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
}

int value;
int dpin = 12;
int number = 1;

void loop() {
  delay(2000);

  Serial.print("connecting to ");
  Serial.println(host);
  
  // Use WiFiClient class to create TCP connections
  WiFiClient client;
  const int httpPort = 4567;
  if (!client.connect(host, httpPort)) {
    Serial.println("connection failed");
    return;
  }
  
  // We now create a URI for the request
  String url = "/sensor/raw_data";

  Serial.print("Requesting URL: ");
  Serial.println(url);

  int value = digitalRead(dpin);
  String data = "voltage=" + String(value) + "&number=" + String(number);

  Serial.print("Requesting POST: ");
  // Send request to the server:
  client.println(String("POST ")+ url + " HTTP/1.1");
  client.println(String("Host: ") + host);
  client.println("Accept: */*");
  client.println("Content-Type: application/x-www-form-urlencoded");
  client.print("Content-Length: ");
  client.println(data.length());
  client.println();
  client.print(data);
  // This will send the request to the server
  // client.print(String("GET ") + url + " HTTP/1.1\r\n" +
  //              "Host: " + host + "\r\n" + 
  //              "Connection: close\r\n\r\n");
  unsigned long timeout = millis();
  while (client.available() == 0) {
    if (millis() - timeout > 5000) {
      Serial.println(">>> Client Timeout !");
      client.stop();
      return;
    }
  }
  
  // Read all the lines of the reply from server and print them to Serial
  while(client.available()){
    String line = client.readStringUntil('\r');
    Serial.print(line);
  }
  
  Serial.println();
  Serial.println("closing connection");
}
