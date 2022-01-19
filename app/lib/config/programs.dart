import '/config/defaults.dart';
import '/config/targets.dart';

//¹²³⁵₂₃₅

const programs_app_vl = {
  "Cancer_general_1":"{'autonext':'15','target':[10000, 5000, 3176, 2720, 2489, 2189, 2184, 2128, 2084, 2050, 2008, 880, 854, 800, 784, 728, 666, 524, 464, 333, 304]}",
  "Coronavirus SARS":"{'autonext':'15','target':[9918, 9740, 4959, 2479.5, 2435, 760.9, 155]}",
  "Herpes": "{'autonext':'15','target':[322, 476, 589, 664, 785, 822, 2950]}",
  "Colit and Diarea":"{'autonext':'15','target':[10000, 5000, 1550, 727, 465, 440]}"
};

const programs_main = {
  "Chackras": {
    ...targets_chackras,
    "@defaults": defaults_fix,
  },
  "Bils Golden Angle": {
    ...targets_chackras,
    "@defaults": defaults_bills_golden,
  },
  "Bils Square": {
    ...targets_chackras,
    "@defaults": defaults_bills_square,
  },
  "Bils Binaural": {
    ...targets_chackras,
    "@defaults": defaults_bills_binaural,
  },

  /*
  "Singing Bowls": "Поющие чаши",
  */
};

const programs_rife = {
  "Rife audio frequencies": {
    ...targets_rife_audio,
    "@defaults": defaults_rife_audio
  },
  "Rife radio-to-sound know-how": {
    ...targets_rife_radio,
    "@defaults": defaults_rife_radio_to_sound
  },
  "Rife radio frequencies": {
    ...targets_rife_radio,
    "@defaults": defaults_rife_radio
  }
};

const programs_essentials = {
  "Essential oils": {
    "Rose (essential oil)": {
      "Antistress (Anahata)": 528,
      "@defaults": {"enviroment": 320000000}
    },
    "Peppermint (essential oil)": {
      "Antistress (Anahata)": 528,
      "@defaults": {"enviroment": 78000000}
    },
    "White Angelica (essential oil)": {
      "Antistress (Anahata)": 528,
      "@defaults": {"enviroment": 89000000}
    },
    "Thieves (essential oil)": {
      "Antistress (Anahata)": 528,
      "@defaults": {"enviroment": 150000000}
    },
    "@defaults": defaults_essentials
  }
};

// Для первичной публикации в продакшне(сторах), без пугающих названий!
const programs_prod = {
  ...programs_main,
};

const programs_app_lite = {
  ...programs_main,
};

const programs_app_pro = {
  ...programs_main,
  ...programs_rife,
  ...programs_essentials
};

const programs_app_dev = {
  ...programs_main,
  ...programs_rife,
  ...programs_essentials
};
