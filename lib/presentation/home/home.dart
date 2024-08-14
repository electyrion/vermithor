import 'package:vermithor/data/sharedpref/constants/preferences.dart';
import 'package:vermithor/di/service_locator.dart';
import 'package:vermithor/presentation/home/store/language/language_store.dart';
import 'package:vermithor/presentation/home/store/theme/theme_store.dart';
import 'package:vermithor/presentation/post/post_list.dart';
import 'package:vermithor/utils/locale/app_localization.dart';
import 'package:vermithor/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //stores:---------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final LanguageStore _languageStore = getIt<LanguageStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: const PostListScreen(),
    );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(AppLocalizations.of(context).translate('home_tv_posts')),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
      _buildLanguageButton(),
      _buildThemeButton(),
      _buildLogoutButton(),
    ];
  }

  Widget _buildThemeButton() {
    return Observer(
      builder: (context) {
        return IconButton(
          onPressed: () {
            _themeStore.changeBrightnessToDark(!_themeStore.darkMode);
          },
          icon: Icon(
            _themeStore.darkMode ? Icons.brightness_5 : Icons.brightness_3,
          ),
        );
      },
    );
  }

  Widget _buildLogoutButton() {
    return IconButton(
      onPressed: () {
        SharedPreferences.getInstance().then((preference) {
          preference.setBool(Preferences.is_logged_in, false);
          Navigator.of(context).pushReplacementNamed(Routes.login);
        });
      },
      icon: const Icon(
        Icons.power_settings_new,
      ),
    );
  }

  Widget _buildLanguageButton() {
    return IconButton(
      onPressed: () {
        _showLanguageDialog();
      },
      icon: const Icon(Icons.language),
    );
  }

  void _showLanguageDialog() {
    Dialogs.materialDialog(
      context: context,
      title: AppLocalizations.of(context).translate('home_tv_choose_language'),
      // borderRadius: BorderRadius.circular(5.0),
      // title: Text(
      //   AppLocalizations.of(context).translate('home_tv_choose_language'),
      //   style: const TextStyle(
      //     color: Colors.white,
      //     fontSize: 16.0,
      //   ),
      // ),
      // headerColor: Theme.of(context).primaryColor,
      color: Theme.of(context).scaffoldBackgroundColor,
      customView: Column(
        mainAxisSize: MainAxisSize.min,
        children: _languageStore.supportedLanguages
            .map(
              (object) => ListTile(
                dense: true,
                contentPadding: const EdgeInsets.all(0.0),
                title: Text(
                  object.language,
                  style: TextStyle(
                    color: _languageStore.locale == object.locale
                        ? Theme.of(context).primaryColor
                        : _themeStore.darkMode
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // Change user language based on selected locale
                  _languageStore.changeLanguage(object.locale);
                },
              ),
            )
            .toList(),
      ),
      // ignore: deprecated_member_use
      actions: [
        IconsButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          text: 'Close',
          iconData: Icons.close,
          textStyle: const TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
      ],
    );
  }

  // Widget _buildLanguageButton() {
  //   return IconButton(
  //     onPressed: () {
  //       _buildLanguageDialog();
  //     },
  //     icon: Icon(
  //       Icons.language,
  //     ),
  //   );
  // }

//   _buildLanguageDialog() {
//   Dialogs.materialDialog(
//     context: context,
//     title: AppLocalizations.of(context).translate('home_tv_choose_language'),
//     titleStyle: TextStyle(
//       color: Colors.white,
//       fontSize: 16.0,
//     ),
//     // headerColor: Theme.of(context).primaryColor,
//     // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//     actions: _languageStore.supportedLanguages
//         .map(
//           (object) => IconsOutlineButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               // change user language based on selected locale
//               _languageStore.changeLanguage(object.locale!);
//             },
//             text: object.language!,
//             textStyle: TextStyle(
//               color: _languageStore.locale == object.locale
//                   ? Theme.of(context).primaryColor
//                   : _themeStore.darkMode
//                       ? Colors.white
//                       : Colors.black,
//             ),
//           ),
//         )
//         .toList(),
//     dialogShape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(5.0),
//     ),
//   );
// }

  // _buildLanguageDialog() {
  //   _showDialog<String>(
  //     context: context,
  //     child: MaterialDialog(
  //       borderRadius: 5.0,
  //       enableFullWidth: true,
  //       title: Text(
  //         AppLocalizations.of(context).translate('home_tv_choose_language'),
  //         style: TextStyle(
  //           color: Colors.white,
  //           fontSize: 16.0,
  //         ),
  //       ),
  //       headerColor: Theme.of(context).primaryColor,
  //       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  //       closeButtonColor: Colors.white,
  //       enableCloseButton: true,
  //       enableBackButton: false,
  //       onCloseButtonClicked: () {
  //         Navigator.of(context).pop();
  //       },
  //       children: _languageStore.supportedLanguages
  //           .map(
  //             (object) => ListTile(
  //               dense: true,
  //               contentPadding: EdgeInsets.all(0.0),
  //               title: Text(
  //                 object.language!,
  //                 style: TextStyle(
  //                   color: _languageStore.locale == object.locale
  //                       ? Theme.of(context).primaryColor
  //                       : _themeStore.darkMode
  //                           ? Colors.white
  //                           : Colors.black,
  //                 ),
  //               ),
  //               onTap: () {
  //                 Navigator.of(context).pop();
  //                 // change user language based on selected locale
  //                 _languageStore.changeLanguage(object.locale!);
  //               },
  //             ),
  //           )
  //           .toList(),
  //     ),
  //   );
  // }

  // _showDialog<T>({required BuildContext context, required Widget child}) {
  //   showDialog<T>(
  //     context: context,
  //     builder: (BuildContext context) => child,
  //   ).then<void>((T? value) {
  //     // The value passed to Navigator.pop() or null.
  //   });
  // }
}
