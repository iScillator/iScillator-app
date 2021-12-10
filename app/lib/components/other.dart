/*
  static int audio = defaults["audio"];
  static int channel = defaults["channel"];
  static int enviroment = defaults["enviroment"];
  static int modulation = defaults["modulation"];
  static int multi = defaults["multi"];
  static int target = defaults["target"];

  int _selectedAudio = menu_rev["audios"].keys.toList().indexOf(audio);
  int _selectedChannel = menu_rev["channels"].keys.toList().indexOf(channel);
  int _selectedEnviroment =
      menu_rev["enviroments"].keys.toList().indexOf(enviroment);
  int _selectedModulation =
      menu_rev["modulations"].keys.toList().indexOf(modulation);
  int _selectedMulti = menu_rev["multis"].keys.toList().indexOf(multi);
  int _selectedTarget = menu_rev["targets"].keys.toList().indexOf(target);
    //log(audio);
    //print(menu.targets);
    print(menu);
    print(menu_rev);
    print(audio);
    print(_selectedAudio);
    //print(audios_rev);

    //test = 12345;
    //print(test);


*/

//Widget topSection = Column(children: [
//]);

//alignment: Alignment.center,

Widget _indicator(bool isActive) {
  return Container(
    height: 10,
    child: AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: isActive ? 10 : 8.0,
      width: isActive ? 12 : 8.0,
      decoration: BoxDecoration(
        boxShadow: [
          isActive
              ? BoxShadow(
                  color: Color(0XFF2FB7B2).withOpacity(0.72),
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
                  offset: Offset(
                    0.0,
                    0.0,
                  ),
                )
              : BoxShadow(
                  color: Colors.transparent,
                )
        ],
        shape: BoxShape.circle,
        color: isActive ? Color(0XFF6BC4C9) : Color(0XFFEAEAEA),
      ),
    ),
  );
}

List<Widget> _buildPageIndicator() {
  List<Widget> list = [];
  for (int i = 0; i < 2 /*YourListHere.length*/; i++) {
    list.add(i == 1 /*selectedindex*/ ? _indicator(true) : _indicator(false));
  }
  return list;
}

Widget settingsSection = Padding(
  padding: EdgeInsets.only(bottom: 30.0, top: 40.0),
  child: TextButton.icon(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SettingsScreen(
                      userSettings: userSettings,
                      prefs: prefs,
                    )));
      },
      icon: Icon(
        Icons.settings,
        size: 20,
      ),
      label: Text(AppLocalizations.of(context)!.settings), //, 'Settings'),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.white),
      )),
);



/*
  //TODO: save
  void _saveSettings() async {
    SharedPreferences? prefs = widget.prefs;
    if (prefs != null) {
      //await prefs.setInt('angle', widget.userSettings?.waveType ?? 0);
    } else {
      prefs = await SharedPreferences.getInstance();
      //await prefs.setInt('angle', widget.userSettings?.waveType ?? 0);
    }
  }
*/

/*
  Future<UserSettings> _getSettings() async {
        //double? balance = prefs?.getDouble('balance');
    //int? waveType = prefs?.getInt('waveType');

    //int? angle = prefs?.getInt('angle');

    //return
    return UserSettings(balance, waveType, angle);
  }*/

  void setButtons() {
/*
  // TODO: add selection
  int _selectedAudio = menu_rev["audios"].keys.toList().indexOf(audio);
  int _selectedChannel = menu_rev["channels"].keys.toList().indexOf(channel);
  int _selectedEnviroment =
      menu_rev["enviroments"].keys.toList().indexOf(enviroment);
  int _selectedModulation =
      menu_rev["modulations"].keys.toList().indexOf(modulation);
  int _selectedMulti = menu_rev["multis"].keys.toList().indexOf(multi);
  int _selectedTarget = menu_rev["targets"].keys.toList().indexOf(target);
     */
  }
}



 
  void _selectAudio(int num) {
    setState(() {
      if (num == -1) {
        _isPresetWindowAudiosShown = false;
      } else {
        _selectedAudio = num;
        audio = menu["audios"].values.toList()[num];
        _isPresetWindowAudiosShown = false;
        setParams();
      }
    });
  }

  void _selectChannel(int num) {
    setState(() {
      if (num == -1) {
        _isPresetWindowChannelsShown = false;
      } else {
        _selectedChannel = num;
        channel = menu["channels"].values.toList()[num];
        _isPresetWindowChannelsShown = false;
        setParams();
      }
    });
  }

  void _selectEnviroment(int num) {
    setState(() {
      if (num == -1) {
        _isPresetWindowEnviromentsShown = false;
      } else {
        _selectedEnviroment = num;
        enviroment = menu["enviroments"].values.toList()[num];
        _isPresetWindowEnviromentsShown = false;
        setParams();
      }
    });
  }

  void _selectModulation(int num) {
    setState(() {
      if (num == -1) {
        _isPresetWindowModulationsShown = false;
      } else {
        _selectedModulation = num;
        modulation = menu["modulations"].values.toList()[num];
        _isPresetWindowModulationsShown = false;
        setParams();
      }
    });
  }

  void _selectMulti(int num) {
    setState(() {
      if (num == -1) {
        _isPresetWindowMultisShown = false;
      } else {
        _selectedMulti = num;
        multi = menu["multis"].values.toList()[num];
        _isPresetWindowMultisShown = false;
        setParams();
      }
    });
  }

  void _selectTarget(int num) {
    setState(() {
      if (num == -1) {
        _isPresetWindowTargetsShown = false;
      } else {
        _selectedTarget = num;
        target = menu["targets"].values.toList()[num];
        _isPresetWindowTargetsShown = false;
        setParams();
      }
    });
  }

