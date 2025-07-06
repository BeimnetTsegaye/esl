import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/core/util/date_utils.dart';
import 'package:esl/core/util/dialog_utils.dart';
import 'package:esl/core/widgets/connection_error_widget.dart';
import 'package:esl/core/widgets/scrollable_dots_indicator.dart';
import 'package:esl/core/widgets/see_all_title.dart';
import 'package:esl/features/home/domain/entities/event.dart';
import 'package:esl/features/home/domain/entities/news.dart';
import 'package:esl/features/home/presentation/blocs/announcment/bloc/announcment_bloc.dart';
import 'package:esl/features/home/presentation/blocs/event/event_bloc.dart';
import 'package:esl/features/home/presentation/blocs/hero/hero_bloc.dart';
import 'package:esl/features/home/presentation/blocs/news/news_bloc.dart';
import 'package:esl/features/home/presentation/widgets/ad_banner.dart';
import 'package:esl/features/home/presentation/widgets/event_card.dart';
import 'package:esl/features/home/presentation/widgets/hero_card.dart';
import 'package:esl/features/home/presentation/widgets/news_tile.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now();
  DateTime tappedDate = DateTime.now();
  double dotsIndicatorPosition = 0;
  double announcementDotsPosition = 0;
  bool _isInitialized = false;

  final List<Event> events = [];
  final List<News> news = [];

  bool heroError = false;
  bool eventError = false;
  bool newsError = false;

  bool get allFailed => heroError && eventError && newsError;

  int _lastDateIndex = 0;
  bool _isNext = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    if (!_isInitialized) {
      final eventBloc = context.read<EventBloc>();
      eventBloc.add(GetEventsByDateEvent(selectedDate));

      final newsBloc = context.read<NewsBloc>();
      newsBloc.add(const GetNews());

      final heroBloc = context.read<HeroBloc>();
      heroBloc.add(GetHeroes());

      final announcmentBloc = context.read<AnnouncmentBloc>();
      announcmentBloc.add(GetAnnouncmentsEvent());

      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _isInitialized = false;
    super.dispose();
  }

  final ads = [
    {
      'title': "We'd love your feedback!",
      'description':
          'Help us improve your experience by taking a short survey.',
      'link': 'Take the Survey',
    },
    {
      'title': 'Exclusive Offer: 20% Off on Maritime Courses',
      'description':
          'Enroll in our new courses and get a 20% discount. Limited time offer!',
      'link': 'Enroll Now',
    },
    {
      'title': 'Join Our Community',
      'description':
          'Connect with fellow students and professionals in the maritime field.',
      'link': 'Join Now',
    },
  ];

  Future<void> datePicker(BuildContext context) async {
    final DateTime picked = await datePickerDialog(
      context: context,
      selectedDate: selectedDate,
    );
    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        tappedDate = picked;
      });
      // Fetch events for the newly selected date
      context.read<EventBloc>().add(GetEventsByDateEvent(selectedDate));
    }
  }

  /// Refresh all data on the home page
  Future<void> _refreshData() async {
    final eventBloc = context.read<EventBloc>();
    final newsBloc = context.read<NewsBloc>();
    final heroBloc = context.read<HeroBloc>();
    final announcmentBloc = context.read<AnnouncmentBloc>();

    // Trigger refresh events for all BLoCs
    eventBloc.add(RefreshEvents(selectedDate));
    newsBloc.add(const RefreshNews());
    heroBloc.add(RefreshHeroes());
    announcmentBloc.add(RefreshAnnouncmentsEvent());

    // Wait a bit to ensure all refreshes are triggered
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Widget build(BuildContext context) {
    final weekDates = getWeekDates(selectedDate);
    events.where((event) {
      final eventDate = DateTime.parse(event.startDate.toString());
      return eventDate.year == tappedDate.year &&
          eventDate.month == tappedDate.month &&
          eventDate.day == tappedDate.day;
    }).toList();

    // If all major requests failed, show a single error widget
    if (allFailed) {
      return Scaffold(
        body: Center(
          child: ConnectionErrorWidget(
            onRetry: _refreshData,
            message:
                "We couldn't connect to the server. Please check your internet connection and try again.",
          ),
        ),
      );
    }

    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<EventBloc, EventState>(
            listener: (context, state) {
              if (state is LoadedEventState) {
                setState(() {
                  events.clear();
                  events.addAll(state.events);
                  eventError = false;
                });
              } else if (state is ErrorEventState) {
                setState(() {
                  eventError = true;
                });
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              } else {
                setState(() {
                  eventError = false;
                });
              }
            },
          ),
          BlocListener<NewsBloc, NewsState>(
            listener: (context, state) {
              if (state is NewsLoaded) {
                setState(() {
                  news.clear();
                  news.addAll(state.newsList);
                  newsError = false;
                });
              } else if (state is NewsEmpty) {
                setState(() {
                  newsError = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No news available')),
                );
              } else if (state is NewsError) {
                setState(() {
                  newsError = true;
                });
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              } else {
                setState(() {
                  newsError = false;
                });
              }
            },
          ),
        ],
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    //hero section
                    BlocBuilder<HeroBloc, HeroState>(
                      builder: (context, state) {
                        if (state is HeroLoading) {
                          heroError = false;
                          final fakeHeroItems = [
                            ...state.fakeHero.events,
                            ...state.fakeHero.news,
                          ];

                          if (fakeHeroItems.isEmpty) {
                            return const SizedBox.shrink();
                          }

                          final item = fakeHeroItems[0];
                          String? title;
                          String? excerpt;
                          String? imageUrl;

                          if (item is News) {
                            title = item.title;
                            excerpt = item.excerpt;
                            imageUrl = item.featuredImage;
                          } else if (item is Event) {
                            title = item.title;
                            excerpt = item.excerpt;
                            imageUrl = item.featuredImage;
                          }

                          return Skeletonizer(
                            child: SizedBox(
                              height: 400,
                              child: HeroCard(
                                title: title,
                                excerpt: excerpt,
                                imageUrl: imageUrl,
                              ),
                            ),
                          );
                        } else if (state is HeroLoaded &&
                            (state.hero.news.isNotEmpty ||
                                state.hero.events.isNotEmpty)) {
                          heroError = false;
                          final heroItems = [
                            ...state.hero.events,
                            ...state.hero.news,
                          ];

                          if (heroItems.isEmpty) {
                            return const SizedBox.shrink();
                          }

                          return Column(
                            children: [
                              SizedBox(
                                height: 400,
                                child: PageView.builder(
                                  onPageChanged: (value) => setState(() {
                                    dotsIndicatorPosition = value.toDouble();
                                  }),
                                  itemCount: heroItems.length,
                                  itemBuilder: (context, index) {
                                    final item = heroItems[index];
                                    if (item is News) {
                                      return HeroCard(
                                        title: item.title,
                                        excerpt: item.excerpt,
                                        imageUrl: item.featuredImage,
                                      );
                                    } else if (item is Event) {
                                      return HeroCard(
                                        title: item.title,
                                        excerpt: item.excerpt,
                                        imageUrl: item.featuredImage,
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              ScrollableDotsIndicator(
                                dotsCount: heroItems.length,
                                position: dotsIndicatorPosition,
                              ),
                            ],
                          );
                        } else if (state is HeroError) {
                          heroError = true;
                          // Only show section error if not all failed
                          if (!allFailed) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ConnectionErrorWidget(
                                message: state.message,
                                onRetry: _refreshData,
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    //events
                    Column(
                      children: [
                        //title and date selector
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Upcoming Events', style: boldTextStyle),
                            GestureDetector(
                              onTap: () => datePicker(context),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppConstants.eslGreyText,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      FluentIcons.calendar_date_20_regular,
                                    ),
                                    Text(
                                      DateFormat('EEE, MMM d').format(
                                        tappedDate,
                                      ), // Show tapped date instead of selected date
                                      style: boldTextStyle,
                                    ),
                                    const Icon(
                                      FluentIcons.chevron_down_24_regular,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Week date numbers list
                        Row(
                          children: weekDates.map((date) {
                            final isTapped = date.isAtSameMomentAs(tappedDate);
                            final index = weekDates.indexOf(date);
                            return Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isNext = index > _lastDateIndex;
                                    _lastDateIndex = index;
                                    tappedDate = date;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isTapped
                                        ? AppConstants.eslGreyTint
                                        : AppConstants.eslGreyTint,
                                    border: Border.all(
                                      color: isTapped
                                          ? AppConstants.eslGreen
                                          : Colors.grey[300]!,
                                      width: isTapped ? 2 : 1,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        DateFormat('EEE').format(date),
                                        style: TextStyle(
                                          color: isTapped
                                              ? AppConstants.eslGreen
                                              : AppConstants.eslGrey,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        date.day.toString(),
                                        style: boldTextStyle.copyWith(
                                          color: isTapped
                                              ? AppConstants.eslGreen
                                              : AppConstants.eslGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        //events list
                        BlocBuilder<EventBloc, EventState>(
                          builder: (context, state) {
                            if (state is LoadingEventState) {
                              eventError = false;
                              return Skeletonizer(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: EventCard(
                                    title: state.fakeEvent.title ?? '',
                                    description: state.fakeEvent.excerpt ?? '',
                                    time: formatDateToMMMMddyyyy(
                                      state.fakeEvent.startDate.toString(),
                                    ),
                                    key: ValueKey<DateTime>(tappedDate),
                                  ),
                                ),
                              );
                            } else if (state is LoadedEventState) {
                              eventError = false;
                              final filteredEvents = state.events.where((
                                event,
                              ) {
                                final eventDate = DateTime.parse(
                                  event.startDate.toString(),
                                );
                                return eventDate.year == tappedDate.year &&
                                    eventDate.month == tappedDate.month &&
                                    eventDate.day == tappedDate.day;
                              }).toList();
                              if (filteredEvents.isEmpty) {
                                return const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    'No events for this date',
                                    style: TextStyle(
                                      color: AppConstants.eslGrey,
                                      fontSize: 16,
                                    ),
                                  ),
                                );
                              }
                              return AnimatedSwitcher(
                                duration: const Duration(milliseconds: 350),
                                transitionBuilder:
                                    (
                                      Widget child,
                                      Animation<double> animation,
                                    ) {
                                      final offsetAnimation = Tween<Offset>(
                                        begin: Offset(
                                          _isNext ? 1.0 : -1.0,
                                          0.0,
                                        ),
                                        end: Offset.zero,
                                      ).animate(animation);
                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    },
                                child: Column(
                                  key: ValueKey<DateTime>(tappedDate),
                                  children: [
                                    ...filteredEvents.map(
                                      (event) => EventCard(
                                        key: ValueKey<String>(
                                          event.title! +
                                              event.startDate.toString(),
                                        ),
                                        title: event.title ?? '',
                                        description: event.excerpt ?? '',
                                        time: formatDateToMMMMddyyyy(
                                          event.startDate.toString(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else if (state is ErrorEventState) {
                              eventError = true;
                              if (!allFailed) {
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: ConnectionErrorWidget(
                                    message: state.message,
                                    onRetry: _refreshData,
                                  ),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            } else {
                              return const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'No events for this date',
                                  style: TextStyle(
                                    color: AppConstants.eslGrey,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    // const SizedBox(height: 10),
                    //download academic calendar
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(
                        right: 8,
                        left: 8,
                        top: 8,
                        bottom: 8,
                      ),
                      decoration: BoxDecoration(
                        color: currentThemeNotifier.value == lightMode
                            ? AppConstants.eslGreyTint
                            : AppConstants.eslDarkGreyTint,
                        borderRadius: BorderRadius.zero,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Download Academic Calendar',
                              style: boldTextStyle,
                            ),
                            const Text(
                              'Get the latest updates on academic events, holidays, and important dates.',
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Download Now',
                                style: boldTextStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //announcments
                    BlocBuilder<AnnouncmentBloc, AnnouncmentState>(
                      builder: (context, state) {
                        if (state is AnnouncmentLoading) {
                          final fakeAnnouncments = state.fakeAnnouncments;
                          return Column(
                            children: [
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 200,
                                child: PageView.builder(
                                  onPageChanged: (value) => setState(() {
                                    announcementDotsPosition = value.toDouble();
                                  }),
                                  itemCount: fakeAnnouncments.length,
                                  itemBuilder: (context, index) {
                                    final ad = fakeAnnouncments[index];
                                    return Skeletonizer(
                                      child: AdBanner(
                                        adTitle: ad.title ?? '',
                                        adDescription: ad.description ?? '',
                                        onPressed: () {},
                                        onClose: () {},
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              ScrollableDotsIndicator(
                                dotsCount: fakeAnnouncments.length,
                                position: announcementDotsPosition,
                              ),
                            ],
                          );
                        } else if (state is AnnouncmentLoaded) {
                          if (state.announcments.isEmpty) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 150,
                                  child: PageView.builder(
                                    onPageChanged: (value) => setState(() {
                                      announcementDotsPosition = value
                                          .toDouble();
                                    }),
                                    itemCount: state.announcments.length,
                                    itemBuilder: (context, index) {
                                      final ad = state.announcments[index];
                                      return AdBanner(
                                        adTitle: ad.title ?? '',
                                        adDescription: ad.description ?? '',
                                        onPressed: () {},
                                        onClose: () {
                                          context.read<AnnouncmentBloc>().add(
                                            RemoveAnnouncmentEvent(index),
                                          );
                                          // Adjust dots position if needed
                                          if (state.announcments.length > 1) {
                                            setState(() {
                                              announcementDotsPosition =
                                                  announcementDotsPosition
                                                      .clamp(
                                                        0,
                                                        state
                                                                .announcments
                                                                .length -
                                                            2,
                                                      )
                                                      .toDouble();
                                            });
                                          } else {
                                            setState(() {
                                              announcementDotsPosition = 0;
                                            });
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ScrollableDotsIndicator(
                                  dotsCount: state.announcments.length,
                                  position: announcementDotsPosition,
                                ),
                              ],
                            ),
                          );
                        } else if (state is AnnouncmentEmpty) {
                          return const SizedBox.shrink();
                        } else if (state is AnnouncmentError) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              state.message,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    // //news
                    // SeeAllTitle(title: 'News', onPressed: () {}),
                    // const SizedBox(height: 10),
                    // BlocBuilder<NewsBloc, NewsState>(
                    //   builder: (context, state) {
                    //     if (state is NewsLoading) {
                    //       newsError = false;
                    //       return Skeletonizer(
                    //         child: NewsTile(
                    //           title: state.fakeNews.title ?? '',
                    //           excerpt: state.fakeNews.viewsCount.toString(),
                    //           imageUrl: state.fakeNews.featuredImage ?? '',
                    //           onPressed: () {},
                    //         ),
                    //       );
                    //     } else if (state is NewsLoaded) {
                    //       newsError = false;
                    //       return Column(
                    //         spacing: 10,
                    //         children: state.newsList.map((news) {
                    //           return NewsTile(
                    //             title: news.title ?? '',
                    //             excerpt: news.excerpt ?? '',
                    //             imageUrl: news.featuredImage ?? '',
                    //             onPressed: () => context.push(
                    //               AppConstants.newsDetailsRoute,
                    //               extra: news,
                    //             ),
                    //           );
                    //         }).toList(),
                    //       );
                    //     } else if (state is NewsEmpty) {
                    //       newsError = false;
                    //       return const Padding(
                    //         padding: EdgeInsets.all(16.0),
                    //         child: Text(
                    //           'No news available',
                    //           style: TextStyle(fontSize: 16),
                    //         ),
                    //       );
                    //     } else if (state is NewsError) {
                    //       newsError = true;
                    //       if (!allFailed) {
                    //         return Padding(
                    //           padding: const EdgeInsets.all(16.0),
                    //           child: ConnectionErrorWidget(
                    //             message: state.message,
                    //             onRetry: _refreshData,
                    //           ),
                    //         );
                    //       } else {
                    //         return const SizedBox.shrink();
                    //       }
                    //     } else {
                    //       return const SizedBox.shrink();
                    //     }
                    //   },
                    // ),
                    // const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
