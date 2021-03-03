import 'package:app/blocs/profileform/bloc.dart';
import 'package:app/formModels/Email.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';

main() {
  group("Si l'event est EmailProfileUpdated", () {
    test("Doit rendre valid le formulaire si l'email est correct", () async {
      // ARRANGE
      // ignore: close_sinks
      final ProfileFormBloc profileFormBloc = ProfileFormBloc();

      // ACT
      Stream<ProfileFormState> profileFormState =
          profileFormBloc.mapEventToState(
        EmailProfileUpdated(email: 'john.doe@domain.tld'),
      );

      // ASSERT
      expect(
        await profileFormState.first,
        ProfileFormState(
          email: Email.dirty('john.doe@domain.tld'),
          status: Formz.validate([Email.dirty('john.doe@domain.tld')]),
        ),
      );
    });

    test("Doit rendre invalid le formulaire si l'email n'est pas correct",
        () async {
      // ARRANGE
      // ignore: close_sinks
      final ProfileFormBloc profileFormBloc = ProfileFormBloc();

      // ACT
      Stream<ProfileFormState> profileFormState =
          profileFormBloc.mapEventToState(
        EmailProfileUpdated(email: 'john'),
      );

      // ASSERT
      expect(
        await profileFormState.first,
        ProfileFormState(
          email: Email.pure('john'),
          status: Formz.validate([Email.dirty('john')]),
        ),
      );
    });
  });

  group("Si l'event est ProfileFormSubmitted", () {
    test("Doit permet la validation du formulaire", () async {
      // ARRANGE
      // ignore: close_sinks
      final ProfileFormBloc profileFormBloc = ProfileFormBloc();

      // ACT
      profileFormBloc.emit(ProfileFormState(
        email: Email.dirty('john.doe@domain.tld'),
        status: Formz.validate([Email.dirty('john.doe@domain.tld')]),
      ));

      Stream<ProfileFormState> profileFormState =
          profileFormBloc.mapEventToState(
        ProfileFormSubmitted(),
      );

      // ASSERT
      expect(
        await profileFormState.first,
        ProfileFormState(
          email: Email.dirty('john.doe@domain.tld'),
          status: FormzStatus.submissionInProgress,
        ),
      );
    });

    test("Doit d'invalider le formulaire", () async {
      // ARRANGE
      // ignore: close_sinks
      final ProfileFormBloc profileFormBloc = ProfileFormBloc();

      // ACT
      profileFormBloc.emit(ProfileFormState(
        email: Email.dirty('john'),
        status: Formz.validate([Email.dirty('john')]),
      ));

      Stream<ProfileFormState> profileFormState =
          profileFormBloc.mapEventToState(
        ProfileFormSubmitted(),
      );

      // ASSERT
      expect(
        await profileFormState.first,
        ProfileFormState(
          email: Email.pure('john'),
          status: FormzStatus.invalid,
        ),
      );
    });
  });
}
