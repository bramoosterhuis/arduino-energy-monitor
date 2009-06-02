void setup() {
Serial.begin(9600);
Serial.flush();
}

void loop() {
  clearLCD();
  selectLineOne();
  Serial.print("Line One");
  selectLineTwo();
  Serial.print("Line Two");
  selectLineThree();
  Serial.print("Line Three");
  selectLineFour();
  Serial.print("Line Four");
  
  goTo(19);
  delay(100);
  Serial.print("*");
  goTo(39);
  delay(100);
  Serial.print("*");
  goTo(59);
  delay(100);
  Serial.print("*");
  goTo(79);
  delay(100);
  Serial.print("*");
  
  goTo(10);
  delay(50);
  Serial.print("Mikee");
  
  delay(500);
}

void selectLineOne(){  //puts the cursor at line 0 char 0.
   Serial.print(0xFE, BYTE);   //command flag
   Serial.print(128, BYTE);    //position
}
void selectLineTwo(){  //puts the cursor at line 2 char 0.
   Serial.print(0xFE, BYTE);   //command flag
   Serial.print(192, BYTE);    //position
}
void selectLineThree(){  //puts the cursor at line 3 char 0.
   Serial.print(0xFE, BYTE);   //command flag
   Serial.print(148, BYTE);    //position
}
void selectLineFour(){  //puts the cursor at line 4 char 0.
   Serial.print(0xFE, BYTE);   //command flag
   Serial.print(212, BYTE);    //position
}

void goTo(int position) { //position = line 1: 0-19, line 2: 20-39, etc, 79+ defaults back to 0
if (position<20){ Serial.print(0xFE, BYTE);   //command flag
              Serial.print((position+128), BYTE);    //position
}else if (position<40){Serial.print(0xFE, BYTE);   //command flag
              Serial.print((position+128+64-20), BYTE);    //position 
}else if (position<60){Serial.print(0xFE, BYTE);   //command flag
              Serial.print((position+128+20-40), BYTE);    //position
}else if (position<80){Serial.print(0xFE, BYTE);   //command flag
              Serial.print((position+128+84-60), BYTE);    //position              
} else { goTo(0); }
}



void clearLCD(){
   Serial.print(0xFE, BYTE);   //command flag
   Serial.print(0x01, BYTE);   //clear command.
}

void backlightOn(){  //turns on the backlight
    Serial.print(0x7C, BYTE);   //command flag for backlight stuff
    Serial.print(157, BYTE);    //light level.
}

void backlightOff(){  //turns off the backlight
    Serial.print(0x7C, BYTE);   //command flag for backlight stuff
    Serial.print(128, BYTE);     //light level for off.
}
