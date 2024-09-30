import 'package:alquranalkareem/quran_text/sorah_list_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hijri/hijri_calendar.dart';
import '../cubit/cubit.dart';
import '../shared/widgets/widgets.dart';
import 'Widgets/widgets.dart';

class SorahTextScreen extends StatefulWidget {
  SorahTextScreen({Key? key}) : super(key: key);

  @override
  State<SorahTextScreen> createState() => _SorahTextScreenState();
}

class _SorahTextScreenState extends State<SorahTextScreen> {
  var sorahListKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    QuranCubit.get(context).loadQuranFontSize();
    QuranCubit.get(context).updateGreeting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    QuranCubit cubit = QuranCubit.get(context);
    return AnimatedBuilder(
      animation: cubit.screenAnimation!,
      builder: (context, child) {
        return Transform.scale(
          scale: cubit.screenAnimation!.value,
          child: child,
        );
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          key: sorahListKey,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: platformView(
                orientation(
                  context,
                  Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: orientation == Orientation.portrait
                              ? const EdgeInsets.only(
                                  right: 16.0, left: 16.0, top: 40.0)
                              : const EdgeInsets.only(right: 16.0, left: 16.0),
                          child: topBar(),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        height: 1,
                        thickness: 2,
                        endIndent: 16,
                        indent: 16,
                      ),
                      Expanded(
                        flex: 7,
                        child: SizedBox(
                            // height: MediaQuery.of(context).size.height * 3 / 4,
                            width: MediaQuery.of(context).size.width,
                            child: const SorahListText()),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: SizedBox(
                            // height: MediaQuery.of(context).size.height * 3 / 4,
                            width: MediaQuery.of(context).size.width,
                            child: const SorahListText()),
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: orientation == Orientation.portrait
                              ? const EdgeInsets.only(
                                  right: 16.0, left: 16.0, top: 40.0)
                              : const EdgeInsets.only(right: 16.0, left: 16.0),
                          child: topBar(),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Expanded(
                      flex: 5,
                      child: SorahListText(),
                    ),
                    Expanded(
                      flex: 5,
                      child: SizedBox(child: topBar()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget topBar() {
    var _today = HijriCalendar.now();
    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: .1,
          child: SvgPicture.asset(
            'assets/svg/hijri/${_today.hMonth}.svg',
            width: MediaQuery.of(context).size.width,
            colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.surface, BlendMode.srcIn),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: platformView(100.0, 150.0),
            width: platformView(110.0, 160.0),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                    color: Theme.of(context).colorScheme.surface, width: 1)),
            padding: const EdgeInsets.only(top: 4),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: platformView(50.0, 75.0),
                  width: platformView(105.0, 155.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8),
                      )),
                ),
                hijriDate2(context),
              ],
            ),
          ),
        ),
        orientation(
          context,
          Align(
            alignment: Alignment.bottomLeft,
            child: greeting(context),
          ),
          Align(
            alignment: Alignment.topRight,
            child: greeting(context),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Row(
            children: [
              bookmarksTextList(
                  context,
                  sorahListKey,
                  orientation(
                      context,
                      MediaQuery.of(context).size.width * .9,
                      platformView(MediaQuery.of(context).size.width * .5,
                          MediaQuery.of(context).size.width * .5))),
              quranTextSearch(
                  context,
                  sorahListKey,
                  orientation(
                      context,
                      MediaQuery.of(context).size.width * .9,
                      platformView(MediaQuery.of(context).size.width * .5,
                          MediaQuery.of(context).size.width * .5))),
              notesList(
                  context,
                  orientation(
                      context,
                      MediaQuery.of(context).size.width * .9,
                      platformView(MediaQuery.of(context).size.width * .5,
                          MediaQuery.of(context).size.width * .5))),
            ],
          ),
        ),
      ],
    );
  }
}
