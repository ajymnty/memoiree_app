import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:memoiree/presentation/screens/all/auth/auth.dart';
import 'package:memoiree/presentation/screens/all/auth/auth_cb.dart';
import 'package:memoiree/presentation/screens/user/about/about.dart';
import 'package:memoiree/presentation/screens/user/about/about_cb.dart';
import 'package:memoiree/presentation/screens/user/calendar/calendar.dart';
import 'package:memoiree/presentation/screens/user/calendar/calendar_cb.dart';
import 'package:memoiree/presentation/screens/user/diary/diary.dart';
import 'package:memoiree/presentation/screens/user/diary/diary_cb.dart';
import 'package:memoiree/presentation/screens/user/flash_card_groups/group.dart';
import 'package:memoiree/presentation/screens/user/flash_card_groups/groups_cb.dart';
import 'package:memoiree/presentation/screens/user/flash_cards/flash_card.dart';
import 'package:memoiree/presentation/screens/user/flash_cards/flash_card_cb.dart';
import 'package:memoiree/presentation/screens/user/quiz_mode/quiz_mode.dart';
import 'package:memoiree/presentation/screens/user/quiz_mode/quiz_mode_cb.dart';
import 'package:memoiree/presentation/screens/user/start/start.dart';
import 'package:memoiree/presentation/screens/user/start/start_cb.dart';
import 'package:memoiree/presentation/screens/user/support/support.dart';
import 'package:memoiree/presentation/screens/user/support/support_cb.dart';

appRoutes() => <GetPage>[
  GetPage(
    name: '/flashcards',
    page: () => FlashCards(),
    binding: FlashCardsBinding(),
  ),
  GetPage(
    name: '/calendar',
    page: () => Calendar(),
    binding: CalendarBinding(),
  ),
  GetPage(
    name: '/quiz-mode',
    page: () => QuizMode(),
    binding: QuizModeBinding(),
  ),
  GetPage(
    name: '/flash-card-start',
    page: () => Start(),
    binding: StartBinding(),
  ),
  GetPage(
    name: '/flash-card-groups',
    page: () => FlashCardGroups(),
    binding: FlashCardGroupsBinding(),
  ),
  GetPage(name: '/auth', page: () => Auth(), binding: AuthBinding()),
  GetPage(name: '/support', page: () => Support(), binding: SupporBinding()),
  GetPage(name: '/about', page: () => About(), binding: AboutBinding()),
  GetPage(name: '/diary', page: () => Diary(), binding: DiaryBinding()),
];
