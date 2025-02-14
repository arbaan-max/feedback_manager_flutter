/// FeedbackForm is a data class that stores data fields of Feedback.
class FeedbackFormModel {
  final String name;
  final String email;
  final int mobileNo;
  final String feedback;

  const FeedbackFormModel({
    required this.name,
    required this.email,
    required this.mobileNo,
    required this.feedback,
  });

  /// Factory method to create an instance from JSON.
  factory FeedbackFormModel.fromJson(Map<String, dynamic> json) {
    return FeedbackFormModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobileNo: int.tryParse(json['mobileNo']?.toString() ?? '0') ?? 0,
      feedback: json['feedback'] ?? '',
    );
  }

  /// Converts the instance to JSON format.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'mobileNo': mobileNo,
      'feedback': feedback,
    };
  }
}
