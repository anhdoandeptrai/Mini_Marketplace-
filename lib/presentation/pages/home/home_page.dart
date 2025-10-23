import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/user_entity.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/language/language_cubit.dart';
import '../auth/login_page.dart';
import '../course/courses_page.dart';
import '../course/my_courses_page.dart';
import '../course/my_learning_page.dart';
import '../order/orders_page.dart';
import '../chat/chat_list_page.dart';
import '../../../l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  final UserEntity user;

  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const CoursesPage(),
      if (widget.user.role == 'teacher')
        const MyCoursesPage()
      else
        const MyLearningPage(),
      OrdersPage(userId: widget.user.id),
      const ChatListPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF00C853),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(6),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  'assets/images/logo.jpg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(l10n.home),
          ],
        ),
        actions: [
          // Language toggle button
          BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, state) {
              return PopupMenuButton<String>(
                icon: const Icon(Icons.language),
                onSelected: (languageCode) {
                  context.read<LanguageCubit>().changeLanguage(languageCode);
                },
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    value: 'vi',
                    child: Row(
                      children: [
                        if (state.locale.languageCode == 'vi')
                          const Icon(Icons.check, size: 20),
                        const SizedBox(width: 8),
                        Text(l10n.vietnamese),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'en',
                    child: Row(
                      children: [
                        if (state.locale.languageCode == 'en')
                          const Icon(Icons.check, size: 20),
                        const SizedBox(width: 8),
                        Text(l10n.english),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(LogoutEvent());
            },
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginPage()),
              (route) => false,
            );
          }
        },
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.school),
            label: l10n.courses,
          ),
          if (widget.user.role == 'teacher')
            BottomNavigationBarItem(
              icon: const Icon(Icons.video_library),
              label: l10n.myCourses,
            )
          else
            BottomNavigationBarItem(
              icon: const Icon(Icons.book),
              label: l10n.myLearning,
            ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_bag),
            label: l10n.orders,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.chat),
            label: l10n.chat,
          ),
        ],
      ),
    );
  }
}
