import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scan_to_excel/bloc/feed_back_bloc.dart';
import 'package:scan_to_excel/data/model.data.dart';

// class FeedBackFormPage extends StatefulWidget {
//   const FeedBackFormPage({super.key});

//   @override
//   State<FeedBackFormPage> createState() => _FeedBackFormPageState();
// }

// class _FeedBackFormPageState extends State<FeedBackFormPage> {

//   // TextField Controllers
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final mobileNoController = TextEditingController();
//   final feedbackController = TextEditingController();

//   // Method to Submit Feedback and save it in Google Sheets
//   void _submitForm() {
//     // Validate returns true if the form is valid, or false
//     // otherwise.
//     if (_formKey.currentState!.validate()) {
//       // If the form is valid, proceed.
//       FeedbackFormModel feedbackForm = FeedbackFormModel(
//         name: nameController.text,
//         email: emailController.text,
//         mobileNo: int.parse(mobileNoController.text),
//         feedback: feedbackController.text,
//       );

//       FormService formController = FormService();

//       _showSnackbar("Submitting Feedback");

//       // Submit 'feedbackForm' and save it in Google Sheets.
//       formController.submitForm(feedbackForm, (String response) {
//         log("Response: $response");
//         if (response == FormService.statusSuccess) {
//           // Feedback is saved succesfully in Google Sheets.
//           _showSnackbar("Feedback Submitted");
//         } else {
//           // Error Occurred while saving data in Google Sheets.
//           _showSnackbar("Error Occurred!");
//         }
//       });
//     }
//   }

//   // Method to show snackbar with 'message'.

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: Text("Send Data To Google Sheets"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Form(
//                 key: _formKey,
//                 child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       TextFormField(
//                         controller: nameController,
//                         validator: (value) {
//                           if (value?.isEmpty == true) {
//                             return 'Enter Valid Name';
//                           }
//                           return null;
//                         },
//                         decoration: InputDecoration(labelText: 'Name'),
//                       ),
//                       TextFormField(
//                         controller: emailController,
//                         // validator: (value) {
//                         //   if (value!.contains("@")) {
//                         //     return 'Enter Valid Email';
//                         //   }
//                         //   return null;
//                         // },
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: InputDecoration(labelText: 'Email'),
//                       ),
//                       TextFormField(
//                         controller: mobileNoController,
//                         validator: (value) {
//                           if (value?.trim().length != 10) {
//                             return 'Enter 10 Digit Mobile Number';
//                           }
//                           return null;
//                         },
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           labelText: 'Mobile Number',
//                         ),
//                       ),
//                       TextFormField(
//                         controller: feedbackController,
//                         validator: (value) {
//                           if (value?.isEmpty == true) {
//                             return 'Enter Valid Feedback';
//                           }
//                           return null;
//                         },
//                         keyboardType: TextInputType.multiline,
//                         decoration: InputDecoration(labelText: 'Feedback'),
//                       ),
//                     ],
//                   ),
//                 )),
//             SizedBox(
//               width: 200,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: _submitForm,
//                 child: Text('Submit Feedback'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class FeedBackFormPage extends StatefulWidget {
  const FeedBackFormPage({super.key});

  @override
  State<FeedBackFormPage> createState() => _FeedBackFormPageState();
}

class _FeedBackFormPageState extends State<FeedBackFormPage> {
//   // Create a global key that uniquely identifies the Form widget
//   // and allows validation of the form.
//   //
//   // Note: This is a `GlobalKey<FormState>`,
//   // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNoController = TextEditingController();
  final feedbackController = TextEditingController();

  void _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileNoController.dispose();
    feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Send Data To Google Sheets"),
      ),
      body: BlocConsumer<FeedBackBloc, FeedBackState>(
        listener: (context, state) {
          if (state.successMessage.isNotEmpty) {
            _showSnackbar(state.successMessage);
            nameController.clear();
            emailController.clear();
            mobileNoController.clear();
            feedbackController.clear();
          } else if (state.errorMessage.isNotEmpty) {
            _showSnackbar(state.errorMessage);
          }
        },
        builder: (context, state) {
          final loading = state.isLoading;
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Name';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(labelText: 'Name'),
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                            if (!emailRegex.hasMatch(value)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: mobileNoController,
                          validator: (value) {
                            if (value?.trim().length != 10) {
                              return 'Enter 10 Digit Mobile Number';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Mobile Number',
                          ),
                        ),
                        TextFormField(
                          controller: feedbackController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Valid Feedback';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(labelText: 'Feedback'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: loading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              /// Close KeyBoard
                              FocusScope.of(context).requestFocus(FocusNode());

                              /// Create Feedback Form Model Instance
                              final feedbackForm = FeedbackFormModel(
                                name: nameController.text,
                                email: emailController.text,
                                mobileNo: int.parse(mobileNoController.text),
                                feedback: feedbackController.text,
                              );

                              // Trigger the event
                              context.read<FeedBackBloc>().add(
                                    SubmitFeedBack(feedbackForm: feedbackForm),
                                  );
                            }
                          },
                    child: loading ? const CircularProgressIndicator(color: Colors.white) : const Text('Submit Feedback'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
