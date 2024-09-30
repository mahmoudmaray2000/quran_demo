import 'package:alquranalkareem/quran_text/cubit/quran_text_cubit.dart';
import 'package:alquranalkareem/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:theme_provider/theme_provider.dart';
import '../../cubit/ayaRepository/aya_cubit.dart';
import '../../l10n/app_localizations.dart';
import '../../quran_page/data/model/aya.dart';
import '../../shared/widgets/lottie.dart';
import '../cubit/surah_text_cubit.dart';
import '../model/QuranModel.dart';
import '../text_page_view.dart';

class QuranTextSearch extends StatefulWidget {
  late Function onSubmitted;

  QuranTextSearch({super.key});

  @override
  _QuranTextSearchState createState() => _QuranTextSearchState();
}

class _QuranTextSearchState extends State<QuranTextSearch> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    QuranTextCubit TextCubit = QuranTextCubit.get(context);
    return Column(
      children: <Widget>[
        topBar(context),
        Container(
          height: 60,
          padding:
              const EdgeInsets.only(top: 8, right: 30, left: 30, bottom: 8),
          child: TextField(
            textAlign: TextAlign.start,
            controller: _controller,
            autofocus: true,
            cursorHeight: 18,
            cursorWidth: 3,
            cursorColor: Theme.of(context).dividerColor,
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              context.read<AyaCubit>().search(value);
            },
            onChanged: (value) {
              context.read<AyaCubit>().search(value);
            },
            style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontFamily: 'kufi',
                fontSize: 15),
            decoration: InputDecoration(
              icon: IconButton(
                onPressed: () => _controller.clear(),
                icon: Icon(
                  Icons.clear,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.surface),
              ),
              hintText: AppLocalizations.of(context)!.search_word,
              label: Text(
                AppLocalizations.of(context)!.search_word,
                style: TextStyle(color: Theme.of(context).colorScheme.surface),
              ),
              hintStyle: TextStyle(
                  // height: 1.5,
                  color: Theme.of(context).primaryColorLight.withOpacity(0.5),
                  fontFamily: 'kufi',
                  fontWeight: FontWeight.normal,
                  decorationColor: Theme.of(context).primaryColor,
                  fontSize: 14),
              contentPadding: const EdgeInsets.only(right: 16, left: 16),
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<AyaCubit, AyaState>(
            builder: (context, state) {
              if (state is AyaLoading) {
                return search(200.0, 200.0);
              } else if (state is AyaLoaded) {
                final List<Aya> ayahList = state.ayahList;
                return Container(
                    child: ayahList != null
                        ? BlocBuilder<SurahTextCubit, List<SurahText>?>(
                            builder: (context, state) {
                              if (state == null) {
                                return Center(
                                  child: loadingLottie(200.0, 200.0),
                                );
                              }
                              return ListView.builder(
                                  itemCount: ayahList.length,
                                  itemBuilder: (_, index) {
                                    Aya aya = ayahList[index];
                                    return Column(
                                      children: <Widget>[
                                        Container(
                                          color: (index % 2 == 0
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .surface
                                                  .withOpacity(.05)
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .surface
                                                  .withOpacity(.1)),
                                          child: ListTile(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              Navigator.of(context).push(
                                                  animatRoute(TextPageView(
                                                surah: state[aya.sorahId - 1],
                                                nomPageF: state[aya.sorahId - 1]
                                                    .ayahs!
                                                    .first
                                                    .page!,
                                                nomPageL: state[aya.sorahId - 1]
                                                    .ayahs!
                                                    .last
                                                    .page!,
                                                pageNum: TextCubit.value == 1
                                                    ? (state[aya.sorahId - 1]
                                                            .ayahs![
                                                                aya.ayaNum - 1]
                                                            .numberInSurah! -
                                                        1)
                                                    : state[aya.sorahId - 1]
                                                        .ayahs![aya.ayaNum - 1]
                                                        .pageInSurah!,
                                              )));
                                              print('${state[aya.sorahId]}');
                                              print(
                                                  '${state[aya.sorahId].ayahs!.first.page!}');
                                              print(
                                                  '${state[aya.sorahId].ayahs!.last.page!}');
                                              print('pageNum: ${aya.pageNum}');
                                            },
                                            title: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                aya.text,
                                                style: TextStyle(
                                                  fontFamily: "uthmanic2",
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 22,
                                                  color: ThemeProvider.themeOf(
                                                                  context)
                                                              .id ==
                                                          'dark'
                                                      ? Theme.of(context)
                                                          .canvasColor
                                                      : Theme.of(context)
                                                          .primaryColorDark,
                                                ),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                            subtitle: Container(
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColorLight,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(4))),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topRight:
                                                                Radius.circular(
                                                                    4),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    4),
                                                          )),
                                                      child: Text(
                                                        aya.sorahName,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: ThemeProvider.themeOf(
                                                                            context)
                                                                        .id ==
                                                                    'dark'
                                                                ? Theme.of(
                                                                        context)
                                                                    .canvasColor
                                                                : Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .background,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                        color: Theme.of(context)
                                                            .primaryColorLight,
                                                        child: Text(
                                                          " ${AppLocalizations.of(context)!.part}: ${aya.partNum}",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: ThemeProvider.themeOf(
                                                                              context)
                                                                          .id ==
                                                                      'dark'
                                                                  ? Theme.of(
                                                                          context)
                                                                      .canvasColor
                                                                  : Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .background,
                                                              fontSize: 12),
                                                        )),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          4),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          4),
                                                                )),
                                                        child: Text(
                                                          " ${AppLocalizations.of(context)!.page}: ${aya.pageNum}",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: ThemeProvider.themeOf(
                                                                              context)
                                                                          .id ==
                                                                      'dark'
                                                                  ? Theme.of(
                                                                          context)
                                                                      .canvasColor
                                                                  : Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .background,
                                                              fontSize: 12),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Divider()
                                      ],
                                    );
                                  });
                            },
                          )
                        : Lottie.asset('assets/lottie/search.json',
                            width: 200, height: 200));
              } else if (state is AyaError) {
                return notFound();
              }
              return Container(); // Fallback to an empty container.
            },
          ),
        ),
      ],
    );
  }
}

Widget ayaNum(context, Color color, String num) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
            height: 35,
            width: 35,
            child: SvgPicture.asset('assets/svg/ayah_no.svg')),
        Text(
          num,
          style:
              TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    ),
  );
}
