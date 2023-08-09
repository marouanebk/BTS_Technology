import 'package:bts_technologie/mainpage/domaine/Entities/command_stats_entity.dart';

class CommandStatsModel extends CommandStatsEntity {
  const CommandStatsModel({
    required int totalCommandes,
    required List<StatsItem> status,

    required int month,
  }) : super(
          totalCommandes: totalCommandes,
          status: status,
          month: month
        );

  factory CommandStatsModel.fromJson(Map<String, dynamic> json) {
    var statsList = json['status'] as List<dynamic>?;

    List<StatsItem> stats = [];
    if (statsList != null) {
      stats = statsList.map((statsJson) {
        return StatsItem(
          name: statsJson['name'],
          count: statsJson['count'],
          percentage: statsJson['percentage'],
        );
      }).toList();
    }

    return CommandStatsModel(
      totalCommandes: json['totalCommands'],
      month: json['month'],
      status: stats,
    );
  }
}
