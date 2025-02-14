import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:scan_to_excel/data/model.data.dart';

// Google App Script Web URL
const String sheetWebUrl = "https://script.google.com/macros/s/<SCRIPT-KEY>/exec";

/// FormController is a class that saves FeedbackForm in Google Sheets using
/// Dio for HTTP requests and parses the response to send result callbacks.
class FormService {
  // Success Status Message
  static const String statusSuccess = "SUCCESS";

  final Dio _dio = Dio();

  /// Async function to submit the form using Dio.
  /// It parses [feedbackForm] parameters and sends a POST request to [url].
  /// On successful response, [callback] is called.
  Future<void> submitForm(FeedbackFormModel feedbackForm, void Function(String) callback) async {
    try {
      final response = await _dio.post(
        sheetWebUrl,
        data: feedbackForm.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          followRedirects: false,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      // Handle Redirect
      if (response.statusCode == 302) {
        final redirectUrl = response.headers['location']?.first;
        if (redirectUrl != null) {
          final redirectResponse = await _dio.get(redirectUrl);
          final status = redirectResponse.data['status'];
          callback(status == FormService.statusSuccess ? FormService.statusSuccess : "Failed");
        } else {
          callback("Failed");
        }
        return;
      }

      // Handle Success
      if (response.statusCode == 200) {
        final status = response.data['status'];
        callback(status == FormService.statusSuccess ? FormService.statusSuccess : "Failed");
      } else {
        callback("Failed");
      }
    } catch (e) {
      log("Error: $e");
      callback("Error");
    }
  }

  /// Method to fetch the list of feedbacks using Dio.
  Future<List<FeedbackFormModel>> getFeedbackList() async {
    try {
      final response = await _dio.get(
        sheetWebUrl,
        options: Options(
          followRedirects: true,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      // Log response for debugging
      log("Response data: ${response.data}");

      if (response.statusCode == 200) {
        // Directly cast the response data to List<dynamic>
        var jsonFeedback = response.data;

        if (jsonFeedback is List) {
          // Map remaining items to FeedbackForm list
          return jsonFeedback.map((json) => FeedbackFormModel.fromJson(Map<String, dynamic>.from(json))).toList();
        } else {
          throw Exception("Unexpected data format");
        }
      } else {
        throw Exception("Failed to load feedback");
      }
    } catch (e) {
      log("Error: $e");
      return [];
    }
  }
}
