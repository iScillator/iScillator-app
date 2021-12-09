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
