# IoT Tambak Udang

IoT Tambak udang merupakan aplikasi untuk mendeteksi bagaimana kesehatan udang dan kondisi air tambak udang.
Menggunakan NodeMCU ESP8266, Sensor suhu dan LDR serta aplikasi Android berbasis Flutter dan Algoritma KNN untuk memprediksi kesehatan udang dan kondisi air tambak udang
kemudian ditampilkan dalam aplikasi Android.

## Layanan yang digunakan :
1. Firebase Realtime Database
2. Firebase Authentication
3. Heroku

# Cara penggunaan :

## Konfigurasi Firebase
1. Buat project pada Firebase dengan nama bebas
2. Buat Realtime Database pada Firebase
3. Ganti rules read dan write database menjadi true
4. Pada tampilan Realtime Database, salin alamat url database kebagian FIREBASE_HOST pada kode program NodeMCU tanpa https 
   Misal url database https://blabla.firebaseio.com/ maka dituliskan menjadi blabla.firebaseio.com
5. Klik Gerigi disebelah Project Overview kemudian klik Project Settings lalu Service Accounts. 
   Salin kode database secret ke bagian FIREBASE_AUTH pada kode program NodeMCU
6. 
