/*
Home Energy Usage Monitor

Uses 1-wire temperature probes to monitor return temperature for each zone of the house.

Monitors the boiler coming on by either a microphone or detecting the voltage to the burner.

Reporting is via an attached LCD and pachube.com
*/

#include <OneWire.h>

//Change settings below to customize:

// How maany heating zones of temperature sensors to monitor
int zones = 5;

// What are the nice names of the zones
char* zoneNames[] = {
  "Bedrooms",
  "Living",
  "Office",
  "Basement",
  "Outside"
};

// What pin are the 1-wire sensors connected to?
OneWire ds(9);

// If you want the temperatures in C set this to true, otherwise leave it false
int metric = false;

// If using parasite power this needs to be about 750, otherwise can be 50
int readWait = 50;

// Set up a sanity check on pin 13
int ledPin = 13;

void setup () {
  Serial.begin(9600);
  pinMode( ledPin, OUTPUT);
}

void loop () {
  oneWireRead();
  delay(4000);
  digitalWrite(ledPin, HIGH);
  delay(1000);
  digitalWrite(ledPin, LOW);
}

// The subroutines that do all the work

// Read the one-wire sensors and get the temperatures in F
void oneWireRead () {
  byte addr[8];
  if ( !ds.search(addr)) {
    ds.reset_search();
    delay(readWait);
  } else {
    for(int i = 0; i < 8; i++) {
      Serial.print(addr[i], HEX);
      Serial.print(" ");
    }
      
      if (OneWire::crc8(addr, 7) != addr[7]) {
        Serial.print("crc error"); // Error situation
  } else {
    byte data[12];

    ds.reset();
    ds.select(addr);
    ds.write(0x44,1);         // start conversion, with parasite power on at the end
    delay(readWait);     // maybe 750ms is enough, maybe not
    // we might do a ds.depower() here, but the reset will take care of it.

    byte present = ds.reset();
    Serial.print("\tP=");
    Serial.print(present,HEX);
    Serial.print("\t");

    ds.select(addr);
    ds.write(0xBE);         // Read Scratchpad
    for (int i = 0; i < 9; i++) {
      data[i] = ds.read();
      Serial.print(data[i], HEX);
      Serial.print(" ");
    }
  
    float ftemp = data[1]*256+data[0];
    int temp = ftemp * 0.5 * 9 / 5 + 32;
    Serial.print("\t");
    Serial.print("Temp=");
    Serial.print(temp);
    Serial.print(" F\n");
    }
  }
}

void writeLCD () {
  
}
