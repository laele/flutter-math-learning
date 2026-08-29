import 'package:flutter_math_app/core/entities/domain_event.dart';
import 'package:flutter_math_app/features/tutorial/domain/entities/tutorial_step_entity.dart';

class TutorialStepEvent extends DomainEvent {
  final TutorialStepEntity step;
  const TutorialStepEvent({required super.id, required this.step});

  @override
  List<Object?> get props => [...super.props, this.step];
}
