import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth/flutterbluetooth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'AnimatedSwitcherCounterRoute.dart';
import 'AnimatedSwitcherCounterRouteChildView.dart';
import 'FloorTestPage.dart';
import 'LikeButtonView.dart';
import 'SocketView.dart';
import 'TDCTestView.dart';
import 'TestAView.dart';
import 'bluetooth/FlutterBlueView.dart';
import 'bluetooth/FlutterBluetoothView.dart';
import 'dao/DBService.dart';
import 'local/LocaleUtil.dart';
import 'local/translations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());
class DateFormats {
  static String full = "yyyy-MM-dd HH:mm:ss";
  static String y_mo_d_h_m = "yyyy-MM-dd HH:mm";
  static String y_mo_d = "yyyy-MM-dd";
  static String y_mo = "yyyy-MM";
  static String mo_d = "MM-dd";
  static String mo_d_h_m = "MM-dd HH:mm";
  static String h_m_s = "HH:mm:ss";
  static String h_m = "HH:mm";

  static String zh_full = "yyyy年MM月dd日 HH时mm分ss秒";
  static String zh_y_mo_d_h_m = "yyyy年MM月dd日 HH时mm分";
  static String zh_y_mo_d = "yyyy年MM月dd日";
  static String zh_y_mo = "yyyy年MM月";
  static String zh_mo_d = "MM月dd日";
  static String zh_mo_d_h_m = "MM月dd日 HH时mm分";
  static String zh_h_m_s = "HH时mm分ss秒";
  static String zh_h_m = "HH时mm分";
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
//class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Widget logoWidget = Image.asset(
    'images/start.png',
    fit: BoxFit.fill,
  );

  Widget getDefultView (BuildContext context){
    print('22222222222222' + formatDate(DateTime.now(),format: 'yyyy-MM-dd HH:mm:ss:SSS'));
//    getDefultView(context);
    return logoWidget;
  }

  goNextView(BuildContext context) async{
    Navigator.of(context).push(
        PageRouteBuilder(
            opaque:false,
            pageBuilder: (context, animation, secondaryAnimation) {
              return MyHomePage();
            }
        ));
  }

  static String formatDate(DateTime dateTime, {String format}) {
    if (dateTime == null) return "";
    format = format ?? DateFormats.full;
    if (format.contains("yy")) {
      String year = dateTime.year.toString();
      if (format.contains("yyyy")) {
        format = format.replaceAll("yyyy", year);
      } else {
        format = format.replaceAll(
            "yy", year.substring(year.length - 2, year.length));
      }
    }

    format = _comFormat(dateTime.month, format, 'M', 'MM');
    format = _comFormat(dateTime.day, format, 'd', 'dd');
    format = _comFormat(dateTime.hour, format, 'H', 'HH');
    format = _comFormat(dateTime.minute, format, 'm', 'mm');
    format = _comFormat(dateTime.second, format, 's', 'ss');
    format = _comFormat(dateTime.millisecond, format, 'S', 'SSS');

    return format;
  }

  /// com format.
  static String _comFormat(
      int value, String format, String single, String full) {
    if (format.contains(single)) {
      if (format.contains(full)) {
        format =
            format.replaceAll(full, value < 10 ? '0$value' : value.toString());
      } else {
        format = format.replaceAll(single, value.toString());
      }
    }
    return format;
  }
  SpecificLocalizationDelegate _localeOverrideDelegate;
  TranslationsDelegate translationsDelegate;
  Iterable<LocalizationsDelegate<dynamic>> localizationsDelegatesList;
  initTranslationsDelegate() async{
    print('00000000000000' + DateUtil.formatDate(DateTime.now(),format: 'yyyy-MM-dd HH:mm:ss:SSS'));
    _localeOverrideDelegate = new SpecificLocalizationDelegate(null);
    localeUtil.onLocaleChanged = onLocaleChange;
    translationsDelegate = TranslationsDelegate();

    localizationsDelegatesList = [
//        const TranslationsDelegate(),
      translationsDelegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate, //国际化

      const FallbackCupertinoLocalisationsDelegate(),
    ];
  }

  onLocaleChange(Locale locale) async {
//  onLocaleChange(Locale locale) {
    print('onLocaleChange000000000' + DateUtil.formatDate(DateTime.now(),format: 'yyyy-MM-dd HH:mm:ss:SSS'));
    SpUtil.putString("lang", locale.languageCode);
    print('onLocaleChange--'+locale.languageCode);
    print('_countryCode--'+locale.countryCode);
//    Future.delayed(Duration(milliseconds: 200)).then((e) {
////      setState(() {
    print('onLocaleChange111100000' + DateUtil.formatDate(DateTime.now(),format: 'yyyy-MM-dd HH:mm:ss:SSS'));
    _localeOverrideDelegate = SpecificLocalizationDelegate(locale);
    print('onLocaleChange222200000' + DateUtil.formatDate(DateTime.now(),format: 'yyyy-MM-dd HH:mm:ss:SSS'));
//    if(countInt == 0){
////          Navigator.of(context)
////              .push(new MaterialPageRoute(builder: (context) {
////            return SplashScreen();
////            }));
//      Future.delayed(Duration(milliseconds: 20)).then((e) {
//        setState(() {
//          canOpenSplashScreen = true;
//        });
//      });
//    }
//
////      });
//    });
  }

