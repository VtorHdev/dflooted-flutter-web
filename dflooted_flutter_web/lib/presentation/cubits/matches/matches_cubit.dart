import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/game_match.dart';
import '../../../domain/enums/game_enums.dart';
import 'matches_state.dart';

class MatchesCubit extends Cubit<MatchesState> {
  MatchesCubit() : super(const MatchesState());

  void addMatch(GameMatch match) {
    final updatedMatches = [...state.matches, match];
    _updateState(updatedMatches);
  }

  void removeMatch(String id) {
    final updatedMatches = state.matches.where((m) => m.id != id).toList();
    _updateState(updatedMatches);
  }

  void _updateState(List<GameMatch> matches) {
    final profitByMapAndMode = _calculateAverageProfitByMapAndMode(matches);
    final profitByAgent = _calculateAverageProfitByAgent(matches);
    final bestMatch = _findBestMatch(matches);
    final bestAgent = _findBestAgent(profitByAgent);

    emit(state.copyWith(
      matches: matches,
      averageProfitByMapAndMode: profitByMapAndMode,
      averageProfitByAgent: profitByAgent,
      bestMatch: bestMatch,
      bestAgent: bestAgent,
    ));
  }

  Map<GameMap, Map<GameMode, double>> _calculateAverageProfitByMapAndMode(
      List<GameMatch> matches) {
    final profitByMapAndMode = <GameMap, Map<GameMode, List<int>>>{};

    for (final match in matches) {
      profitByMapAndMode.putIfAbsent(match.map, () => {});
      profitByMapAndMode[match.map]!
          .putIfAbsent(match.mode, () => [])
          .add(match.profit);
    }

    return Map.fromEntries(
      profitByMapAndMode.entries.map((mapEntry) {
        final modeAverages = Map.fromEntries(
          mapEntry.value.entries.map((modeEntry) {
            final profits = modeEntry.value;
            final average = profits.isEmpty
                ? 0.0
                : profits.reduce((a, b) => a + b) / profits.length;
            return MapEntry(modeEntry.key, average);
          }),
        );
        return MapEntry(mapEntry.key, modeAverages);
      }),
    );
  }

  Map<GameAgent, double> _calculateAverageProfitByAgent(
      List<GameMatch> matches) {
    final profitByAgent = <GameAgent, List<int>>{};

    for (final match in matches) {
      profitByAgent.putIfAbsent(match.agent, () => []).add(match.profit);
    }

    return Map.fromEntries(
      profitByAgent.entries.map((entry) {
        final profits = entry.value;
        final average = profits.isEmpty
            ? 0.0
            : profits.reduce((a, b) => a + b) / profits.length;
        return MapEntry(entry.key, average);
      }),
    );
  }

  GameMatch? _findBestMatch(List<GameMatch> matches) {
    if (matches.isEmpty) return null;
    return matches
        .reduce((curr, next) => curr.profit > next.profit ? curr : next);
  }

  GameAgent? _findBestAgent(Map<GameAgent, double> profitByAgent) {
    if (profitByAgent.isEmpty) return null;
    return profitByAgent.entries
        .reduce((curr, next) => curr.value > next.value ? curr : next)
        .key;
  }
}
