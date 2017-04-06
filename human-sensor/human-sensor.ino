#include <ESP8266WiFi.h>

const char* ssid     = "NU-SFC-2.4GHz";
const char* password = "tanakalab";

const char* host = "192.168.100.9";
const char* streamId   = "123";
const char* privateKey = "0000";

extern "C" {
  #include "user_interface.h"
}

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

int value = 0;

void loop() {
  delay(5000);
  ++value;

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
  String url = "/hello/shohei";
  url += streamId;
  url += "?private_key=";
  url += privateKey;
  url += "&value=";
  url += value;
  
  Serial.print("Requesting URL: ");
  Serial.println(url);

  int value = system_adc_read();
  String data = "voltage=" + String(value);

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
