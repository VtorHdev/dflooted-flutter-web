import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/matches/matches_cubit.dart';
import '../../../cubits/matches/matches_state.dart';
import '../../../../domain/config/game_config.dart';
import '../../../../domain/enums/game_enums.dart';

class HistorySection extends StatelessWidget {
  const HistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Recalculamos las alturas teniendo en cuenta todos los elementos
        final headerHeight = 60.0; // Título + spacing
        final tableHeaderHeight = 50.0; // Altura del header de la tabla
        final rowHeight = 72.0; // Altura de cada fila
        final totalPadding = 32.0; // Padding total de la card

        final availableHeight = constraints.maxHeight -
            headerHeight -
            tableHeaderHeight -
            totalPadding;
        final maxRows = (availableHeight / rowHeight).floor(); // Quitado el -1

        return BlocBuilder<MatchesCubit, MatchesState>(
          builder: (context, state) {
            return Card(
              color: Colors.black26,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ÚLTIMAS PARTIDAS',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 16),
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(2.5), // Mapa
                        1: FlexColumnWidth(1.2), // Dificultad
                        2: FlexColumnWidth(2), // Agente
                        3: FlexColumnWidth(1), // Tiempo
                        4: FlexColumnWidth(0.8), // Solo Run
                        5: FlexColumnWidth(1.2), // Ganancias
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
                                    style: TextStyle(color: Color(0xFF00FF9D))),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text('DIFICULTAD',
                                    style: TextStyle(color: Color(0xFF00FF9D))),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text('AGENTE',
                                    style: TextStyle(color: Color(0xFF00FF9D))),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text('TIEMPO',
                                    style: TextStyle(color: Color(0xFF00FF9D))),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text('SOLO RUN',
                                    style: TextStyle(color: Color(0xFF00FF9D))),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'GANANCIAS',
                                  style: TextStyle(color: Color(0xFF00FF9D)),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Limitamos el número de filas al nuevo maxRows calculado
                        for (var i = 0; i < maxRows; i++)
                          TableRow(
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image.asset(
                                          GameConfig.getMapImage(GameMap.values[
                                              i % GameMap.values.length]),
                                          width: 64,
                                          height: 40,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Flexible(
                                        child: Text(
                                          GameMap
                                              .values[i % GameMap.values.length]
                                              .name
                                              .toUpperCase(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      if (i % 2 == 0)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF500000)
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: const Text(
                                            'CONFIDENTIAL',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        )
                                      else
                                        const Text(
                                          'NORMAL',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image.asset(
                                          GameConfig.getAgentImage(
                                              GameAgent.values[
                                                  i % GameAgent.values.length]),
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Flexible(
                                        child: Text(
                                          GameAgent
                                              .values[
                                                  i % GameAgent.values.length]
                                              .name
                                              .toUpperCase(),
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    '${(i + 1) * 5}:${(i * 15).toString().padLeft(2, '0')}',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    i % 2 == 0 ? 'SI' : 'NO',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${(i + 1) * 1000}',
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
            );
          },
        );
      },
    );
  }
}
