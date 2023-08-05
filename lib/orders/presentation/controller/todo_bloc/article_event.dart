import 'package:bts_technologie/logistiques/domaine/entities/article_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CommandEvent extends Equatable {
  const CommandEvent();

  @override
  List<Object> get props => [];
}

class GetCommandesEvent extends CommandEvent {}

class GetUnDoneTodoEvent extends CommandEvent {}

class AddTodoEvent extends CommandEvent {
  final Article todo;
  const AddTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}

class EditTodoEvent extends CommandEvent {}

class DeleteTodoEvent extends CommandEvent {}
