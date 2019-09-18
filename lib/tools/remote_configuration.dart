import 'package:firebase_remote_config/firebase_remote_config.dart';

class Config {
  Future<RemoteConfig> setupRemoteConfig() async {
    try {
      final RemoteConfig remoteConfig = await RemoteConfig.instance;
      remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: false));
      remoteConfig.setDefaults(<String, dynamic>{});
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
      return remoteConfig;
    } catch (error) {
      print(error);
      return null;
    }
  }
}

// To get the data from remote configuration
const String str_welcome = "str_welcome";
const String img_welcome = "img_welcome";
const String img_energy = "img_energy";
const String btn_welcome = "btn_welcome";
const String str_board1 = "str_board1";
const String img_board1 = "img_board1";
const String str_board2 = "str_board2";
const String img_board2 = "img_board2";
const String str_board2_txt1 = "str_board2_txt1";
const String str_board3 = "str_board3";
const String img_board3 = "img_board3";
const String app_logo = "app_logo";
const String str_sign_up_txt = "str_sign_up_txt";
const String str_sign_up_txt1 = "str_sign_up_txt1";
const String str_sign_up_txt2 = "str_sign_up_txt2";
const String str_sign_up_txt3 = "str_sign_up_txt3";
const String str_mood_low_energy = "low_energy_e";
const String str_mood_high_energy = "high_energy_e";
const String str_extra_key = "extra_key_e";
const String str_low_key = "low_key_e";

// To get the default data
const String def_str_welcome = "Get your monthly date night";
const String def_btn_welcome = "How it Works";
const String def_str_board1 = "You and your partner fill out a quick quiz";
const String def_str_board2 = "Every month you get a fresh bookable date night";
const String def_str_board2_txt1 =
    "Every month you get a fresh bookable date night";
const String def_str_board3 = "Make the time and see your love grow";
const String def_str_sign_up_txt = "Free forever. No credit card needed.";
const String def_str_sign_up_txt1 = "1 Monthly Date";
const String def_str_sign_up_txt2 =
    "Chosen for you and your partner, curated by local experts";
const String def_str_sign_up_txt3 = "HAPPINESS GUARANTEED";
const String def_str_mood_low_energy =
    "ie. spa, passages, lounges, films, picnics, etc.";
const String def_str_mood_high_energy =
    "i.e. concerts, skydiving, hiking, dancing, festivals, etc.";
const String def_str_extra_key =
    "ie. Sky-diving, private serenade with private chef and fireworks";
const String def_str_low_key = "ie. dive bar, isolated restaurant";