//  @override
//  void initState() {
//    super.initState();
//    initTranslationsDelegate();
////    checkPermission();
//  }

  var canWrite = false;//是否能写日志

  checkPermission() async {
    if (Platform.isAndroid) {
//      if(!canWrite){
//        //权限申请被拒绝
//        Future.delayed(Duration(milliseconds: 500)).then((e) {
//            checkPermission();
//        });
//
//      }

      // 申请结果
      bool pStorage = await Permission.storage.isGranted;
      bool pCamera = await Permission.camera.isGranted;
      if (pStorage && pCamera) {
        //权限申请通过
        canWrite = true;

        initBaseData();
      }else{
        //权限申请被拒绝
        Future.delayed(Duration(milliseconds: 500)).then((e) {
          checkPermission();
        });
      }
    }else if(Platform.isIOS){
      initBaseData();
    }
  }


  var canInit = false;
  initBaseData() async {
    if(canInit){
      return;
    }
    try {
      await SpUtil.getInstance(); //等待Sp初始化完成

      var tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;

      var appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;

      String storageDirectoryPath = "";
      if (Platform.isAndroid) {
        var storageDir = await getExternalStorageDirectory();
        storageDirectoryPath = storageDir.path;
      }

      SpUtil.putString("tempPath", tempPath);
      SpUtil.putString("appDocPath", appDocPath);
      SpUtil.putString("storagePath", storageDirectoryPath);
      SpUtil.putString(
          "saveApkPath", storageDirectoryPath + "/EhsureBrands.apk");

      //日志目录
      if (Platform.isAndroid) {
        SpUtil.putString(
            "appLogPath", storageDirectoryPath + "/platform_brands_flutter_log");
      }else if(Platform.isIOS){
        SpUtil.putString(
            "appLogPath", tempPath + "/platform_brands_flutter_log");
        canWrite = true;
      }

//      if (TextUtil.isEmpty(SpUtil.getString('deviceId', defValue: ''))) {
//        SpUtil.putString("deviceId", Uuid().v1());
//      }
//
//      LogFileUtil.printLog('临时目录: ' + tempPath);
//      LogFileUtil.printLog('文档目录: ' + appDocPath);
//      LogFileUtil.printLog('SD目录: ' + storageDirectoryPath);


//      if(Platform.isIOS){
//        SpUtil.putString("terminalType", "3");
//      } else if (Platform.isAndroid) {
//        if(SharedPreferenceUtil.isPhone()){
//          SpUtil.putString("terminalType", "2");
//        } else {
//          SpUtil.putString("terminalType", "1");
//        }
//      }
//
//      PackageInfo packageInfo = await PackageInfo.fromPlatform();
//      String localVersion = packageInfo.version;
//      String appName = packageInfo.appName;
//      String packageName = packageInfo.packageName;
//      String buildNumber = packageInfo.buildNumber.toString();
//      SpUtil.putString("localVersion", localVersion);
//      SpUtil.putString("appName", appName);
//      SpUtil.putString("packageName", packageName);
//      SpUtil.putString("buildNumber", buildNumber);
//
//      DioManager.getInstance(context);

      setState(() {
        print('setState!!!!!!!!!!' + DateUtil.formatDate(DateTime.now(),format: 'yyyy-MM-dd HH:mm:ss:SSS'));
        canInit = true;
      });
    } on Exception catch (err) {
      checkPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    print('1111111111111111' + formatDate(DateTime.now(),format: 'yyyy-MM-dd HH:mm:ss:SSS'));
//    if(canInit){
      initTranslationsDelegate();
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: localizationsDelegatesList,

        supportedLocales: localeUtil.supportedLocales(),
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          //原生系统切换语言会进入这个Callback
          //国际化设置说明
//        http://zhoushaoting.com/2019/06/11/%E7%A7%BB%E5%8A%A8%E7%AB%AF%E5%AD%A6%E4%B9%A0/Flutter~%E5%9B%BD%E9%99%85%E5%8C%96%E6%95%99%E7%A8%8B%E6%96%B9%E6%A1%88/index.html
          String lang = null;
          try {
            lang = SpUtil.getString("lang");
          } catch (err) {
            lang = null;
          }
          if (TextUtil.isEmpty(lang)||(SpUtil.getBool("isAuto")!=null&&SpUtil.getBool("isAuto"))) {
            print('deviceLocale: $deviceLocale');
            List dlStrList = deviceLocale.toString().split("_");
            String dlStr = dlStrList[0];
            SpUtil.putString("lang", dlStr);
            SpUtil.putString("deviceLang", dlStr);
            if(deviceLocale.toString().indexOf("zh")!=-1){
              //针对 zh_Hans_CN 这种情况
              SpUtil.putString("deviceLanguage", 'zh_cn');
              SpUtil.putString("currentLanguage", 'zh_cn');
            }else if(deviceLocale.toString().indexOf("en")!=-1){
              //针对 zh_Hans_CN 这种情况
              SpUtil.putString("deviceLanguage", 'en_us');
              SpUtil.putString("currentLanguage", 'en_us');
            }else {
              SpUtil.putString("deviceLanguage", deviceLocale.toString());
              SpUtil.putString("currentLanguage", deviceLocale.toString());
            }
            localeUtil
                .onLocaleChanged(Locale(dlStr, dlStrList[dlStrList.length - 1]));
            print('localeResolutionCallback555555555' + DateUtil.formatDate(DateTime.now(),format: 'yyyy-MM-dd HH:mm:ss:SSS'));
          } else {
            localeUtil.onLocaleChanged(Locale(lang, ''));
            print('localeResolutionCallback6666666' + DateUtil.formatDate(DateTime.now(),format: 'yyyy-MM-dd HH:mm:ss:SSS'));
          }
        },
//      home:getDefultView(context),
//         home: MyHomePage(title: 'Flutter Demo Home Page'),
//      home: AnimatedSwitcherCounterRoute(),
//      home: AnimatedSwitcherCounterRouteChildView(),
//      home: TestAView(),
//      home: SocketView(),
//      home: LikeButtonView(),
//      home: FloorTestPage(),
     home: TDCTestView(),
      );
