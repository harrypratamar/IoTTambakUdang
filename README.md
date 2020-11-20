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
2. Masuk ke authentication kemudian sign-in method dan aktifkan sign-in provider dari Google (ini digunakan untuk login user pada aplikasi flutter)
3. Buat Realtime Database pada Firebase
4. Ganti rules read dan write database menjadi true
5. Pilih file NodeMCU.ino pada folder NodeMCU dan buka di aplikasi Arduino IDE
5. Pada tampilan Realtime Database, salin alamat url database kebagian FIREBASE_HOST pada kode program NodeMCU tanpa https. 
   Misal url database https://blabla.firebaseio.com/ maka dituliskan menjadi blabla.firebaseio.com
6. Klik Gerigi disebelah Project Overview kemudian klik Project Settings lalu Service Accounts. 
   Salin kode database secret ke bagian FIREBASE_AUTH pada kode program NodeMCU

## Konfigurasi NodeMCU
1. Setelah mendapatkan FIREBASE_AUTH dan FIREBASE_HOST, langkah selanjutnya yaitu melakukan import library dan Additional board yang diperlukan oleh NodeMCU
2. Untuk cara menambahkan Additional Board dapat dilihat pada link berikut ini https://www.instructables.com/Get-Started-With-NodeMCU/
3. Untuk cara menambahkan library dapat dilihat pada link berikut ini https://www.instructables.com/How-to-Add-an-External-Library-to-Arduino/
4. Setelah board dan library berhasil ditambahkan, maka lakukan konfigurasi WiFi dari NodeMCU pada baris kode WIFI_SSID dan WIFI_PASSWORD yang disesuakian dengan nama wifi
   dan password yang digunakan sebagai Access Point
5. Sambungkan sensor ke pin Arduino (Untuk PIN dari kode Program Sensor LDR dihubungkan ke pin A0, Sensor DHT ke pin D3 dan Sensor Suhu Air Dallas DS18B20 ke pin D2) Untuk referensi pin NodeMCU dapat dilihat pada link berikut ini https://components101.com/development-boards/nodemcu-esp8266-pinout-features-and-datasheet
6. Lakukan upload kode program ke NodeMCU, tunggu sampai selesai. Apabila berhasil maka data sensor akan terkirim ke Realtime Database firebase

# Tambahan
Untuk prediksi KNN, saya lakukan develop pada web hosting milik Heroku, apabila ingin mendevelop sendiri maka dapat mengikuti tutorial berikut ini https://devcenter.heroku.com/articles/heroku-cli. Jangan lupa untuk melakukan konfigurasi pada firebase dan buat aplikasi baru dalam bentuk website untuk menghubungkan algoritma knn ke Firebase Realtime database dengan cara klik project overview pada website firebase, pilih Add App dan pilih website, lalu setelah website berhasil masuk kke pengaturan web melalui tombol gerigi, lakukan scroll kebawah dan salinlah Firebase SDK ke app.py

Terima Kasih
