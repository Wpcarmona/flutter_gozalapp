

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:gozalapp/infraestructure/inputs/inputs.dart';
import 'package:gozalapp/presentation/providers/auth/auth_provider.dart';

enum FormTagStatus {invalid, valid, validating}


final tagFormProvider = StateNotifierProvider.autoDispose<TagFormNotifier, TagFormState>((ref){

  final tagCallBack = ref.watch(authProvider.notifier).updateUserTag;

  return TagFormNotifier(tagCallback: tagCallBack);
});


class TagFormNotifier extends StateNotifier<TagFormState> {
  final Function(String) tagCallback;

  TagFormNotifier({
    required this.tagCallback,
  }) : super(const TagFormState());

  void onTagChanged(String tag) {
    final newTag = Tag.dirty(tag);
    state = state.copyWith(
      tag: newTag, 
      isValid:  Formz.validate([newTag]));
  }

  void onFormSubmit() async {
    if (!state.isValid) return;
    state = state.copyWith(formStatus: FormTagStatus.validating);
    await tagCallback(state.tag.value);
    state = state.copyWith(formStatus: FormTagStatus.valid);
  }
}


class TagFormState{
  final FormTagStatus formStatus;
  final bool isValid;
  final Tag tag;

  const TagFormState({
   this.formStatus = FormTagStatus.invalid,
   this.isValid = false,
   this.tag = const Tag.pure(),
  });

  TagFormState copyWith({
    FormTagStatus? formStatus,
    bool? isValid,
    Tag? tag,
  }) {
    return TagFormState(
      formStatus: formStatus ?? this.formStatus,
      isValid: isValid ?? this.isValid,
      tag: tag ?? this.tag,
    );
  }
}