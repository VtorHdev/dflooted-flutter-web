import 'package:equatable/equatable.dart';
import '../enums/game_enums.dart';
import '../config/game_config.dart';

class GameMatch extends Equatable {
  final String id;
  final GameMap map;
  final GameMode mode;
  final GameAgent agent;
  final int profit;
  final DateTime date;

  const GameMatch({
    required this.id,
    required this.map,
    required this.mode,
    required this.agent,
    required this.profit,
    required this.date,
  });

  @override
  List<Object?> get props => [id, map, mode, agent, profit, date];

  GameMatch copyWith({
    String? id,
    GameMap? map,
    GameMode? mode,
    GameAgent? agent,
    int? profit,
    DateTime? date,
  }) {
    return GameMatch(
      id: id ?? this.id,
      map: map ?? this.map,
      mode: mode ?? this.mode,
      agent: agent ?? this.agent,
      profit: profit ?? this.profit,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'map': map.name,
      'mode': mode.name,
      'agent': agent.name,
      'profit': profit,
      'date': date.toIso8601String(),
    };
  }

  factory GameMatch.fromJson(Map<String, dynamic> json) {
    return GameMatch(
      id: json['id'] as String,
      map: GameMap.values.firstWhere(
        (e) => e.name == json['map'],
        orElse: () => GameMap.zerodam,
      ),
      mode: GameMode.values.firstWhere(
        (e) => e.name == json['mode'],
        orElse: () => GameMode.normal,
      ),
      agent: GameAgent.values.firstWhere(
        (e) => e.name == json['agent'],
        orElse: () => GameAgent.luna,
      ),
      profit: json['profit'] as int,
      date: DateTime.parse(json['date'] as String),
    );
  }

  bool isValid() {
    return GameConfig.isValidCombination(map, mode);
  }

  factory GameMatch.create({
    required String id,
    required GameMap map,
    required GameMode mode,
    required GameAgent agent,
    required int profit,
    required DateTime date,
  }) {
    if (!GameConfig.isValidCombination(map, mode)) {
      throw ArgumentError('Combinación de mapa y modo no válida');
    }
    return GameMatch(
      id: id,
      map: map,
      mode: mode,
      profit: profit,
      date: date,
      agent: agent,
    );
  }
}
