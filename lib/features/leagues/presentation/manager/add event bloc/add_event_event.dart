part of 'add_event_bloc.dart';

@immutable
abstract class AddEventEvent {}

final class AddEvent extends AddEventEvent {
  final String title;
  final String description;
  final String place;
  final DateTime date;
  final XFile? image;

  AddEvent({required this.title, required this.description, required this.place, required this.date, required this.image});
}