//    }else{
//      checkPermission();
//      return logoWidget;
//    }

  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  // ignore: must_call_super
  initState(){
    MethodChannel _channel = new MethodChannel('flutterbluetooth');
    _channel.setMethodCallHandler((handler) {
      print(handler.method);
    });
  }

  static String formatDate(DateTime dateTime, {String format}) {
    if (dateTime == null) return "";
    format = format ?? DateFormats.full;
    if (format.contains("yy")) {
      String year = dateTime.year.toString();
      if (format.contains("yyyy")) {
        format = format.replaceAll("yyyy", year);
      } else {
        format = format.replaceAll(
            "yy", year.substring(year.length - 2, year.length));
      }
    }

    format = _comFormat(dateTime.month, format, 'M', 'MM');
    format = _comFormat(dateTime.day, format, 'd', 'dd');
    format = _comFormat(dateTime.hour, format, 'H', 'HH');
    format = _comFormat(dateTime.minute, format, 'm', 'mm');
    format = _comFormat(dateTime.second, format, 's', 'ss');
    format = _comFormat(dateTime.millisecond, format, 'S', 'SSS');

    return format;
  }

  /// com format.
  static String _comFormat(
      int value, String format, String single, String full) {
    if (format.contains(single)) {
      if (format.contains(full)) {
        format =
            format.replaceAll(full, value < 10 ? '0$value' : value.toString());
      } else {
        format = format.replaceAll(single, value.toString());
      }
    }
    return format;
  }


  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('33333333333' + formatDate(DateTime.now(),format: 'yyyy-MM-dd HH:mm:ss:SSS'));
    DBService.getInstance();

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            GestureDetector(
              onTap: (){
//                  Navigator.of(context).push(
//                    new MaterialPageRoute(
//                      builder: (context) {
//                        return TestBView();
//                      },
//                    ),
//                  );

                Navigator.of(context).push(
                    PageRouteBuilder(
                        opaque:false,
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return FloorTestPage();
                        }
                    ));
              },
              child: Text(
                  '打开B页面'
              ),
            ),
            GestureDetector(
              onTap: (){

//                Navigator.of(context).push(
//                    PageRouteBuilder(
//                        opaque:false,
//                        pageBuilder: (context, animation, secondaryAnimation) {
//                          return FlutterBlueView();
//                        }
//                    ));
              },
              child: Text(
                  '蓝牙'
              ),
            ),
            GestureDetector(
              onTap: (){
                Flutterbluetooth.init();

                Navigator.of(context).push(
                    PageRouteBuilder(
                        opaque:false,
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return FlutterBluetoothView();
                        }
                    ));
              },
              child: Text(
                  'FlutterBluetoothView'
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
class FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      loadCupertinoLocalizations(locale);

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}

