# pyroelectric-pi-esp8266

![](image.jpeg)

# Raspberry-pi side
```
./start-piserver.sh
```
Or explicitly,

```
ruby pi-server.rb -o 0.0.0.0
```
# Espr developer side
upload `human-sensor/human-sensor.ino` to the board

| Parameter | Value |
| ------------- | ------------- |
|Flash Mode	    |QIO|
|Flash Frequency	 |40MHz|
|CPU Frequency	|80MHz|
|Flash Size	|4M(3M SPIFFS)|
|Reset Method	|nodemcu|
|Upload Speed	|115200|

