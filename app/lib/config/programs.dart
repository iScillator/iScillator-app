import '/config/defaults.dart';
import '/config/targets.dart';

//¹²³⁵₂₃₅

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
