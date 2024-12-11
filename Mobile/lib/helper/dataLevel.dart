import 'package:flutter/material.dart';
import 'package:elmanasa/model/levelModel.dart';

List<LevelModel> getLevel() {
  List<LevelModel> levels = <LevelModel>[];

  LevelModel levelmodel11 =
      LevelModel(level: 1, logo: '1 One', stage: 'Primary');
  levels.add(levelmodel11);
  LevelModel levelmodel12 =
      LevelModel(level: 2, logo: '1+2=3', stage: 'Primary');
  levels.add(levelmodel12);
  LevelModel levelmodel13 =
      LevelModel(level: 3, logo: '6 × 2 = 12', stage: 'Primary');
  levels.add(levelmodel13);
  LevelModel levelmodel14 =
      LevelModel(level: 4, logo: '15 ÷ 3 = 5', stage: 'Primary');
  levels.add(levelmodel14);
  LevelModel levelmodel15 =
      LevelModel(level: 5, logo: '4² = 16', stage: 'Primary');
  levels.add(levelmodel15);
  LevelModel levelmodel16 =
      LevelModel(level: 6, logo: '2x + 5 = 15', stage: 'Primary');
  levels.add(levelmodel16);
  LevelModel levelmodel21 =
      LevelModel(level: 1, logo: 'A=L×W', stage: 'Preparatory');
  levels.add(levelmodel21);
  LevelModel levelmodel22 =
      LevelModel(level: 2, logo: '√64 = 8', stage: 'Preparatory');
  levels.add(levelmodel22);
  LevelModel levelmodel23 =
      LevelModel(level: 3, logo: 'x²-5x+6=0', stage: 'Preparatory');
  levels.add(levelmodel23);

  LevelModel levelmodel31 =
      LevelModel(level: 1, logo: 'log₁₀ 100 = 2', stage: 'Secondary');
  levels.add(levelmodel31);
  LevelModel levelmodel32 =
      LevelModel(level: 2, logo: 'sin²(x)+cos²(x)=1', stage: 'Secondary');
  levels.add(levelmodel32);
  LevelModel levelmodel33 =
      LevelModel(level: 3, logo: 'dx/d(x²)=2x', stage: 'Secondary');
  levels.add(levelmodel33);

  return levels;
}
