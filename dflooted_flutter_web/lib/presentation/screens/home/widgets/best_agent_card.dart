import 'package:flutter/material.dart';
import '../../../../domain/enums/game_enums.dart';
import '../../../../domain/config/game_config.dart';

class BestAgentCard extends StatelessWidget {
  final GameAgent? bestAgent;
  final double averageProfit;

  const BestAgentCard({
    super.key,
    this.bestAgent,
    this.averageProfit = 0,
  });

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo
    final agent = bestAgent ?? GameAgent.deathclaw;
    final profit = averageProfit > 0 ? averageProfit : 12480.0;

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
              'MEJOR AGENTE',
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
                  agent.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      profit.toStringAsFixed(0),
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
                    GameConfig.getAgentImage(agent),
                    width: double.infinity,
                    height: 180,
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
