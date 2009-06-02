#include <OneWire.h>
OneWire  ds(10);  // data pin

void setup(void) {
  Serial.begin(9600);
}

void loop(void) {
  byte addr[8];

  if ( !ds.search(addr)) {
    Serial.print("\n");
    ds.reset_search();
    delay(100);
  } 
  else {
    for(int i = 0; i < 8; i++) {
      Serial.print(addr[i], HEX);
      Serial.print(" ");
    }
    if (OneWire::crc8(addr, 7) != addr[7]) {
      Serial.print("crc error");  // downstream looks for /error/
    } 
    else {
      print_temp(addr);
    }
  }
}

void print_temp(byte* addr) {
  byte data[12];

  ds.reset();
  ds.select(addr);
  ds.write(0x44,1);         // start conversion, with parasite power on at the end
  delay(100);     // maybe 750ms is enough, maybe not
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
