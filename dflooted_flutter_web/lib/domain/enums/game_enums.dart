enum GameMap {
  zerodam('Represa Cero'),
  layaligrove('Arboleda Layali'),
  spacecity('Ciudad Espacial'),
  brakkesh('Brakkesh');

  final String name;
  const GameMap(this.name);
}

enum GameMode {
  normal('Normal'),
  confidential('Confidencial');

  final String name;
  const GameMode(this.name);
}

enum GameAgent {
  wolf('Wolf'),
  vyron('Vyron'),
  stinger('Stinger'),
  toxic('Toxic'),
  pastor('Pastor'),
  uluru('Uluru'),
  luna('Luna'),
  deathclaw('Deathclaw');

  final String name;
  const GameAgent(this.name);
}