class CustomZhCupertinoLocalizations extends DefaultCupertinoLocalizations {
  const CustomZhCupertinoLocalizations();

  @override
  String datePickerMinuteSemanticsLabel(int minute) {
    if (minute == 1) return '1 分钟';
    return minute.toString() + ' 分钟';
  }

  @override
  String get anteMeridiemAbbreviation => '上午';

  @override
  String get postMeridiemAbbreviation => '下午';

  @override
  String get alertDialogLabel => '警告';

  @override
  String timerPickerHourLabel(int hour) => '小时';

  @override
  String timerPickerMinuteLabel(int minute) => '分';

  @override
  String timerPickerSecond(int second) => '秒';

  @override
  String get cutButtonLabel => '裁剪';

  @override
  String get copyButtonLabel => '复制';

  @override
  String get pasteButtonLabel => '粘贴';

  @override
  String get selectAllButtonLabel => '全选';
}

class CustomTCCupertinoLocalizations extends DefaultCupertinoLocalizations {
  const CustomTCCupertinoLocalizations();

  @override
  String datePickerMinuteSemanticsLabel(int minute) {
    if (minute == 1) return '1 分鐘';
    return minute.toString() + ' 分鐘';
  }

  @override
  String get anteMeridiemAbbreviation => '上午';

  @override
  String get postMeridiemAbbreviation => '下午';

  @override
  String get alertDialogLabel => '警告';

  @override
  String timerPickerHourLabel(int hour) => '小时';

  @override
  String timerPickerMinuteLabel(int minute) => '分';

  @override
  String timerPickerSecond(int second) => '秒';

  @override
  String get cutButtonLabel => '裁剪';

  @override
  String get copyButtonLabel => '復制';

  @override
  String get pasteButtonLabel => '粘貼';

  @override
  String get selectAllButtonLabel => '全選';
}

Future<CupertinoLocalizations> loadCupertinoLocalizations(Locale locale) {
  CupertinoLocalizations localizations;
  if (locale.languageCode == "zh") {
    switch (locale.countryCode) {
      case 'HK':
      case 'TW':
        localizations = CustomTCCupertinoLocalizations();
        break;
      default:
        localizations = CustomZhCupertinoLocalizations();
    }
  } else {
    localizations = DefaultCupertinoLocalizations();
  }
  return SynchronousFuture<CupertinoLocalizations>(localizations);
}