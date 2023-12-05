#include <Wire.h>


const int MPU_addr=0x68;
int16_t AcX,AcY,AcZ,Tmp,GyX,GyY,GyZ;
 
int minVal=265;
int maxVal=402;
 
double x;
double y;
double z;
int fsrPin = 0;     // the FSR and 10K pulldown are connected to a0
int fsrPin2 = 1;
int fsrPin3 = 2;
int fsrPin4 = 3;
int fsrReading;     // the analog reading from the FSR resistor divider
int fsrReading2;     // the analog reading from the FSR resistor divider
int fsrReading3;     // the analog reading from the FSR resistor divider
int fsrReading4;     // the analog reading from the FSR resistor divider

int fsrVoltage;     // the analog reading converted to voltage
int fsrVoltage2;     // the analog reading converted to voltage
int fsrVoltage3;     // the analog reading converted to voltage
int fsrVoltage4;     // the analog reading converted to voltage

unsigned long fsrResistance;  // The voltage converted to resistance, can be very big so make "long"
unsigned long fsrResistance2;  // The voltage converted to resistance, can be very big so make "long"
unsigned long fsrResistance3;  // The voltage converted to resistance, can be very big so make "long"
unsigned long fsrResistance4;  // The voltage converted to resistance, can be very big so make "long"

unsigned long fsrConductance;
unsigned long fsrConductance2;
unsigned long fsrConductance3;
unsigned long fsrConductance4;

long fsrForce;       // Finally, the resistance converted to force
long fsrForce2;       // Finally, the resistance converted to force
long fsrForce3;       // Finally, the resistance converted to force
long fsrForce4;       // Finally, the resistance converted to force

char dataReady=0;

void setupTimer1() {
   noInterrupts();
  // Clear registers
  TCCR1A = 0;
  TCCR1B = 0;
  TCNT1 = 0;

 // 20 Hz (16000000/((3124+1)*256))
  OCR1A = 3124;
  // CTC
  TCCR1B |= (1 << WGM12);
  // Prescaler 256
  TCCR1B |= (1 << CS12);
  // Output Compare Match A Interrupt Enable
  TIMSK1 |= (1 << OCIE1A);
  interrupts();

}
void setup() {
  Serial.begin(9600);
  Wire.begin();
  Wire.beginTransmission(MPU_addr);
  Wire.write(0x6B);
  Wire.write(0);
  Wire.endTransmission(true);
  setupTimer1();
}

void loop() {
 if(dataReady>0)
  {
    dataReady=0;
    // Angle
    Wire.beginTransmission(MPU_addr);
    Wire.write(0x3B);
    Wire.endTransmission(false);
    Wire.requestFrom(MPU_addr,14,true);
    AcX=Wire.read()<<8|Wire.read();
    AcY=Wire.read()<<8|Wire.read();
    AcZ=Wire.read()<<8|Wire.read();
    int xAng = map(AcX,minVal,maxVal,-90,90);
    int yAng = map(AcY,minVal,maxVal,-90,90);
    int zAng = map(AcZ,minVal,maxVal,-90,90);
     
    x= RAD_TO_DEG * (atan2(-yAng, -zAng)+PI);
    y= RAD_TO_DEG * (atan2(-xAng, -zAng)+PI);
    z= RAD_TO_DEG * (atan2(-yAng, -xAng)+PI);
    // FSR
    fsrReading = analogRead(fsrPin);
    fsrReading2 = analogRead(fsrPin2);
    fsrReading3 = analogRead(fsrPin3);
    fsrReading4 = analogRead(fsrPin4);

    fsrVoltage = map(fsrReading, 0, 1023, 0, 5000);
    fsrVoltage2 = map(fsrReading2, 0, 1023, 0, 5000);
    fsrVoltage3 = map(fsrReading3, 0, 1023, 0, 5000);
    fsrVoltage4 = map(fsrReading4, 0, 1023, 0, 5000);
   
    fsrResistance = 5000 - fsrVoltage;     // fsrVoltage is in millivolts so 5V = 5000mV
    fsrResistance2 = 5000 - fsrVoltage2;     // fsrVoltage is in millivolts so 5V = 5000mV
    fsrResistance3 = 5000 - fsrVoltage3;     // fsrVoltage is in millivolts so 5V = 5000mV
    fsrResistance4 = 5000 - fsrVoltage4;     // fsrVoltage is in millivolts so 5V = 5000mV
   
    fsrResistance *= 10000;                // 10K resistor
    fsrResistance2 *= 10000;                // 10K resistor
    fsrResistance3 *= 10000;                // 10K resistor
    fsrResistance4 *= 10000;                // 10K resistor
   
    fsrResistance /= fsrVoltage;
    fsrResistance2 /= fsrVoltage2;
    fsrResistance3 /= fsrVoltage3;
    fsrResistance4 /= fsrVoltage4;
   
    fsrConductance = 1000000;
    fsrConductance /= fsrResistance;
   
    fsrConductance2 = 1000000;
    fsrConductance2 /= fsrResistance2;

    fsrConductance3 = 1000000;
    fsrConductance3 /= fsrResistance3;

    fsrConductance4 = 1000000;
    fsrConductance4 /= fsrResistance4;
           
 if (fsrConductance <= 1000) {
      fsrForce = fsrConductance / 80;
      fsrForce2 = fsrConductance2 / 80;
      fsrForce3 = fsrConductance3 / 80;
      fsrForce4 = fsrConductance4 / 80;

      Serial.print(x);
      Serial.print(";");
       
      Serial.print(y);
      Serial.print(";");
       
      Serial.print(z);
      Serial.print(";");
      Serial.print(fsrForce);  
      Serial.print(";");
      Serial.print(fsrForce2);
      Serial.print(";");
      Serial.print(fsrForce3);
      Serial.print(";");
      Serial.println(fsrForce4);


         
    } else {
      fsrForce = fsrConductance - 1000;
      fsrForce /= 30;
      fsrForce2 = fsrConductance2 - 1000;
      fsrForce2 /= 30;
      fsrForce3 = fsrConductance3 - 1000;
      fsrForce3 /= 30;
      fsrForce4 = fsrConductance4 - 1000;
      fsrForce4 /= 30;
     
      Serial.print(x);
      Serial.print(";");
       
      Serial.print(y);
      Serial.print(";");
       
      Serial.print(z);
      Serial.print(";");
      Serial.println(fsrForce);  
      Serial.print(";");
      Serial.print(fsrForce2);
      Serial.print(";");
      Serial.print(fsrForce3);
      Serial.print(";");
      Serial.println(fsrForce4);        
    }
  }
   
 


    }
   



ISR(TIMER1_COMPA_vect){//timer0 interrupt 2kHz toggles pin 8
//generates pulse wave of frequency 2kHz/2 = 1kHz (takes two cycles for full wave- toggle high then toggle low)
  dataReady=1;
}
