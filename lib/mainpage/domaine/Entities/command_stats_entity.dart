import 'package:equatable/equatable.dart';

class CommandStatsEntity extends Equatable {
  final int totalCommandes;
  final List<StatsItem> status;

  const CommandStatsEntity({
    required this.totalCommandes,
    required this.status,
  });

  @override
  List<Object?> get props => [
        totalCommandes,
      ];
}

class StatsItem extends Equatable {
  final String name;

  final int count;
  final num percentage;

  const StatsItem({
    required this.name,
    required this.count,
    required this.percentage,
  });
  @override
  List<Object?> get props => [name, count, percentage];
}
