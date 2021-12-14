const emmiter_sound = {
  "Headphones/speakerphones": 0,
  "5.1 sound": 51,
  "7.1 sound": 71
};

const emmiter_peso = {
  "Piezo membrane (1.7 mHz)": 1700000,
};

const emmiter_peso_aroma = {
  "Piezo membrane (1.7 mHz) with playback": 17,
  "Piezo membrane (1.7 mHz) without playback": -17,
};

const emmiter_uzi = {
  "УЗИ датчик FRAGILE (1 mHz)": 100,
};

const emmiter_electrodes = {"Electrodes": 777};

const emmiter_osd = {...emmiter_peso, ...emmiter_uzi, ...emmiter_electrodes};
