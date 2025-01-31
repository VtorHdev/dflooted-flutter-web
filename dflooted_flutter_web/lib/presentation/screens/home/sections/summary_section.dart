import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/matches/matches_cubit.dart';
import '../../../cubits/matches/matches_state.dart';
import '../../../../domain/config/game_config.dart';
import '../../../../domain/enums/game_enums.dart';
import '../widgets/best_map_card.dart';
import '../widgets/best_agent_card.dart';

class SummarySection extends StatelessWidget {
  const SummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchesCubit, MatchesState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tabla principal
            Expanded(
              flex: 75,
              child: Card(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ESTADÍSTICAS DE MAPAS',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Table(
                        columnWidths: const {
                          0: FlexColumnWidth(2.5), // Mapa (imagen + texto)
                          1: FlexColumnWidth(1.2), // Dificultad
                          2: FlexColumnWidth(2), // Agente (imagen + texto)
                          3: FlexColumnWidth(1.2), // Ganancias (número + icono)
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        border: TableBorder(
                          verticalInside: BorderSide(
                            color: Colors.white.withOpacity(0.1),
                            width: 1,
                          ),
                          horizontalInside: BorderSide(
                            color: Colors.white.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                              ),
                            ),
                            children: const [
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text('MAPA',
                                      style:
                                          TextStyle(color: Color(0xFF00FF9D))),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text('DIFICULTAD',
                                      style:
                                          TextStyle(color: Color(0xFF00FF9D))),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text('AGENTE PREFERIDO',
                                      style:
                                          TextStyle(color: Color(0xFF00FF9D))),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    'GANANCIAS',
                                    style: TextStyle(color: Color(0xFF00FF9D)),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          for (final map in GameMap.values)
                            for (final mode
                                in GameConfig.getValidModesForMap(map))
                              TableRow(
                                children: [
                                  // Columna de Mapa con imagen
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            child: Image.asset(
                                              GameConfig.getMapImage(map),
                                              width: 64,
                                              height: 40,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Flexible(
                                            child: Text(map.name.toUpperCase()),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Columna de Dificultad
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        children: [
                                          if (mode == GameMode.confidential)
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF500000)
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                mode.name.toUpperCase(),
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            )
                                          else
                                            Text(
                                              mode.name.toUpperCase(),
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Agente Preferido
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            child: Image.asset(
                                              GameConfig.getAgentImage(
                                                  GameAgent.values[map.index %
                                                      GameAgent.values.length]),
                                              width: 40,
                                              height: 40,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Flexible(
                                            child: Text(
                                              GameAgent
                                                  .values[map.index %
                                                      GameAgent.values.length]
                                                  .name
                                                  .toUpperCase(),
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Columna de Ganancias
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            state
                                                .getAverageProfitForMapAndMode(
                                                    map, mode)
                                                .toStringAsFixed(0),
                                          ),
                                          const SizedBox(width: 4),
                                          Image.asset(
                                            'assets/images/tekniq.png',
                                            width: 20,
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Cards laterales (25% del ancho)
            Expanded(
              flex: 25,
              child: Column(
                children: [
                  BestMapCard(bestMatch: state.bestMatch),
                  const SizedBox(height: 16),
                  BestAgentCard(
                    bestAgent: state.bestAgent,
                    averageProfit: state.bestAgent != null
                        ? state.getAverageProfitForAgent(state.bestAgent!)
                        : 0,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
