//⁰¹²³⁵⁶₂₃₅ ⁺ √  ∛

const modulations_vl = {
  "Sinus": 0,
  "Meandr 20%": 10020,
  "Half Meandr 20%": 20020,
};

const modulations = {
  "Line": 0,

  "Sinus 2¹⁰=1024 (V/√2)": 1024,

  "Sinus 2¹⁰=1024 V1": 10241,
  "Sinus 2¹⁰=1024 V/2": 10242,
  "Sinus 2¹⁰=1024 V/X": 10243,
  "Sinus 2¹⁰=1024 V/√X": 10244,

  "Dumped 2¹⁰=1024": -1024,

  "Sinus=1333": 1333,
  "Dumped=1333": -1333,

  "Sinus 3⁵=243": 243,
  "Dumped 3⁵=243": -243,

  "Sinus 3⁶=729": 729,
  "Dumped 3⁶=729": -729,

  "Sinus 5⁵=3125": 3125,
  "Dumped 5⁵=3125": -3125,

  /*
  add ^3
   */

  "Rife #3": 3,
  //If mod! (for example diffusor) not selected => 1024
  //If target=etherium =>  mod = diffusor
  //Else mod = targ->eth or eth -> targ
  "Macro Eth": 2,
  "Macro Target->Eth": 2,
  "Macro Eth->Target": 2,
};
