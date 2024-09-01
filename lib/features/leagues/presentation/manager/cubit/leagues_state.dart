part of 'leagues_cubit.dart';

sealed class LeaguesState {}

final class LeaguesInitial extends LeaguesState {}

final class Leagueslaoding extends LeaguesState {}

final class LeaguesSuccess extends LeaguesState {}

final class LeaguesFailure extends LeaguesState {
  final String err;

  LeaguesFailure({required this.err});
}

final class GetLeaguesSuccess extends LeaguesState {
  final List<League> leaguesList;

  GetLeaguesSuccess({required this.leaguesList});
}

final class GetPlayersSuccess extends LeaguesState {
  final List<Player> playersList;

  GetPlayersSuccess({required this.playersList});
}

final class GetMatchesSuccess extends LeaguesState {
  final List<Fixture> fixtures;

  GetMatchesSuccess({required this.fixtures});
}

final class GenerateMatchesSuccess extends LeaguesState {
  final League league;

  GenerateMatchesSuccess({required this.league});
}