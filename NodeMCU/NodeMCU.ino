v#include <iostream>
#include <bits/stdc++.h> 
#include <FirebaseESP8266.h>
#include <SimpleTimer.h> 
#include <DallasTemperature.h>
#include <OneWire.h>
#include <ESP8266WiFi.h>
#include <SoftwareSerial.h>
#include <ArduinoJson.h>
#include <NTPClient.h>
#include <WiFiUdp.h>
#include <ESP8266HTTPClient.h>
#include <Wire.h>
#include <DHT.h>
#include <time.h>

using namespace std;
 
// Set these to run example.
#define FIREBASE_HOST "tugasakhir-e14cc.firebaseio.com"
#define FIREBASE_AUTH "KBG5gfXWt7q97QTpeKgVrLNQvM7627ywUp3qfPWP"
#define WIFI_SSID "Caracal"
#define WIFI_PASSWORD "animalia"
#define ONE_WIRE_BUS 4                          //D1 pin of NodeMCU
#define NTP_OFFSET  7 * 60 * 60      // In seconds
#define NTP_INTERVAL 1000    // In miliseconds
#define NTP_ADDRESS  "asia.pool.ntp.org"
#define DHTTYPE DHT11      // DHT 11
#define dht_dpin 0
#define relay 14
DHT dht(dht_dpin, DHTTYPE);
OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensors(&oneWire);
FirebaseData firebaseData;
SimpleTimer timer;
WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, NTP_ADDRESS, NTP_OFFSET, NTP_INTERVAL);
char daysOfTheWeek[7][12] = {"Minggu", "Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu"};
String path = "/Monitoring";
String datapath = "/Data Monitoring";
double myDouble, myDouble2, cahaya_mean, cahaya_stdv, suhu_mean, suhu_stdv;
double vr = A0;  
double sdata = 0;
double tdata = 0;
double convert = 0;// The variable resistor value will be stored in sdata and convert with range 0-100.
String status1 = "Suhu Air Terlalu Dingin";
String status2 = "Suhu Air Ideal";
String status3 = "Suhu Air Hangat";
String status4 = "Suhu Air Panas";


double s_arr[30] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
  
double t_arr[30] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};

int variance(double a[], double n) 
{ 
    // Compute mean (average of elements) 
    int sum = 0; 
    for (int i = 0; i < n; i++) 
        sum += a[i]; 
    double mean = (double)sum /  
                  (double)n; 
  
    // Compute sum squared  
    // differences with mean. 
    double sqDiff = 0; 
    for (int i = 0; i < n; i++)  
        sqDiff += (a[i] - mean) *  
                  (a[i] - mean); 
    return sqDiff / n; 
} 
  
double standardDeviation(double arr[], double n) 
{ 
    return sqrt(variance(arr, n)); 
}

 
double mean(double arr[]){
    double avg = 0.0;
    double sum = 0.0;
     for (int i = 0; i < 30; i++)
     {
         sum += s_arr[i];
     }
     avg = sum / 30;
     return avg;
}

double meanT(double arr[]){
    double avg = 0.0;
    double sum = 0.0;
     for (int i = 0; i < 30; i++)
     {
         sum += t_arr[i];
     }
     avg = sum / 30;
     return avg;
}

void geser_ke_kanan_suhu(){
    for (int i = 0; i<=28; i++)
    {
        t_arr[30-i-1] = t_arr[30-i-2];
    }
    
    t_arr[0] = 0;
}

void geser_ke_kanan_cahaya(){
    for (int i = 0; i<=28; i++)
    {
        s_arr[30-i-1] = s_arr[30-i-2];
    }
    
    s_arr[0] = 0;
}

void catat_suhu(double ini)
{
    geser_ke_kanan_suhu();
    t_arr[0] = ini;
}

void catat_cahaya(double ini)
{
    geser_ke_kanan_cahaya();
    s_arr[0]=ini;
} 

