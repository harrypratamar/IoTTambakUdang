#Ini API sudah jadi

import pyrebase
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
from flask import Flask

def knnair():
  # Impor Dataset Kondisi Air
  dataset = pd.read_csv('dataset.csv')
  dataset_ = dataset.values
  XY = dataset_[:,1:11]
  ukuran = XY.shape
  p_train = int(ukuran[0]*0.8)
  l_train = int(ukuran[1]-1)

  # Split Dataset Kondisi Air Menjadi Training Set dan Test Set
  X_train = XY[:p_train,:l_train]
  X_test = XY[257:, :-1]
  Y_train = XY[:p_train,-1:]
  Y_test = XY[257:,-1:]

  X_train, X_test, y_train, y_test = train_test_split(
      XY[:,:-1], XY[:,-1:], test_size=0.25)

  # Fitting Simple K Nearest Neighbour ke Training set
  neigh = KNeighborsClassifier(n_neighbors=3)
  neigh.fit(X_train, y_train)

  # Memprediksi Data Keadaan Air Dengan KNN
  Y_pred = neigh.predict(X_test)

  # Mendapat 3 Data Terakhir pada Firebase 
  config = {
        "apiKey" : "AIzaSyB4KpsBFRAK7mlrZ-lLULUMrkuOfd1OhfA",
        "authDomain" : "tugasakhir-e14cc.firebaseapp.com",
        "databaseURL" : "https://tugasakhir-e14cc.firebaseio.com",
        "projectId" : "tugasakhir-e14cc",
        "storageBucket" : "tugasakhir-e14cc.appspot.com",
        "messagingSenderId" : "736908466697",
        "appId" : "1:736908466697:web:632419e4091eb020a036d8",
        "measurementId" : "G-GH6RMN2KNL"
    }

  firebase = pyrebase.initialize_app(config)

  db = firebase.database()
  A = []

  CerahDeviasi = db.child("Data Monitoring/CerahDeviasi").order_by_key().limit_to_last(3).get()
  for CerahDeviasi in CerahDeviasi.each():
    A.append(CerahDeviasi.val())
    #print(CerahDeviasi.val())

  CerahRataRata = db.child("Data Monitoring/CerahRataRata").order_by_key().limit_to_last(3).get()
  for CerahRataRata in CerahRataRata.each():
    A.append(CerahRataRata.val())
    #print(CerahRataRata.val())

  Cerah = db.child("Data Monitoring/Cerah").order_by_key().limit_to_last(3).get()
  for Cerah in Cerah.each():
    A.append(Cerah.val())
    #print(Cerah.val())

  A = np.asarray(A)
  A = A.reshape(1, 9)
  hasil = neigh.predict(A)
  hasilnya = str(hasil[0])

  if ( hasilnya == "0.0" ):
      data = {"Data":"Kondisi Air 97.5 % Tenang / Perangkat Tidak Di Air"}
      db.child("Monitoring/StatusAir").set(data)
  elif ( hasilnya == "1.0" ):
      data = {"Data":"Air 97.5 % Terlalu Keruh"}
      db.child("Monitoring/StatusAir").set(data)
  elif ( hasilnya == "2.0" ):
      data = {"Data":"97.5 % Perangkat Tidak Di Air"}
      db.child("Monitoring/StatusAir").set(data)
  elif ( hasilnya == "3.0" ):
      data = {"Data":"97.5 % Air Tambak Tenang / Perangkat Berada di Tepi"}
      db.child("Monitoring/StatusAir").set(data)
  elif ( hasilnya == "4.0" ):
      data = {"Data":"97.5 % Arus Air Deras dan Banyak Pergerakan"}
      db.child("Monitoring/StatusAir").set(data)

  return hasilnya

def knnsehat():
  #Impor Dataset Kondisi Air
  dataset2 = pd.read_csv('dataset_s.csv')
  dataset_2 = dataset2.values
  XY = dataset_2[:,1:11]
  ukuran2 = XY.shape
  p_train2 = int(ukuran2[0]*0.8)
  l_train2 = int(ukuran2[1]-1)

  # Split dataset menjadi Training set and Test set
  X_train2 = XY[:p_train2,:l_train2]
  X_test2 = XY[257:, :-1]
  Y_train2 = XY[:p_train2,-1:]
  Y_test2 = XY[257:,-1:]

  X_train2, X_test2, y_train2, y_test2 = train_test_split(
      XY[:,:-1], XY[:,-1:], test_size=0.25)

  # Fitting Simple K Nearest Neighbour ke Training set
  neigh2 = KNeighborsClassifier(n_neighbors=3)
  neigh2.fit(X_train2, y_train2)

  # Memprediksi Hasil Data Dengan KNN
  Y_pred2 = neigh2.predict(X_test2)

  # Mendapat 3 Data Terakhir pada Firebase 
  config = {
        "apiKey" : "AIzaSyB4KpsBFRAK7mlrZ-lLULUMrkuOfd1OhfA",
        "authDomain" : "tugasakhir-e14cc.firebaseapp.com",
        "databaseURL" : "https://tugasakhir-e14cc.firebaseio.com",
        "projectId" : "tugasakhir-e14cc",
        "storageBucket" : "tugasakhir-e14cc.appspot.com",
        "messagingSenderId" : "736908466697",
        "appId" : "1:736908466697:web:632419e4091eb020a036d8",
        "measurementId" : "G-GH6RMN2KNL"
    }

  firebase = pyrebase.initialize_app(config)

  db = firebase.database()
  A2 = []

  CerahDeviasi = db.child("Data Monitoring/CerahDeviasi").order_by_key().limit_to_last(3).get()
  for CerahDeviasi in CerahDeviasi.each():
    A2.append(CerahDeviasi.val())
    #print(CerahDeviasi.val())

  CerahRataRata = db.child("Data Monitoring/CerahRataRata").order_by_key().limit_to_last(3).get()
  for CerahRataRata in CerahRataRata.each():
    A2.append(CerahRataRata.val())
    #print(CerahRataRata.val())

  Cerah = db.child("Data Monitoring/Cerah").order_by_key().limit_to_last(3).get()
  for Cerah in Cerah.each():
    A2.append(Cerah.val())
    #print(Cerah.val())

  A2 = np.asarray(A2)
  A2 = A2.reshape(1, 9)
  hasil2 = neigh2.predict(A2)
  hasilnya2 = str(hasil2[0])

  if ( hasilnya2 == "0.0" ):
      data = {"Data":"Udang Di Prediksi 99.9 % Mati"}
      db.child("Monitoring/StatusKesehatan").set(data)
  elif ( hasilnya2 == "1.0" ):
      data = {"Data":"Udang Di Prediksi 99.9 % Sakit"}
      db.child("Monitoring/StatusKesehatan").set(data)
  elif ( hasilnya2 == "2.0" ):
      data = {"Data":"Udang Di Prediksi 99.9 % Sehat"}
      db.child("Monitoring/StatusKesehatan").set(data)

  return hasilnya2

app = Flask(__name__)

# for / root, return Hello Word
@app.route('/air')
def requestair():
   return knnair()

@app.route('/sehat')
def requestsehat():  
    return knnsehat() 
    
if __name__ == '__main__':
    app.run()