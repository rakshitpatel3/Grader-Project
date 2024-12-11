---

## Introduction

Welcome to the **OSU CSE Grader Assignment System**, a web application for the CSE department at the Ohio State University to assist in assigning graders.

---

## Team Members

**Au 24 Team 2**

- **Project Manager:** Pranav
- **UI Designer / Tester:** Tony
- **Backend Developer 1:** Adam
- **Backend Developer 2:** Darin
- **View Developer 1:** Abdi
- **View Developer 2:** Rakshit

---

## Installation

To install the CSE Grader Assignment System:

1. **Clone the Repository:**
   - Download the project by cloning the repository using Git:
     ```bash
     git clone 
     ```

2. **Extract Files:**
   - Download the zip file at this link: https://github.com/cse-3901-sharkey/2024-au-Team-2-Lab-3.git
     Extract the files contained in the zip

3. **Open Folder in IDE:**
   - Open the folder in an IDE such as VSCode
        * Make sure you have Ruby on Rails set up

4. **IDE terminal:**
   - In the IDE terminal type:
     ```bash
     cd course_catalog
     rails db:migrate
     rails db:seed
     rails console
     service = CourseService.new
     service.fetch_all_courses_and_sections
     rails server
     ```
5. **Access the Application:**
   - Visit:   ```http://localhost:3000/users/sign_in``` in your browser
     
6. **Default Admin Account:**
   - Login with default admin account or create a new account
   - Email:   ```admin.1@osu.edu```
   - Password:   ```password```
  

---

## General Features
- **Login/Logout:** Implemented using devise gem, allowing users to securely log in and out.
- **Registration:** User must register with an email with name.#@osu.edu format
- **User Roles:** User must select a role (Student, Instructor, Admin) during register 
- **Password Reset:** User can reset the password on the profile page.

---

## Role-Specific Features
- **Students:**

  - log in and view the list of available courses and sections from the CSE department
  - fill out a form to be considered for a grading position
  - update their application for a grading position after submission
    
- **Instructors:**
  
  - log in and view the list of available courses and sections from the CSE department
  - fill out a form to recommend students to be hired for a course or a particular section
     - students who are not logged in, will log in with the OSU email that was recommended with the default password: ```password``` (which can be changed after logging in) 
    
- **Admin:**
  
   - log in and view, edit (add, delete, change) courses and sections
   - reload the course catalog
   - approve Instructor or Admin role requests
   - view and edit the number of graders required or assigned
  

---

## API Information
The OSU Course Catalog API is used to retrieve course and section details: 
API Link: https://contenttest.osu.edu/v2/classes/searchLinks

valid parameters are:

    q=   (can be blank, or cse for CSE Classes)
    client=class-search-ui
    campus=   (col for Columbus)
    p=  (page #, starting at 1)
    term=  (1222 for Spring 2022, 1244 for Summer 2024)
    academic-career=ugrad (for undergrad only classes)
    subject=   (blank, or cse)
    class-attribute=ge2
    
