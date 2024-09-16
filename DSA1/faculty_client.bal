import ballerina/http;
import ballerina/io;

public type Lecturer record {
    string staffNumber;
    string officeNumber;
    string staffName;
    string title;
    Course[] courses;
};

public type Course record {
    string courseName;
    string courseCode;
    int nqfLevel;
};

public function main() returns error? {
    http:Client facultyClient = check new ("http://localhost:8080/api");

    // Add a new lecturer
    Lecturer newLecturer = {
        staffNumber: "L001",
        officeNumber: "O101",
        staffName: "John Doe",
        title: "Professor",
        courses: [
            {courseName: "Introduction to Programming", courseCode: "CS101", nqfLevel: 5}
        ]
    };
    http:Response addResponse = check facultyClient->post("/lecturers", newLecturer);
    io:println("Add lecturer response status: ", addResponse.statusCode);

    // Get all lecturers
    Lecturer[] allLecturers = check facultyClient->get("/lecturers");
    io:println("All lecturers: ", allLecturers);

    // Get a specific lecturer
    Lecturer specificLecturer = check facultyClient->get("/lecturers/L001");
    io:println("Specific lecturer: ", specificLecturer);

    // Update a lecturer
    Lecturer updatedLecturer = {
        staffNumber: "L001",
        officeNumber: "O102",
        staffName: "John Doe",
        title: "Associate Professor",
        courses: [
            {courseName: "Introduction to Programming", courseCode: "CS101", nqfLevel: 5},
            {courseName: "Data Structures", courseCode: "CS201", nqfLevel: 6}
        ]
    };
    Lecturer updatedResponse = check facultyClient->put("/lecturers/L001", updatedLecturer);
    io:println("Updated lecturer: ", updatedResponse);

    // Get lecturers by course
    Lecturer[] lecturersByCourse = check facultyClient->get("/lecturers/course/CS101");
    io:println("Lecturers teaching CS101: ", lecturersByCourse);

    // Get lecturers by office
    Lecturer[] lecturersByOffice = check facultyClient->get("/lecturers/office/O102");
    io:println("Lecturers in office O102: ", lecturersByOffice);

    // Delete a lecturer
    http:Response deleteResponse = check facultyClient->delete("/lecturers/L001");
    io:println("Delete lecturer response status: ", deleteResponse.statusCode);
}