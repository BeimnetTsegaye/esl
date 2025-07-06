import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esl/core/bloc/selected_program_bloc.dart';

class BlocProviders {
  static List<BlocProvider> get providers => [
        BlocProvider<SelectedProgramBloc>(
          create: (context) => SelectedProgramBloc(),
        ),
      ];
}
