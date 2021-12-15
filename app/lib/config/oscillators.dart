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
