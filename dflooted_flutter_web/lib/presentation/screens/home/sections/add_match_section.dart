import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../domain/config/game_config.dart';
import '../../../../domain/enums/game_enums.dart';

class AddMatchSection extends StatefulWidget {
  const AddMatchSection({super.key});

  @override
  State<AddMatchSection> createState() => _AddMatchSectionState();
}

class _AddMatchSectionState extends State<AddMatchSection> {
  GameMap? selectedMap;
  GameMode? selectedMode;
  GameAgent? selectedAgent;
  int? kills;
  String? time;
  bool isSoloRun = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AÑADIR PARTIDA',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 32),

            // Selector de Mapa
            Text('MAPA',
                style: TextStyle(
                  color: const Color(0xFF00FF9D),
                )),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.6,
              children: GameMap.values.map((map) {
                return InkWell(
                  onTap: () => setState(() => selectedMap = map),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: selectedMap == map
                            ? const Color(0xFF00FF9D)
                            : Colors.white24,
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            GameConfig.getMapImage(map),
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            left: 8,
                            child: Text(
                              map.name.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 32),

            // Fila con Dificultad y Agente
            Row(
              children: [
                // Selector de Dificultad
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'DIFICULTAD',
                        style: TextStyle(color: Color(0xFF00FF9D)),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white24),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<GameMode>(
                            isExpanded: true,
                            value: selectedMode,
                            hint: const Text('Seleccionar dificultad'),
                            items: GameMode.values.map((mode) {
                              return DropdownMenuItem(
                                value: mode,
                                child: Text(mode.name.toUpperCase()),
                              );
                            }).toList(),
                            onChanged: (mode) =>
                                setState(() => selectedMode = mode),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Selector de Agente
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'AGENTE',
                        style: TextStyle(color: Color(0xFF00FF9D)),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white24),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<GameAgent>(
                            isExpanded: true,
                            value: selectedAgent,
                            hint: const Text('Seleccionar agente'),
                            items: GameAgent.values.map((agent) {
                              return DropdownMenuItem(
                                value: agent,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      GameConfig.getAgentImage(agent),
                                      width: 24,
                                      height: 24,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(agent.name.toUpperCase()),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (agent) =>
                                setState(() => selectedAgent = agent),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Fila con Tiempo y Ganancias
            Row(
              children: [
                // Campo de Tiempo
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'TIEMPO (opcional)',
                        style: TextStyle(color: Color(0xFF00FF9D)),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        decoration: InputDecoration(
                          hintText: '00:00',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.white24),
                          ),
                        ),
                        onChanged: (value) => setState(() => time = value),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Campo de Ganancias
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'GANANCIAS',
                        style: TextStyle(color: Color(0xFF00FF9D)),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          hintText: '0',
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              'assets/images/tekniq.png',
                              width: 20,
                              height: 20,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.white24),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            // TODO: Actualizar el valor de ganancias
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Switch de Solo Run
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'SOLO RUN',
                  style: TextStyle(color: Color(0xFF00FF9D)),
                ),
                const SizedBox(width: 16),
                Switch(
                  value: isSoloRun,
                  onChanged: (value) => setState(() => isSoloRun = value),
                  activeColor: const Color(0xFF00FF9D),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Botón de Guardar
            Center(
              child: Container(
                height: 56,
                width: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/button.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: selectedMap != null &&
                          selectedMode != null &&
                          selectedAgent != null
                      ? () {
                          // TODO: Implementar guardado
                        }
                      : null,
                  child: const Text(
                    'GUARDAR PARTIDA',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
