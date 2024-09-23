import ballerina/http;
import ballerina/io;

type Programme record {
    string code;
    string nqfLevel;
    string faculty;
    string department;
    string title;
    int registrationDate;
    string[] courses;
};

public function main() returns error? {
    // Create an HTTP client to connect to the service
    http:Client programmeClient = check new ("http://localhost:9090");

    while (true) {
        io:println("1. Add Programme");
        io:println("2. Update Programme record");
        io:println("3. Delete Programme record by code");
        io:println("4. View All Programme records");
        io:println("5. View Programme record by code");
        io:println("6. View Programme records by faculty");
        io:println("7. View Programme records due for review");
        io:println("0. Exit");

        string option = io:readln("Choose an option: ");

        match option {
            "0" => {
                io:println("Exiting...");
                break;
            }
            "1" => {
                check addProgramme(programmeClient);
            }
            "2" => {
                check updateProgramme(programmeClient);
            }
            "3" => {
                check deleteProgrammeByCode(programmeClient);
            }
            "4" => {
                check getAllProgrammes(programmeClient);
            }
            "5" => {
                check getProgrammeByCode(programmeClient);
            }
            "6" => {
                check getProgrammesByFaculty(programmeClient);
            }
            "7" => {
                check getProgrammesDueForReview(programmeClient);
            }
            _ => {
                io:println("Invalid option, please try again.");
            }
        }
    }
}

public function addProgramme(http:Client http) returns error? {
    Programme programme = {
        code: "", nqfLevel: "", faculty: "", department: "",
        title: "", registrationDate: 0, courses: []
    };
    programme.code = io:readln("Enter Programme code: ");
    programme.title = io:readln("Enter Programme title: ");
    programme.nqfLevel = io:readln("Enter NQF Level of Qualification: ");
    programme.faculty = io:readln("Enter Faculty name: ");
    programme.department = io:readln("Enter Department name: ");
    programme.registrationDate = check parseDate(io:readln("Enter Registration date (YYYY-MM-DD): "));

    string courseInput = io:readln("Enter course codes (comma-separated): ");
    programme.courses = handleCourseInput(courseInput);

    Programme response = check http->post("/addProgramme", programme);
    io:println("Programme added successfully: ", response);
}

public function updateProgramme(http:Client http) returns error? {
    Programme programme = {
        code: "", nqfLevel: "", faculty: "", department: "",
        title: "", registrationDate: 0, courses: []
    };
    programme.code = io:readln("Enter Programme code to update: ");
    programme.title = io:readln("Enter new Programme title: ");
    programme.nqfLevel = io:readln("Enter new NQF Level of Qualification: ");
    programme.faculty = io:readln("Enter new Faculty name: ");
    programme.department = io:readln("Enter new Department name: ");
    programme.registrationDate = check parseDate(io:readln("Enter new Registration date (YYYY-MM-DD): "));

    string courseInput = io:readln("Enter new course codes (comma-separated): ");
    programme.courses = handleCourseInput(courseInput);

    string response = check http->put("/updateProgramme", programme);
    io:println("Programme updated successfully: ", response);
}

public function deleteProgrammeByCode(http:Client http) returns error? {
    string code = io:readln("Enter Programme code to delete: ");
    string response = check http->delete("/deleteProgrammeByCode/" + code);
    io:println(response);
}

public function getAllProgrammes(http:Client http) returns error? {
    Programme[] programmes = check http->get("/getAllProgrammes");
    foreach Programme programme in programmes {
        check displayProgrammeDetails(programme);
    }
}

public function getProgrammeByCode(http:Client http) returns error? {
    string code = io:readln("Enter Programme code: ");
    Programme programme = check http->get("/getProgrammeByCode/" + code);
    check displayProgrammeDetails(programme);
}

public function getProgrammesByFaculty(http:Client http) returns error? {
    string faculty = io:readln("Enter Faculty name: ");
    Programme[] programmes = check http->get("/getProgrammesByFaculty/" + faculty);
    foreach Programme programme in programmes {
        check displayProgrammeDetails(programme);
    }
}

public function getProgrammesDueForReview(http:Client http) returns error? {
    Programme[] programmes = check http->get("/getProgrammesDueForReview/");
    foreach Programme programme in programmes {
        check displayProgrammeDetails(programme);
    }
}

function displayProgrammeDetails(Programme programme) returns error? {
    io:println("--------------------------");
    io:println("Code: ", programme.code);
    io:println("Title: ", programme.title);
    io:println("NQF Level: ", programme.nqfLevel);
    io:println("Faculty: ", programme.faculty);
    io:println("Department: ", programme.department);
    io:println("Registration Date: ", programme.registrationDate);
    io:println("Courses: ", programme.courses.toString());
    io:println("--------------------------");
}

function parseDate(string dateString) returns int|error {
    if (dateString.length() != 10 || dateString[4] != "-" || dateString[7] != "-") {
        return error("Invalid date format. Use YYYY-MM-DD.");
    }

    int year = check int:fromString(dateString.substring(0, 4));
    int month = check int:fromString(dateString.substring(5, 7));
    int day = check int:fromString(dateString.substring(8, 10));

    return year * 10000 + month * 100 + day; // Format YYYYMMDD
}

function handleCourseInput(string input) returns string[] {
    string[] courses = [];
    string currentCourse = "";

    // Iterate over each character in the input string
    int length = input.length();
    foreach int i in 0 ..< length {
        string c = input.substring(i, i + 1);
        if (c == ",") {
            if (currentCourse.trim().length() > 0) {
                courses.push(currentCourse.trim());
            }
            currentCourse = ""; // Reset for the next course
        } else {
            currentCourse += c; // Build the current course name
        }
    }

    // Add the last course if there's no trailing comma
    if (currentCourse.trim().length() > 0) {
        courses.push(currentCourse.trim());
    }

    return courses;
}
