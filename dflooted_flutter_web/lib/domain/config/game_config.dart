import '../enums/game_enums.dart';

class GameConfig {
  static const Map<GameMap, List<GameMode>> validMapModes = {
    GameMap.zerodam: [GameMode.normal, GameMode.confidential],
    GameMap.layaligrove: [GameMode.normal, GameMode.confidential],
    GameMap.spacecity: [GameMode.confidential],
    GameMap.brakkesh: [GameMode.confidential],
  };

  static const Map<GameMap, String> mapImages = {
    GameMap.zerodam: 'assets/images/maps/zerodam.jpg',
    GameMap.layaligrove: 'assets/images/maps/layaligrove.jpg',
    GameMap.spacecity: 'assets/images/maps/spacecity.jpg',
    GameMap.brakkesh: 'assets/images/maps/brakkesh.jpg',
  };

  static const Map<GameAgent, String> agentImages = {
    GameAgent.wolf: 'assets/images/agents/wolf.png',
    GameAgent.vyron: 'assets/images/agents/vyron.png',
    GameAgent.stinger: 'assets/images/agents/stinger.png',
    GameAgent.toxic: 'assets/images/agents/toxic.png',
    GameAgent.pastor: 'assets/images/agents/pastor.png',
    GameAgent.uluru: 'assets/images/agents/uluru.png',
    GameAgent.luna: 'assets/images/agents/luna.png',
    GameAgent.deathclaw: 'assets/images/agents/deathclaw.png',
  };

  static bool isValidCombination(GameMap map, GameMode mode) {
    return validMapModes[map]?.contains(mode) ?? false;
  }

  static List<GameMode> getValidModesForMap(GameMap map) {
    return validMapModes[map] ?? [];
  }

  static String getMapImage(GameMap map) {
    return mapImages[map] ?? '';
  }

  static String getAgentImage(GameAgent agent) {
    return agentImages[agent] ?? '';
  }
}
