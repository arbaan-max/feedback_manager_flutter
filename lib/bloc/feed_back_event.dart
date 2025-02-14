part of 'feed_back_bloc.dart';

sealed class FeedBackEvent extends Equatable {
  const FeedBackEvent();

  @override
  List<Object> get props => [];
}

class SubmitFeedBack extends FeedBackEvent {
  const SubmitFeedBack({required this.feedbackForm});
  final FeedbackFormModel feedbackForm;

  @override
  List<Object> get props => [feedbackForm];
}

class GetFeedBacks extends FeedBackEvent {
  const GetFeedBacks();

  @override
  List<Object> get props => [];
}
