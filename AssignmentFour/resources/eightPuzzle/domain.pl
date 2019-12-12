staticPreds([upFrom/2, downFrom/2, leftFrom/2, rightFrom/2]).
metaLevelPreds([]).

op(up, [Tile, TilePosition, SpacePosition],
   [spaceAt(SpacePosition), upFrom(SpacePosition, TilePosition), tileAt(Tile, TilePosition)],
   [not(tileAt(Tile, TilePosition)),tileAt(Tile, SpacePosition), not(spaceAt(SpacePosition)), spaceAt(TilePosition)],
   1).

op(down, [Tile, TilePosition, SpacePosition],
   [spaceAt(SpacePosition), downFrom(SpacePosition, TilePosition), tileAt(Tile, TilePosition)],
   [not(tileAt(Tile, TilePosition)),tileAt(Tile, SpacePosition), not(spaceAt(SpacePosition)), spaceAt(TilePosition)],
   1).

op(left, [Tile, TilePosition, SpacePosition],
   [spaceAt(SpacePosition), leftFrom(SpacePosition, TilePosition), tileAt(Tile, TilePosition)],
   [not(tileAt(Tile, TilePosition)),tileAt(Tile, SpacePosition), not(spaceAt(SpacePosition)), spaceAt(TilePosition)],
   1).

op(right, [Tile, TilePosition, SpacePosition],
   [spaceAt(SpacePosition), rightFrom(SpacePosition, TilePosition), tileAt(Tile, TilePosition)],
   [not(tileAt(Tile, TilePosition)),tileAt(Tile, SpacePosition), not(spaceAt(SpacePosition)), spaceAt(TilePosition)],
   1).
