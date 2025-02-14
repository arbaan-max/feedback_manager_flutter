part of 'feed_back_bloc.dart';

/// State for feedback
class FeedBackState extends Equatable {
  final bool isLoading;
  final String errorMessage;
  final String successMessage;
  final List<FeedbackFormModel> feedbackList;

  const FeedBackState({
    this.isLoading = false,
    this.errorMessage = '',
    this.successMessage = '',
    this.feedbackList = const [],
  });

  /// Copy with method to update state
  FeedBackState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    List<FeedbackFormModel>? feedbackList,
  }) {
    return FeedBackState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      feedbackList: feedbackList ?? this.feedbackList,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, successMessage, feedbackList];
}
