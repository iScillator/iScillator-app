
import '/config/audios.dart';
import '/config/channels.dart';
import '/config/enviroments.dart';
import '/config/oscillators.dart';
import '/config/emmiters.dart';
import '/config/modulations.dart';
import '/config/multis.dart';
import '/config/targets.dart';
import '/config/programs.dart';
import '/config/angles.dart';
import '/config/categories.dart';
import '/config/folders.dart';
import '/config/defaults.dart';

const defaults_app_vl = defaults_vl;
const defaults_app_dev = defaults_dev;
const defaults_app_pro = defaults_pro;
const defaults_app_lite = defaults_dev;

const forces_app_vl=forces_vl;
const forces_app_lite=forces;
const forces_app_pro={};
const forces_app_dev={};


const categories_app=categories;
const folders_app=folders;

// Для первичной публикации в продакшне(сторах), без пугающих названий!
const programs_app_prod = {
  ...programs_full
};

const programs_app_lite = {
  ...programs_full
};


const programs_app_pro = {
  ...programs_full
};

const programs_app_dev = {
  ...programs_full
};

const programs_app_vl = {
  ...programs_vl,
  ...programs_full
};


const targets_app_vl = targets_vl;
const targets_app_lite = {...targets_chackras};
const targets_app_pro = {...targets_chackras, ...targets_rife_audio, ...targets_rife_radio};
const targets_app_dev = {...targets_dev, ...targets_chackras, ...targets_rife_audio, ...targets_rife_radio};



const modulations_app_vl = modulations_vl;
const modulations_app=modulations;

const multis_app=multis;
const angles_app=angles;
const audios_app=audios;
const channels_app=channels;
const enviroments_app=enviroments;
const emmiters_app=emmiters;
const oscillators_app=oscillators;
