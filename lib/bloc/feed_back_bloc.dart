import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scan_to_excel/data/model.data.dart';
import 'package:scan_to_excel/data/service.dart';

part 'feed_back_event.dart';
part 'feed_back_state.dart';

class FeedBackBloc extends Bloc<FeedBackEvent, FeedBackState> {
  FeedBackBloc({required this.service}) : super(FeedBackState()) {
    on<SubmitFeedBack>(_onFeedBackSubmit);
    on<GetFeedBacks>(_onGetFeedBacks);
  }

  final FormService service;

  /// Method to handle submitting feedback
  Future<void> _onFeedBackSubmit(SubmitFeedBack event, Emitter<FeedBackState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));
    try {
      await service.submitForm(event.feedbackForm, (String response) {
        if (response == FormService.statusSuccess) {
          emit(state.copyWith(isLoading: false, successMessage: 'Feedback submitted successfully'));
        } else {
          emit(state.copyWith(isLoading: false, errorMessage: 'Submission failed'));
        }
      });
    } catch (error) {
      emit(state.copyWith(isLoading: false, errorMessage: error.toString()));
    }
  }

  /// Method to handle getting feedback list
  Future<void> _onGetFeedBacks(GetFeedBacks event, Emitter<FeedBackState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));
    try {
      final feedbackList = await service.getFeedbackList();
      emit(state.copyWith(isLoading: false, feedbackList: feedbackList));
    } catch (error) {
      emit(state.copyWith(isLoading: false, errorMessage: error.toString()));
    }
  }
}
