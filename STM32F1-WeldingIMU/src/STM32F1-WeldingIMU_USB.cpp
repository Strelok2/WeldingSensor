#include <Wire.h>
#include <SPI.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BNO055.h>
#include <utility/imumaths.h>
#include <Arduino.h>


#define BNO055_SAMPLERATE_DELAY_MS (100)
#define BNO_RES PB9

Adafruit_BNO055 myBNO055= Adafruit_BNO055(-1,0x28);

/*--Global Variables--*/
uint8_t system1, gyro, accel, mag = 0;
imu::Vector<3>  accelerometer,gyroscope, magnetometer, euler, linearaccel, gravity, Qeuler;
imu::Quaternion   quaternion;

uint64_t SensorReadTime;

/*--Functions--*/
void displayCalibrationStatus();
void displayRawAccel();
void displayRawGyro();
void displayRawMag();
void displaySesnsorEuler();
void displayLinAccel();
void displayGravity();
void displayQuaternionValues();
void displayCalculatedQuat();
void readSensorValues();

void setup(void)
{
    /*Reset the sensor*/
    pinMode(BNO_RES,OUTPUT);
    digitalWrite(BNO_RES,LOW);
    delay(100);
    digitalWrite(BNO_RES,HIGH);
    /*Set serial communication*/
    //SerialUSB.begin(115200);
    SerialUSB.begin(115200);
    delay(500);
    /*Start the sensor*/
    if(!myBNO055.begin())
    {
      SerialUSB.println("Error");
      while(1);
    }
    delay(1000);
}
void loop() {
  readSensorValues();  
  SerialUSB.print(SensorReadTime);
  SerialUSB.print(", ");

  displayCalibrationStatus();
  displayRawAccel();
  displayRawGyro();
  displayRawMag();
  displaySesnsorEuler(); 
  displayLinAccel();
  displayGravity();
  displayQuaternionValues();
  displayCalculatedQuat();
  SerialUSB.println(" ; ");
}
void displayCalibrationStatus(){
  /* Display calibration status */
  SerialUSB.print(gyro);
  SerialUSB.print(",");
  SerialUSB.print(mag);
  SerialUSB.print(",");
  SerialUSB.print(accel);
  SerialUSB.print(",");
  SerialUSB.print(system1);
  SerialUSB.print(",");
}
void displayRawAccel(){
  SerialUSB.print(accelerometer.x());
  SerialUSB.print(",");
  SerialUSB.print(accelerometer.y());
  SerialUSB.print(",");
  SerialUSB.print(accelerometer.z());
  SerialUSB.print(",");
}
void displayRawGyro(){
  SerialUSB.print(gyroscope.x());
  SerialUSB.print(",");
  SerialUSB.print(gyroscope.y());
  SerialUSB.print(",");
  SerialUSB.print(gyroscope.z());
  SerialUSB.print(",");
}
void displayRawMag(){
  SerialUSB.print(magnetometer.x());
  SerialUSB.print(",");
  SerialUSB.print(magnetometer.y());
  SerialUSB.print(",");
  SerialUSB.print(magnetometer.z());
  SerialUSB.print(",");
}
void displaySesnsorEuler(){
  SerialUSB.print(euler.x());
  SerialUSB.print(",");
  SerialUSB.print(euler.y());
  SerialUSB.print(",");
  SerialUSB.print(euler.z());
  SerialUSB.print(",");
}
void displayLinAccel(){
  SerialUSB.print(linearaccel.x());
  SerialUSB.print(",");
  SerialUSB.print(linearaccel.y());
  SerialUSB.print(",");
  SerialUSB.print(linearaccel.z());
  SerialUSB.print(",");
}
void displayGravity(){
  SerialUSB.print(gravity.x());
  SerialUSB.print(",");
  SerialUSB.print(gravity.y());
  SerialUSB.print(",");
  SerialUSB.print(gravity.z());
  SerialUSB.print(",");
}
void displayQuaternionValues(){
  SerialUSB.print(quaternion.w());
  SerialUSB.print(",");
  SerialUSB.print(quaternion.x());
  SerialUSB.print(",");
  SerialUSB.print(quaternion.y());
  SerialUSB.print(",");
  SerialUSB.print(quaternion.z());
  SerialUSB.print(",");
}
void displayCalculatedQuat(){
  SerialUSB.print((180 / 3.14159265) * Qeuler.x());
  SerialUSB.print(",");
  SerialUSB.print((180 / 3.14159265) * Qeuler.y());
  SerialUSB.print(",");
  SerialUSB.print((180 / 3.14159265) * Qeuler.z());
  SerialUSB.print(",");
}
void readSensorValues(){
  // 1- VECTOR_ACCELEROMETER - m/s^2
  // 2- VECTOR_MAGNETOMETER  - uT
  // 3- VECTOR_GYROSCOPE     - rad/s
  // 4- VECTOR_EULER         - degrees
  // 5- VECTOR_LINEARACCEL   - m/s^2
  // 6- VECTOR_GRAVITY       - m/s^2
  // 7- Quaternion           - -
  // 8- Tempreture           - C
  // 9- Quat -> EULER        - degrees

  myBNO055.getCalibration(&system1, &gyro, &accel, &mag);

  accelerometer = myBNO055.getVector(Adafruit_BNO055::VECTOR_ACCELEROMETER);
  gyroscope    =  myBNO055.getVector(Adafruit_BNO055::VECTOR_GYROSCOPE);
  magnetometer =  myBNO055.getVector(Adafruit_BNO055::VECTOR_MAGNETOMETER);
  euler        =  myBNO055.getVector(Adafruit_BNO055::VECTOR_EULER);
  linearaccel  =  myBNO055.getVector(Adafruit_BNO055::VECTOR_LINEARACCEL);
  gravity      =  myBNO055.getVector(Adafruit_BNO055::VECTOR_GRAVITY);
  quaternion   =  myBNO055.getQuat();
  quaternion.normalize();
  Qeuler = quaternion.toEuler();
  SensorReadTime = millis();
}