void setup()
{
  Serial.begin(9600);
  timeClient.begin();
  sensors.begin();
  dht.begin();
  timer.setInterval(100, Time);
  timer.setInterval(100, Day);
  timer.setInterval(100, Suhu);
  timer.setInterval(100, DataLogger);
  timer.setInterval(100, Light);
  timer.setInterval(100, StatusSuhu);
  pinMode(vr ,INPUT);
  pinMode(relay ,OUTPUT);
  // connect to wifi.
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("connecting");
  while (WiFi.status() != WL_CONNECTED)
      {
    Serial.print(".");
    delay(500);
      }
  Serial.println();
  Serial.print("connected: ");
  Serial.println(WiFi.localIP());
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
}

void Time()
{
  String Waktu = timeClient.getFormattedTime();
  Firebase.setString(firebaseData, path + "/Waktu/Data",Waktu);
  Firebase.pushString(firebaseData, datapath + "/Waktu" ,Waktu);
}

void Day()
{
  String Hari = daysOfTheWeek[timeClient.getDay()];
  Firebase.setString(firebaseData, path + "/Hari/Data",Hari);
  Firebase.pushString(firebaseData, datapath + "/Hari" ,Hari);
} 

void Suhu()
{
  tdata = sensors.getTempCByIndex(0);
  myDouble = double(tdata);
  catat_suhu(myDouble);
  suhu_mean = myDouble / 30;
  Firebase.setDouble(firebaseData, path + "/Suhu/Data",myDouble);
  Firebase.setDouble(firebaseData, path + "/Suhu_stdv/Data",standardDeviation(t_arr, 30));
  Firebase.setDouble(firebaseData, path + "/Suhu_mean/Data",meanT(t_arr));
  Firebase.pushDouble(firebaseData, datapath + "/Suhu" ,myDouble);
  Firebase.pushDouble(firebaseData, datapath + "/Suhu_stdv",standardDeviation(t_arr, 30));
  Firebase.pushDouble(firebaseData, datapath + "/Suhu_mean",meanT(t_arr));
}

void Light()
{
  sdata = analogRead(vr);
  convert = sdata * (100.0 /1024);
  myDouble2 = double(convert);
  catat_cahaya(myDouble2);
  cahaya_mean = myDouble2 / 30;
  Firebase.setDouble(firebaseData, path + "/Cerah/Data",myDouble2);
  Firebase.setDouble(firebaseData, path + "/Cerah_stdv/Data",standardDeviation(s_arr, 30));
  Firebase.setDouble(firebaseData, path + "/Cerah_mean/Data",mean(s_arr));
  Firebase.pushDouble(firebaseData, datapath + "/Cerah" ,myDouble2);
  Firebase.pushDouble(firebaseData, datapath + "/CerahDeviasi" ,standardDeviation(s_arr, 30));
  Firebase.pushDouble(firebaseData, datapath + "/CerahRataRata" ,mean(s_arr));
}

void DataLogger()
{
  double t = dht.readTemperature(); 
  Serial.print(t); 
  if (t > 35.00){
      Serial.println("Kipas Menyala");
      digitalWrite(relay, LOW);   
    } else {
      Serial.println("Kipas Mati");
      digitalWrite(relay, HIGH);
    }
  Firebase.setDouble(firebaseData, path + "/SuhuAlat/Data",t);              
}

void StatusSuhu()
{
  if (myDouble < 25 ){
    Firebase.setString(firebaseData, path + "/StatusSuhu/Data",status1);
  }
  
  if (myDouble > 25 && myDouble < 27){
    Firebase.setString(firebaseData, path + "/StatusSuhu/Data",status2);
  }  

  if (myDouble > 27 && myDouble <= 30){
    Firebase.setString(firebaseData, path + "/StatusSuhu/Data",status3);
  }
  if (myDouble > 30 && myDouble <= 35){
    Firebase.setString(firebaseData, path + "/StatusSuhu/Data",status3);
  }
}

void loop()
{
  sensors.requestTemperatures();
  timeClient.update();
  timer.run();
}
