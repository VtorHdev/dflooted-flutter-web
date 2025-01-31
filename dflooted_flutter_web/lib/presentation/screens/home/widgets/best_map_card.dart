import 'package:flutter/material.dart';
import '../../../../domain/entities/game_match.dart';
import '../../../../domain/config/game_config.dart';
import '../../../../domain/enums/game_enums.dart';

class BestMapCard extends StatelessWidget {
  final GameMatch? bestMatch;

  const BestMapCard({super.key, this.bestMatch});

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo
    final exampleMatch = GameMatch(
      id: '1',
      map: GameMap.layaligrove,
      mode: GameMode.confidential,
      agent: GameAgent.vyron,
      profit: 15750,
      date: DateTime.now(),
    );

    final match = bestMatch ?? exampleMatch;

    return Card(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFF00FF9D),
                  width: 2,
                ),
              ),
            ),
            child: const Text(
              'MEJOR MAPA',
              style: TextStyle(
                color: Color(0xFF00FF9D),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  match.map.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: match.mode == GameMode.confidential
                        ? const Color(0xFF500000).withOpacity(0.3)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    match.mode.name.toUpperCase(),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      match.profit.toStringAsFixed(0),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color(0xFF00FF9D),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Image.asset(
                      'assets/images/tekniq.png',
                      width: 20,
                      height: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    GameConfig.getMapImage(match.map),
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
