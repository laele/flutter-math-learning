import 'package:flutter_math_app/core/entities/domain_event.dart';
import 'package:flutter_math_app/features/tutorial/domain/enums/tutorial_phase.dart';

class TutorialPhaseEvent extends DomainEvent {
  final TutorialPhase phase;
  const TutorialPhaseEvent({required int super.id, required this.phase});

  @override
  List<Object?> get props => [...super.props, phase];
}
