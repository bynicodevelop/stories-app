import 'package:app/blocs/sluginput/bloc.dart';
import 'package:app/formModels/Slug.dart';
import 'package:app/widgets/forms/TextInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SlugInput extends StatelessWidget {
  final Function(String) onChanged;
  final String label;
  final String errorMessage;

  const SlugInput({
    Key key,
    @required this.onChanged,
    @required this.label,
    @required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SlugInputBloc, SlugInputState>(
      listener: (context, state) {
        onChanged(state.slug.value);
      },
      child: BlocBuilder<SlugInputBloc, SlugInputState>(
        builder: (context, state) {
          return TextInput(
            label: label,
            prefixIcon: Icon(Icons.alternate_email),
            errorText: state.slug.error != SlugInputError.empty &&
                    state.slug.error != null
                ? errorMessage
                : null,
            onChanged: (value) => context.read<SlugInputBloc>().add(
                  SlugChanged(
                    slug: value,
                  ),
                ),
          );
        },
      ),
    );
  }
}
