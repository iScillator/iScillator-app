import '/config/emmiters.dart';

const oscillators_am = {
  "AM radiotransmitter (1Mhz)": 1000000,
  "AM radiotransmitter (3Mhz)": 3000000,
  "AM radiotransmitter (3.3Mhz)": 3300000,
  "AM radiotransmitter (3.8Mhz)": 3800000,
  "AM radiotransmitter (5Mhz)": 5000000,
  "AM radiotransmitter (1Mhz+1Mhz)": 1000001,
  "AM radiotransmitter (1Mhz+3Mhz)": 1000003,
  "AM radiotransmitter (1Mhz+5Mhz)": 1000005,
  "AM radiotransmitter (3Mhz+3Mhz)": 3000003,
  "AM radiotransmitter (3Mhz+5Mhz)": 3000005,
  "AM radiotransmitter (5Mhz+5Mhz)": 5000005,
};

const oscillators = {
  "Internal": 0,
  "Digital oscillators": {"FY6900-60 OSD цифровой осциллятор": emmiter_osd},
  "AM radiotransmitters": oscillators_am,
  "Ray Tube": {"Ray Tube 5.2": 52},
  "Aroma diffuser": emmiter_peso_aroma,

};
/*

  "Diffusor 1.7 + Speakers": 17,
  "Ray Tube 5.2": 52,
  "FY6900": 6900,
  "AM 1MHz": 1000000,
  "AM 3MHz": 3000000,
  "AM 5MHz": 5000000,
  "AM 1MHz,1MHz": 1100000,
  "AM 1MHz,3MHz": 1300000,
  "AM 1MHz,5MHz": 1500000,
  "AM 3MHz,3MHz": 3300000,
  "AM 3MHz,5MHz": 3500000,
  "AM 5MHz,5MHz": 5500000,
  "La+Ri":1212
*/


    /*
   LATER AM+SOUND

   LATER Controlled difusor
  */