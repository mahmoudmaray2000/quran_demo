import 'package:alquranalkareem/notes/model/Notes.dart';
import 'package:alquranalkareem/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:theme_provider/theme_provider.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/hero_dialog_route.dart';
import '../../shared/widgets/lottie.dart';
import '../../shared/widgets/settings_popUp.dart';
import '../cubit/note_cubit.dart';
import '../cubit/note_state.dart';

class NotesList extends StatefulWidget {
  const NotesList({Key? key}) : super(key: key);

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    context.read<NotesCubit>().getNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double paddingHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                topBar(context),
                const Divider(),
              ],
            )),
        Padding(
          padding: EdgeInsets.only(
              top: orientation(context, 150.0, platformView(32.0, 150.0)),
              right: 16.0,
              left: 16.0),
          child: ListView(
            controller: _controller,
            children: [
              ExpansionTile(
                iconColor: Theme.of(context).secondaryHeaderColor,
                trailing: Icon(
                  Icons.add,
                  color: Theme.of(context).secondaryHeaderColor,
                  size: 20,
                ),
                title: Text(
                  AppLocalizations.of(context)!.add_new_note,
                  style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 14,
                      fontFamily: 'kufi'),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          textAlign: TextAlign.start,

                          controller:
                              context.read<NotesCubit>().titleController,
                          autofocus: true,
                          cursorHeight: 18,
                          cursorWidth: 3,
                          cursorColor: Theme.of(context).dividerColor,
                          onChanged: (value) {
                            setState(() {
                              context.read<NotesCubit>().title = value.trim();
                            });
                          },
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.surface,
                              fontFamily: 'kufi',
                              fontSize: 12),
                          decoration: InputDecoration(
                            icon: IconButton(
                              onPressed: () => context
                                  .read<NotesCubit>()
                                  .titleController
                                  .clear(),
                              icon: Icon(
                                Icons.clear,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.surface),
                            ),
                            hintText: AppLocalizations.of(context)!.note_title,
                            label: Text(
                              AppLocalizations.of(context)!.note_title,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface),
                            ),
                            hintStyle: TextStyle(
                                // height: 1.5,
                                color: Theme.of(context)
                                    .primaryColorLight
                                    .withOpacity(0.5),
                                fontFamily: 'kufi',
                                fontWeight: FontWeight.normal,
                                decorationColor: Theme.of(context).primaryColor,
                                fontSize: 12),
                            contentPadding:
                                const EdgeInsets.only(right: 16, left: 16),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          textAlign: TextAlign.start,
                          controller:
                              context.read<NotesCubit>().descriptionController,
                          autofocus: true,
                          cursorHeight: 18,
                          cursorWidth: 3,
                          cursorColor: Theme.of(context).dividerColor,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          onChanged: (value) {
                            setState(() {
                              context.read<NotesCubit>().description =
                                  value.trim();
                            });
                          },
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.surface,
                              fontFamily: 'kufi',
                              fontSize: 12),
                          decoration: InputDecoration(
                            icon: IconButton(
                              onPressed: () => context
                                  .read<NotesCubit>()
                                  .descriptionController
                                  .clear(),
                              icon: Icon(
                                Icons.clear,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.surface),
                            ),
                            hintText:
                                AppLocalizations.of(context)!.note_details,
                            label: Text(
                              AppLocalizations.of(context)!.note_details,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface),
                            ),
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .primaryColorLight
                                    .withOpacity(0.5),
                                fontFamily: 'kufi',
                                fontWeight: FontWeight.normal,
                                decorationColor: Theme.of(context).primaryColor,
                                fontSize: 12),
                            contentPadding:
                                const EdgeInsets.only(right: 16, left: 16),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.surface,
                                side: BorderSide(
                                  width: 1.0,
                                  color: Theme.of(context).dividerColor,
                                )),
                            onPressed: () {
                              context.read<NotesCubit>().validate(context);
                              context.read<NotesCubit>().getNotes();
                              context
                                  .read<NotesCubit>()
                                  .titleController
                                  .clear();
                              context
                                  .read<NotesCubit>()
                                  .descriptionController
                                  .clear();
                            },
                            child: Text(
                              AppLocalizations.of(context)!.save,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.background),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              AnimationLimiter(
                child: BlocBuilder<NotesCubit, NotesState>(
                  buildWhen: (previous, current) =>
                      previous.notes != current.notes,
                  builder: (context, state) {
                    return state.notes.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                        controller: _controller,
                            itemCount: state.notes.length,
                            itemBuilder: (BuildContext context, int index) {
                              final note = context
                                  .read<NotesCubit>()
                                  .state
                                  .notes[index];
                              return Column(
                                children: [
                                  AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 450),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0, vertical: 8.0),
                                          child: Dismissible(
                                            background: Container(
                                              decoration: const BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(8))),
                                              child: delete(context),
                                            ),
                                            key: UniqueKey(),
                                            onDismissed: (DismissDirection
                                                direction) async {
                                              await context
                                                  .read<NotesCubit>()
                                                  .deleteNotes(note.description!);
                                            },
                                            child: GestureDetector(
                                              onTap: () {
                                                // Get the note at the current index
                                                var note = state.notes[index];

                                                // Set the text fields to the current note's values
                                                context
                                                    .read<NotesCubit>()
                                                    .titleController
                                                    .text = note.title!;
                                                context
                                                    .read<NotesCubit>()
                                                    .descriptionController
                                                    .text = note.description!;

                                                // Navigate to the noteUpdate widget for this note
                                                Navigator.of(context).push(
                                                    HeroDialogRoute(
                                                        builder: (context) {
                                                  return settingsPopupCard(
                                                    child:
                                                        noteUpdate(context, note),
                                                    height: orientation(
                                                        context,
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            1 /
                                                            2,
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            1 /
                                                            2 *
                                                            1.6),
                                                    alignment:
                                                        Alignment.topCenter,
                                                    padding: orientation(
                                                        context,
                                                        EdgeInsets.only(
                                                            top: paddingHeight *
                                                                .08,
                                                            right: 16.0,
                                                            left: 16.0),
                                                        const EdgeInsets.only(
                                                            top: 70.0,
                                                            right: 16.0,
                                                            left: 16.0)),
                                                  );
                                                }));
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .surface
                                                        .withOpacity(.2),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(8))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(16.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        state.notes[index].title!,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontFamily: 'uthmanic2',
                                                          color: ThemeProvider.themeOf(
                                                                          context)
                                                                      .id ==
                                                                  'dark'
                                                              ? Colors.white
                                                              : Theme.of(context)
                                                                  .primaryColorDark,
                                                        ),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                      const Divider(
                                                        endIndent: 64,
                                                        height: 1,
                                                      ),
                                                      Container(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        state.notes[index]
                                                            .description!,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontFamily: 'naskh',
                                                          color: ThemeProvider.themeOf(
                                                                          context)
                                                                      .id ==
                                                                  'dark'
                                                              ? Colors.white
                                                              : Theme.of(context)
                                                                  .primaryColorDark,
                                                        ),
                                                        textAlign:
                                                            TextAlign.justify,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            })
                        : noteLottie(150.0, 150.0);
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget noteUpdate(BuildContext context, Notes note) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(.2),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              TextFormField(
                textAlign: TextAlign.start,
                controller: context.read<NotesCubit>().titleController,
                autofocus: true,
                cursorHeight: 18,
                cursorWidth: 3,
                maxLines: null,
                cursorColor: Theme.of(context).dividerColor,
                onChanged: (value) {
                  setState(() {
                    context.read<NotesCubit>().title = value.trim();
                  });
                },
                style: TextStyle(
                    color: ThemeProvider.themeOf(context).id == 'dark'
                        ? Colors.white
                        : Theme.of(context).primaryColorLight,
                    fontFamily: 'uthmanic2',
                    fontSize: 18),
                decoration: InputDecoration(
                  icon: IconButton(
                    onPressed: () =>
                        context.read<NotesCubit>().titleController.clear(),
                    icon: Icon(
                      Icons.clear,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.surface),
                  ),
                  hintText: AppLocalizations.of(context)!.note_title,
                  label: Text(
                    AppLocalizations.of(context)!.note_title,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.surface),
                  ),
                  hintStyle: TextStyle(
                      // height: 1.5,
                      color:
                          Theme.of(context).primaryColorLight.withOpacity(0.5),
                      fontFamily: 'kufi',
                      fontWeight: FontWeight.normal,
                      decorationColor: Theme.of(context).primaryColor,
                      fontSize: 12),
                  contentPadding: const EdgeInsets.only(right: 16, left: 16),
                ),
              ),
              const Divider(
                endIndent: 64,
                height: 1,
              ),
              Container(
                height: 10,
              ),
              TextFormField(
                textAlign: TextAlign.start,
                controller: context.read<NotesCubit>().descriptionController,
                autofocus: true,
                cursorHeight: 18,
                cursorWidth: 3,
                maxLines: null,
                cursorColor: Theme.of(context).dividerColor,
                onChanged: (value) {
                  setState(() {
                    context.read<NotesCubit>().description = value.trim();
                  });
                },
                style: TextStyle(
                    color: ThemeProvider.themeOf(context).id == 'dark'
                        ? Colors.white
                        : Theme.of(context).primaryColorLight,
                    fontFamily: 'naskh',
                    fontSize: 18),
                decoration: InputDecoration(
                  icon: IconButton(
                    onPressed: () =>
                        context.read<NotesCubit>().titleController.clear(),
                    icon: Icon(
                      Icons.clear,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.surface),
                  ),
                  hintText: AppLocalizations.of(context)!.note_title,
                  label: Text(
                    AppLocalizations.of(context)!.note_title,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.surface),
                  ),
                  hintStyle: TextStyle(
                      // height: 1.5,
                      color:
                          Theme.of(context).primaryColorLight.withOpacity(0.5),
                      fontFamily: 'kufi',
                      fontWeight: FontWeight.normal,
                      decorationColor: Theme.of(context).primaryColor,
                      fontSize: 12),
                  contentPadding: const EdgeInsets.only(right: 16, left: 16),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    side: BorderSide(
                      width: 1.0,
                      color: Theme.of(context).dividerColor,
                    )),
                onPressed: () {
                  note.title =
                      context.read<NotesCubit>().titleController.text.trim();
                  note.description = context
                      .read<NotesCubit>()
                      .descriptionController
                      .text
                      .trim();
                  context.read<NotesCubit>().updateNotes(note);
                  Navigator.of(context).pop();
                },
                child: Text(
                  AppLocalizations.of(context)!.save,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.background),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
