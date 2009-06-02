//  *
//  * ------------
//  *  Control a Serial LCD Display
//  *  
//  *  Tested on a Matrix Orbital model LCD0821 display.
//  *  Other diplays will work but may have slightly different 
//  *  command codes and hardware setups. 
//  *   
//  *  Copyleft 2006 by djmatic 
//  *  
//  *   ------------
//  *
//  *


// Declare your program variables here


// Arduino and LCD setup 

void setup()
{
  beginSerial(19200);


//       LCD setup commands: uncomment the ones you want to use
//       Note: These codes (i.e. the ones following 254) may have to be changed for 
//       different manufacturer's displays

//       Turn Auto scroll ON
//         Serial.print(254, BYTE);
//         Serial.print(81, BYTE);     
//       
//       Turn Auto scroll OFF
//         Serial.print(254, BYTE);
//         Serial.print(82, BYTE); 

//       Turn ON AUTO line wrap
//         Serial.print(254, BYTE); 
//         Serial.print(67, BYTE);              

//       Turn OFF AUTO line wrap
//         Serial.print(254, BYTE); 
//         Serial.print(68, BYTE); 

//       Turn OFF the block cursor    
//       Note that setting both block and underline 
//       cursors may give unpredictable results. 
           Serial.print(254, BYTE);
           Serial.print(84, BYTE);               

//       Turn ON the block cursor
//         Serial.print(254, BYTE);
//         Serial.print(83, BYTE);  

//       Turn ON the underline cursor
//         Serial.print(254, BYTE);
//         Serial.print(74, BYTE);               

//       Turn OFF the underline cursor
//         Serial.print(254, BYTE);
//         Serial.print(75, BYTE);               
}




//  MAIN CODE

void loop()
{ 
  //backlightOn(0);  // turn the backlight on all the time

  clearLCD();
  Serial.print(" Hello");  // print text to the current cursor position
  newLine();              // start a new line
  Serial.print("Arduino");
  delay(5000);
}




//  LCD  FUNCTIONS-- keep the ones you need. 

// clear the LCD
void clearLCD(){
  Serial.print(12, BYTE);
}


// start a new line
void newLine() { 
  Serial.print(10, BYTE); 
}


// move the cursor to the home position
void cursorHome(){
  Serial.print(254, BYTE);
  Serial.print(72, BYTE);
}


// move the cursor to a specific place
// e.g.: cursorSet(3,2) sets the cursor to x = 3 and y = 2
void cursorSet(int xpos, int ypos){  
  Serial.print(254, BYTE);
  Serial.print(71, BYTE);               
  Serial.print(xpos);   //Column position   
  Serial.print(ypos); //Row position 
} 


// backspace and erase previous character
void backSpace() { 
  Serial.print(8, BYTE); 
}


// move cursor left
void cursorLeft(){    
  Serial.print(254, BYTE); 
  Serial.print(76, BYTE);   
}


// move cursor right
void cursorRight(){
  Serial.print(254, BYTE); 
  Serial.print(77, BYTE);   
}


// set LCD contrast
void setContrast(int contrast){
  Serial.print(254, BYTE); 
  Serial.print(80, BYTE);   
  Serial.print(contrast);   
}


// turn on backlight
void backlightOn(int minutes){
  Serial.print(254, BYTE); 
  Serial.print(66, BYTE);   
  Serial.print(minutes); // use 0 minutes to turn the backlight on indefinitely   
}


// turn off backlight
void backlightOff(){
  Serial.print(254, BYTE); 
  Serial.print(70, BYTE);   
}
