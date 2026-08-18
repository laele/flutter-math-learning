import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_app/core/l10n/arb/app_localizations.dart';
import 'package:flutter_math_app/core/theme/app_colors.dart';
import 'package:flutter_math_app/features/player_prefs/presentation/cubit/player_profile_cubit.dart';

class EditablePlayerName extends StatefulWidget {
  const EditablePlayerName({
    super.key,
  });

  @override
  State<EditablePlayerName> createState() => _EditablePlayerNameState();
}

class _EditablePlayerNameState extends State<EditablePlayerName> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.text = context.read<PlayerProfileCubit>().state.profile.playerName;
    _focusNode.addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocConsumer<PlayerProfileCubit, PlayerProfileState>(
      listenWhen: (previous, current) => previous.profile != current.profile,
      listener: (context, state) {
        _controller.text = context.read<PlayerProfileCubit>().state.profile.playerName;
      },
      buildWhen: (previous, current) => previous.profile.playerName != current.profile.playerName,
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: l10n.hello,
              labelStyle: const TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),

              floatingLabelStyle: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              suffixIcon: _focusNode.hasFocus
                  ? const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.edit_rounded,
                      color: Colors.white70,
                    ),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(24.0)),
                borderSide: BorderSide(color: AppColors.onPrimaryBorder, strokeAlign: 1.0, width: 4),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: AppColors.onPrimaryBorder.withValues(alpha: 0.55), strokeAlign: 1.0, width: 4),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: AppColors.onPrimaryBorder, strokeAlign: 1.0, width: 4),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: Colors.red, strokeAlign: 1.0, width: 4),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: Colors.red, strokeAlign: 1.0, width: 4),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            ),

            maxLength: 12,
            buildCounter:
                (
                  context, {
                  required currentLength,
                  required isFocused,
                  required maxLength,
                }) {
                  if (!isFocused) return null;

                  return Text(
                    '$currentLength/$maxLength',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                    ),
                  );
                },
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),
            controller: _controller,
            focusNode: _focusNode,
            autofocus: false,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.enterYourName;
              }

              if (value.trim().length < 3) {
                return l10n.minimumCharacters;
              }

              return null;
            },
            onTapOutside: (event) {
              _controller.text = context.read<PlayerProfileCubit>().state.profile.playerName;
              _focusNode.unfocus();
            },
            onFieldSubmitted: (value) {
              setState(() {
                if (_formKey.currentState!.validate()) {
                  context.read<PlayerProfileCubit>().updateName(name: value.trim());
                } else {
                  _controller.text = context.read<PlayerProfileCubit>().state.profile.playerName;
                }
              });
            },
          ),
        );
      },
    );
  }
}
