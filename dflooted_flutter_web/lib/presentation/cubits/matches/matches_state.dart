import 'package:equatable/equatable.dart';
import '../../../domain/entities/game_match.dart';
import '../../../domain/enums/game_enums.dart';

class MatchesState extends Equatable {
  final List<GameMatch> matches;
  final Map<GameMap, Map<GameMode, double>> averageProfitByMapAndMode;
  final Map<GameAgent, double> averageProfitByAgent;
  final GameMatch? bestMatch;
  final GameAgent? bestAgent;
  final bool isLoading;
  final String? error;

  const MatchesState({
    this.matches = const [],
    this.averageProfitByMapAndMode = const {},
    this.averageProfitByAgent = const {},
    this.bestMatch,
    this.bestAgent,
    this.isLoading = false,
    this.error,
  });

  double getAverageProfitForMapAndMode(GameMap map, GameMode mode) {
    return averageProfitByMapAndMode[map]?[mode] ?? 0;
  }

  double getAverageProfitForAgent(GameAgent agent) {
    return averageProfitByAgent[agent] ?? 0;
  }

  MatchesState copyWith({
    List<GameMatch>? matches,
    Map<GameMap, Map<GameMode, double>>? averageProfitByMapAndMode,
    Map<GameAgent, double>? averageProfitByAgent,
    GameMatch? bestMatch,
    GameAgent? bestAgent,
    bool? isLoading,
    String? error,
  }) {
    return MatchesState(
      matches: matches ?? this.matches,
      averageProfitByMapAndMode:
          averageProfitByMapAndMode ?? this.averageProfitByMapAndMode,
      averageProfitByAgent: averageProfitByAgent ?? this.averageProfitByAgent,
      bestMatch: bestMatch ?? this.bestMatch,
      bestAgent: bestAgent ?? this.bestAgent,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        matches,
        averageProfitByMapAndMode,
        averageProfitByAgent,
        bestMatch,
        bestAgent,
        isLoading,
        error
      ];
}
