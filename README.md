<!-- Features -->

## Submit Feedback:

Users can submit their name, email, mobile number, and feedback.
Data is sent to a Google Sheets document using a POST request.
View Feedback:

Feedback is displayed in a list format, showing the name, email, and feedback message.
Data is retrieved from Google Sheets using a GET request.
Dio Integration:

Dio package is used for making HTTP requests in the Flutter app.
This improves error handling and performance compared to the traditional http package.

<!-- How It Works -->

## Google Apps Script (Backend)

Google Sheets is used as the database to store feedback data.
A Google Apps Script is deployed as a web app to handle POST and GET requests.
Flutter App (Frontend)

Users enter feedback details in a form.
Data is sent to Google Sheets using Dio's POST method.
The app fetches the list of feedback using Dio's GET method and displays it.

<!-- Google Apps Script Code -->

## Post Method

This method receives the feedback details and saves them as a new row in the Google Sheets document.
function doPost(request) {
var sheet = SpreadsheetApp.openById("YOUR_SHEET_ID");
var result = { "status": "SUCCESS" };

try {
var name = request.parameter.name;
var email = request.parameter.email;
var mobileNo = request.parameter.mobileNo;
var feedback = request.parameter.feedback;

    sheet.appendRow([name, email, mobileNo, feedback]);

} catch (exc) {
result = { "status": "FAILED", "message": exc };
}

return ContentService
.createTextOutput(JSON.stringify(result))
.setMimeType(ContentService.MimeType.JSON);
}

## Get Method

This method retrieves all the feedback from the Google Sheets document and returns it as a JSON array.
function doGet(request){
var sheet = SpreadsheetApp.openById("YOUR_SHEET_ID");
var values = sheet.getActiveSheet().getDataRange().getValues();
var data = [];

for (var i = values.length - 1; i >= 0; i--) {
var row = values[i];
var feedback = {};

    feedback['name'] = row[0];
    feedback['email'] = row[1];
    feedback['mobile_no'] = row[2];
    feedback['feedback'] = row[3];

    data.push(feedback);

}

return ContentService
.createTextOutput(JSON.stringify(data))
.setMimeType(ContentService.MimeType.JSON);
}

<!-- How to Use -->

## Google Sheets Setup:

Create a new Google Sheets document.
Go to Extensions > Apps Script and paste the above code.
Replace YOUR_SHEET_ID with the ID of your Google Sheets document.
Deploy the script as a web app and copy the deployment URL.
Flutter Setup:

Clone this repository.
Update the webAppUrl and URL in FormService with the Google Apps Script deployment URL.
Run the Flutter app using:

## flutter run
