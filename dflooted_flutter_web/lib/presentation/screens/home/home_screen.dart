import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/matches/matches_cubit.dart';
import 'sections/summary_section.dart';
import 'sections/history_section.dart';
import 'sections/add_match_section.dart';
import 'widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  final _sectionKeys = {
    'resumen': GlobalKey(),
    'historial': GlobalKey(),
    'añadir': GlobalKey(),
  };

  void _scrollToSection(String section) {
    final key = _sectionKeys[section];
    if (key?.currentContext != null) {
      final box = key!.currentContext!.findRenderObject() as RenderBox;
      final offset = box.localToGlobal(Offset.zero).dy;
      final targetScroll = _scrollController.offset + offset - 70;

      _scrollController.animateTo(
        targetScroll,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MatchesCubit(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: CustomAppBar(
          onSectionSelected: _scrollToSection,
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              // Sección Resumen
              Container(
                key: _sectionKeys['resumen'],
                height: MediaQuery.of(context).size.height - 70,
                padding: const EdgeInsets.all(36),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg2.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Center(child: SummarySection()),
              ),
              // Sección Historial
              Container(
                key: _sectionKeys['historial'],
                height: MediaQuery.of(context).size.height - 70,
                padding: const EdgeInsets.all(36),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg3.jpg'),
                    fit: BoxFit.cover,
                    opacity: 0.5,
                  ),
                ),
                child: const Center(child: HistorySection()),
              ),
              // Sección Añadir
              Container(
                key: _sectionKeys['añadir'],
                height: MediaQuery.of(context).size.height - 70,
                padding: const EdgeInsets.all(36),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg1.jpg'),
                    fit: BoxFit.cover,
                    opacity: 0.5,
                  ),
                ),
                child: const Center(child: AddMatchSection()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
