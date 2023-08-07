import 'package:bts_technologie/core/utils/enumts.dart';
import 'package:bts_technologie/orders/domaine/Entities/command_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:bts_technologie/logistiques/domaine/entities/article_entity.dart';

class CommandesState extends Equatable {
  final List<Command> getCommandes;
  final RequestState getCommandesState;
  final String getCommandesmessage;
  //
  final List<Article> getUnDoneTodo;
  final RequestState getUnDoneTodoState;
  final String getUnDoneTodomessage;

  // final ToDo addTodo;
  final RequestState addTodoState;
  final String addTodoMessage;

  //
  final RequestState createCommandState;
  final String createCommandMessage;

  const CommandesState({
    this.getCommandes = const [],
    this.getCommandesState = RequestState.loading,
    this.getCommandesmessage = "",
    //
    this.getUnDoneTodo = const [],
    this.getUnDoneTodoState = RequestState.loading,
    this.getUnDoneTodomessage = "",
    //
    this.addTodoState = RequestState.loading,
    this.addTodoMessage = "",
    //
    this.createCommandState = RequestState.initial,
    this.createCommandMessage = "",
  });

  CommandesState copyWith({
    List<Command>? getCommandes,
    RequestState? getCommandesState,
    String? getCommandesmessage,
    //
    List<Article>? getUnDoneTodo,
    RequestState? getUnDoneTodoState,
    String? getUnDoneTodomessage,
    //
    RequestState? addTodoState,
    String? addTodoMessage,
    //
    RequestState? createCommandState,
    String? createCommandMessage,
  }) {
    return CommandesState(
      getCommandes: getCommandes ?? this.getCommandes,
      getCommandesState: getCommandesState ?? this.getCommandesState,
      getCommandesmessage: getCommandesmessage ?? this.getCommandesmessage,
      //
      getUnDoneTodo: getUnDoneTodo ?? this.getUnDoneTodo,
      getUnDoneTodoState: getUnDoneTodoState ?? this.getUnDoneTodoState,
      getUnDoneTodomessage: getUnDoneTodomessage ?? this.getUnDoneTodomessage,
      //
      addTodoState: addTodoState ?? this.addTodoState,
      addTodoMessage: addTodoMessage ?? this.addTodoMessage,

      createCommandState: createCommandState ?? this.createCommandState,
      createCommandMessage: createCommandMessage ?? this.createCommandMessage,
    );
    //
  }

  @override
  List<Object?> get props => [
        getCommandes,
        getCommandesState,
        getCommandesmessage,
        //
        getUnDoneTodo,
        getUnDoneTodoState,
        getUnDoneTodomessage,

        addTodoState,
        addTodoMessage,

        //
        createCommandState,
        createCommandMessage,
      ];
}