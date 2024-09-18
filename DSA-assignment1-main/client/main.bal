import ballerina/io;
import ballerina/http;

public type Lecturers record {|
    readonly int staffNumber;
    int officeNumber;
    string firstName;
    string lastName;
    string title;
    string[] listOfCourses;
    string faculty;
|};

public function main() returns error?{

    http:Client questionOneClient = check new("localhost:9000");
    // io:println("Response from the server",lecturer.toJsonString());

    // 8. Gets the names of all the lecturers
    Lecturers []allLecturer = check questionOneClient -> get ("/allLecturers");
    io:println("This is the start" + allLecturer.toString() + "\n");

    // 1. add a lecturer
    // It works despite mentioning an error in terminal

    Lecturers rand = check questionOneClient->/addLecturer.post({
        staffNumber: 60, 
        officeNumber: 1000, 
        firstName: "Francois",
        lastName: "Evrard",
        title: "junior lecturer",
        listOfCourses: ["Math","English","Computer Science"],
        faculty: "Computing" 
    });
    io:println("\nPOST request:" + rand.toJsonString());



    // 2.Get all lecturers in same faculty
    table <Lecturers> test = check questionOneClient ->/searchLecturerInFaculty(faculty = "bio");
    io:println(test);



    // 3. Update existing data 

    Lecturers thing = check questionOneClient->/updateLecturer.put({
        staffNumber: 1, 
        officeNumber: 1000, 
        firstName: "Francois",
        lastName: "normandie",
        title: "junior lecturer",
        listOfCourses: ["Math","English","Computer Science"],
        faculty: "Computing" 
    });
    io:println("\nPOST request:" + thing.toJsonString());




    // 4. Search for lecturer via staffNumber
    table <Lecturers> lecturerStaffNumber = check questionOneClient ->/searchLecturerByNumber(staffNumber = 1);
    io:println(lecturerStaffNumber);
    
    // 5. Delete lecturer by staff number

    // 6. Get all lecturers by course 
    table <Lecturers> lecturerByCourse = check questionOneClient ->/searchLecturerByCourse(courseName = ["math"]);
    io:println(lecturerByCourse);

    // 7. Get all lecturers in same office
    table <Lecturers> lecturerByOfficeNumber = check questionOneClient ->/searchLecturerByOffice(officeNumber = 2);
    io:println(lecturerByOfficeNumber);

}




