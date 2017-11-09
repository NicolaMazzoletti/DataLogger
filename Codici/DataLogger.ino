#include <SoftwareSerial.h>
#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BME280.h>

/*
    Per far funzionare il sensore BME280, bisogna modificare la libreria "Adafruit_BME280" 
    e cambiare l'i2cAdress in base a quello del sensore (si può trovare questo indirizzo tramite un i2cScanner).

    I due moduli devono essere associati tra loro tramite il programma di configurazione (es: APM planner o Mission Planner)

    AirModule to Arduino Micro:
      VCC --> 5V
      GND --> GND
      RX --> D4
      TX --> D5

    BME280 to Arduino Micro:
      VCC --> 5V
      GND --> GND
      SDA --> D2
      SCL --> D3
      
*/
Adafruit_BME280 bme;
SoftwareSerial mySerial(4, 5);

const int ID_STAZIONE = 1;

void setup(){ 
    mySerial.begin(57600);

    //controllo che il sensore si riesca ad utilizzare
    if(!bme.begin()){
        mySerial.println("Sensore BME280 non trovato.");
        while(1);  
    }

    delay(1000);
}

void loop(){
    mySerial.print(ID_STAZIONE);
    mySerial.print(",");
    mySerial.print(bme.readTemperature());
    mySerial.print(",");
    mySerial.print(bme.readPressure() / 100.0F);
    mySerial.print(",");
    mySerial.print(bme.readHumidity());
    mySerial.println();    
    
    delay(1000);
}
