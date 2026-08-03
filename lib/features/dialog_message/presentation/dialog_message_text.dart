import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/features/dialog_message/cubit/dialog_message_cubit.dart';
import 'package:flutter_math_app/features/dialog_message/presentation/widgets/animated_dialog_text.dart';

class DialogMessageText extends StatelessWidget {
  const DialogMessageText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DialogMessageCubit, DialogMessageState>(
      buildWhen: (previous, current) {
        if ((previous.dialogMessageEvent != current.dialogMessageEvent)) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        return state.dialogMessageEvent != null
            ? AnimatedDialogText(
                //key: ValueKey(state.dialogMessageEvent!.id),
                message: state.dialogMessageEvent!.message,
                upperMessage: state.dialogMessageEvent!.upperMessage,
              )
            : SizedBox.shrink();
      },
    );
  }
}
