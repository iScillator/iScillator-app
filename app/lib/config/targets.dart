const targets_dev = {
  "[116]": 116,
  "Flower of Life [144,209,302]": [144, 209, 302],
  // 141?144-145, 209-211, 457 665-668/668 810-812, 920??? /// 457 ((457/144)^2=10 => 144*sqrt(10)=457) 667 (209*sqrt(10)? ) 810 (144*sqrt(15))
  // 141 -65db, 211 -58db, 305 -44db, 457 -50db
  // -65 -85 -44 - 50
  //8:23 => 396 -52, 694 -68
  //7:15???
  // 116, 231,349   => 464, 580, 696
  // 528, x2,x3 => 1051,1583
  //116 233 349 385 464 456 693
  "Svadhisthana Bil [396, 694]": [396, 694],
  "Anahata Binaural [-528, -531]": [-528, -531],
  "100Hz": 100,
  "400Hz": 400,
  "900Hz": 900,
  "4kHz": 4000,
  "5k": 5000,
  "9kHz": 9000,
  "10k": 10000,
  "20kHz": 20000,
  "40kHz": 40000,
};

const targets_chackras = {
  "Flower of Life": 144,
  "Fundamental": 174,
  "Muladhara": 285,
  "Svadhisthana": 396,
  "Manipura": 417,
  "Anahata": 528,
  "Vishudha": 639,
  "Adjna": 741,
  "Sahasrara": 852,
  "Sahasradala": 963,
  "Anahata+Sahasrara": [528, 852],
};

const targets_rife_radio = {
  "Influenza 1+2": [1946704, 1674000],
  "Influenza 1": 1946704,
  "Influenza 2": 1674000,
  "Pneumonia": 426862,
  "Psoriasis 1+2+3": [925370, 232500, 725470],
  "Psoriasis 1": 925370,
  "Psoriasis 2": 232500,
  "Psoriasis 3": 725470,
};

const targets_rife_audio = {
  "Rife audio #1": 1674,
  "Rife audio #2": 4268,
  "TODO:ADD MORE": 7777,
};

const targets_app_lite = {...targets_chackras};
const targets_app_pro = {
  ...targets_chackras,
  ...targets_rife_audio,
  ...targets_rife_radio
};
const targets_app_dev = {
  ...targets_dev,
  ...targets_chackras,
  ...targets_rife_audio,
  ...targets_rife_radio
};


/*

174 Гц

285 Гц муладхара = +Меркурий -Марс (M-A, F-P)
396 Гц свадхистхана = +Сатурн -Венера (F-A, M-P)
417 Гц манипура = +Марс -Солнце (M-A,F-P)
528 Гц анахата = +Юпитер -Луна (F-A, M-P)
639 Гц вишуддха = +Венера -Меркурий
741 Гц аджна = +Луна -Сатурн
852 Гц сахасрара = +Солнце -Юпитер

963 Гц

Возможно ошибка в цифрах

https://yogavedi.ru/samorazvitie/astrology/svyaz-chakr-i-planet-stroenie-tonkogo-tela.html

У каждого центра есть планеты-поставщики энергии и планеты-потребители энергии. Деятельность этих планет сильно взаимосвязана и расстройства в энергии одной планеты может привести к расстройствам в энергии другой. Как и в любой рабочей системе приток и отток должны находиться в гармонии. Дисбаланс же между ними приводит к нарушениям в работе центра, что влечет за собой неприятности в виде страданий и болезней.

*/
