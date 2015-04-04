<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User Manual</title>
</head>
<body>
<h1>RadiologyApp User Manual</h1>

<h2 id="login-module">Login Module</h2>
<p>All register users are able to login to the app with proper privileges and they can also modify their own personal information and change the password.</p>
<h3 id="login">Login</h3>
<p>Enter a pair of  correct username and password, then click “LOGIN” button to login to the system. If you entered wrong username or password, if you be asked to enter them again.</p>
<h3 id="modify-personal-profile-and-change-password">Modify Personal Profile and Change Password</h3>
<p>In order to change your profile or password, click the “Edit My Profile and Password” in your homepage once you successfully logged in.</p>
<p>You are able to modify the following items:
First Name, Last Name, Address, Email, Phone, Password
After editing the information, click “Update” button to save the changes.</p>
<h2 id="report-generating-module">Report Generating Module</h2>
<p>Any system administrator can get the list of all patients with a specified diagnosis for a given time period. 
For each patient, the list includes the name, address and phone number of the patient, and testing date of the first radiology record that contains the specified diagnosis.</p>
<h3 id="generate-report">Generate Report</h3>
<p>Once you logged into the system as an administrator, you would find a button called “Generate Report”. Click it, you will be redirected to the report generating page.</p>
<p>Input a diagnosis, and give a specific time period by selecting From date and To date.</p>
<p>Click the “Generate” button to generate the report after a diagnosis and time period is specified. Click the “Return” button return to the homepage.</p>
<p>The report contains the list of all patients with the specified diagnosis for the given time period. For each patient, the list contains the Patient Name, Address, Phone Number of the patient, and Test Date of the first radiology record that contains the specified diagnosis.</p>
<h2 id="user-management-module">User Management Module</h2>
<p>Once logged in to the database and the application as an admin user, click the option on the admin homepage to manage users. The links at the top of the User Management page can be used to navigate between viewing all persons, users, and family doctor relations.</p>
<p>To add a new record to any of these three tables, first navigate to the table you would like to add to, then select the add button above the displayed table. You will be presented with a form for all of the required information for the new person, user, or family doctor. Please fill out all fields and select submit at the bottom of the form. Once submitted, you will be redirected back to the displayed table of the table added to where you can check to make sure your new record has been added. 
To edit a record of any of the three tables, first navigate to the table you would like to edit. Scroll through the table to find the record you would like to edit and select the “edit” button on the far ride side in the row of the record you would like to edit. Once selected, you will be presented with a pre filled form with all of the data currently stored in the selected record. Here you can make changes to any of the fields and select update when you are finished. Be careful not to select the delete option at the very bottom of the page.</p>
<h2 id="upload-module">Upload Module</h2>
<p>To upload a radiology record and attach images to the uploaded record, begin by logging in to the database and application as a radiologist user. On the radiologist home page, you can find the option to “upload” at the bottom of the page. Once selected you will be presented with a form of all required fields for the radiology record. Please fill in all of the fields and select submit when you’d like to upload the record. </p>
<p>You will be presented with a “record upload result” page where you can verify what information has been stored in the database as this result is pulled directly from the database. </p>
<p>To attach an image to this record, select the “attach image” link above the displayed record result table. You will be presented with a form containing the record id and two buttons: one for selecting which image to upload and one for submitting the image. First select an image by selecting the “choose file” button. You will be presented with a navigation window for your computer. Once a JPG file has been selected, you can select “submit” to attach the image to the record you’ve uploaded.
You will be presented with a result page for the image upload containing images retrieved directly from the database. The result page will display all three sizes generated: regular, full and thumbnail.</p>
<h2 id="search-module">Search Module</h2>
<p>In order to use the search function please select the “Search” button from the main menu. Once the page has been loaded you will be prompted with an empty field displaying “keywords” in this field if you have any keywords that you want to search for please enter them here. The next 2 fields prefixed by “From” and “To” are for entering a period of time which will filter the results of the search to records within the users entered period, the dates are to be entered as DD-MM-YYYY. </p>
<p>The last option is to select how the user wishes to the order of the results Newest first is selected by default but the user also has the option of Oldest first and finally ordered by ranking. After inputting any search terms the user wishes to display press the Fetch button and the system will search for and display the results of the users query. Any images attached to a record may be clicked and zoomed in.</p>
<p>Finally to return back to the main menu simply press the return button. </p>
<h2 id="data-analysis-module">Data Analysis Module</h2>
<p>This function is available to administrators from the main menu, its purpose is to display an OLAP report to the administrator. Upon loading the data analysis page the user will be shown a variety of drop menus. The first one prefixed by “Patient” is used for selecting either NO, ALL, or a specific patient to be displayed in the report. Similarly the “TestType” drop menu will also allow the user to select either NO, ALL, or a specific test type to be shown, and finally the time menu will allow the user to select how they wish to view the results based on Weekly, Monthly, or by Year. The user may also select a specific year.
Upon pressing the Start button the user will be shown the results of the query, if the user wishes to change the parameters they can press the “Go Back” button and go back to the previous page.</p>
<p>In order to return back to the main menu the user may press the Return button on the first page</p>

</body>
</html>