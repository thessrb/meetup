

void setup()
{
  //initialize pin 13 to output mode
  //pin 13 is connected to a led on the Uno
  pinMode(13,OUTPUT);
  //initialize the serial monitor
  Serial.begin(9600);
  //and give something out
  Serial.println("Setup complete");
}

void loop()
{
  //apply 5V to pin 13, so turn on the led
  digitalWrite(13,HIGH);
  Serial.println("On");
  //wait a second
  delay(1000);
  //turn it off
  digitalWrite(13,LOW);
  Serial.println("Off");
  delay(1000);
}
