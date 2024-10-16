import ballerina/io;
import ballerina/http;

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
    http:Client programmeClient = check new ("http://localhost:4000/programme");

    io:println("1. Add Programme");
    io:println("2. Update Programme record");
    io:println("3. Delete Programme record by code");
    io:println("4. View All Programme records");
    io:println("5. View Programme record by code");
    io:println("6. View Programme records by faculty");
    io:println("7. View Programme records due for review");
    string options = io:readln("Choose an option: ");

    match options {
        "1" => {
            Programme programme = {
                code: "", nqfLevel: "", faculty: "", department: "", 
                title: "", registrationDate: "", courses: []
            };
            programme.code = io:readln("Enter Programme code: ");
            programme.title = io:readln("Enter Programme title: ");
            programme.nqfLevel = io:readln("Enter NQF Level of Qualification: ");
            programme.faculty = io:readln("Enter Faculty name: ");
            programme.department = io:readln("Enter Department name: ");
            programme.registrationDate = io:readln("Enter Registration date (YYYY-MM-DD): ");
            programme.courses = io:readln("Enter course codes (comma-separated): ").split(",");
            check addProgramme(programmeClient, programme);
        }
        "2" => {
            Programme programme = {
                code: "", nqfLevel: "", faculty: "", department: "", 
                title: "", registrationDate: "", courses: []
            };
            programme.code = io:readln("Enter Programme code to update: ");
            programme.title = io:readln("Enter new Programme title: ");
            programme.nqfLevel = io:readln("Enter new NQF Level of Qualification: ");
            programme.faculty = io:readln("Enter new Faculty name: ");
            programme.department = io:readln("Enter new Department name: ");
            programme.registrationDate = io:readln("Enter new Registration date (YYYY-MM-DD): ");
            programme.courses = io:readln("Enter new course codes (comma-separated): ").split(",");
            check updateProgramme(programmeClient, programme);
        }
        "3" => {
            string code = io:readln("Enter Programme code to delete: ");
            check deleteProgrammeByCode(programmeClient, code);
        }
        "4" => {
            check getAllProgrammes(programmeClient);
        }
        "5" => {
            string code = io:readln("Enter Programme code: ");
            check getProgrammeByCode(programmeClient, code);
        }
        "6" => {
            string faculty = io:readln("Enter Faculty name: ");
            check getProgrammesByFaculty(programmeClient, faculty);
        }
        "7" => {
            check getProgrammesDueForReview(programmeClient);
        }
        _ => {
            io:println("Invalid option.");
            check main();
        }
    }
}

public function addProgramme(http:Client http, Programme programme) returns error? {
    string response = check http->post("/", programme);
    io:println(response);
    string exitSys = io:readln("Press 0 to go back");
    if (exitSys === "0") {
        error? rerun = main();
        if rerun is error {
            io:println("You can't go back to the options page.");
        }
    }
}

public function updateProgramme(http:Client http, Programme programme) returns error? {
    string response = check http->put("/", programme);
    io:println(response);
    string exitSys = io:readln("Press 0 to go back");
    if (exitSys === "0") {
        error? rerun = main();
        if rerun is error {
            io:println("You can't go back to the options page.");
        }
    }
}

public function deleteProgrammeByCode(http:Client http, string code) returns error? {
    string message = check http->delete("/" + code);
    io:println(message);
    string exitSys = io:readln("Press 0 to go back");
    if (exitSys === "0") {
        error? rerun = main();
        if rerun is error {
            io:println("You can't go back.");
        }
    }
}

public function getAllProgrammes(http:Client http) returns error? {
    Programme[] programmes = check http->get("/");
    foreach Programme programme in programmes {
        io:println("--------------------------");
        io:println("Code: ", programme.code);
        io:println("Title: ", programme.title);
        io:println("NQF Level: ", programme.nqfLevel);
        io:println("Faculty: ", programme.faculty);
        io:println("Department: ", programme.department);
        io:println("Registration Date: ", programme.registrationDate);
        io:println("Courses: ", programme.courses.toString());
    }
    io:println("--------------------------");
    string exitSys = io:readln("Press 0 to go back");
    if (exitSys === "0") {
        error? rerun = main();
        if rerun is error {
            io:println("You can't go back.");
        }
    }
}

public function getProgrammeByCode(http:Client http, string code) returns error? {
    Programme programme = check http->get("/" + code);
    io:println("--------------------------");
    io:println("Code: ", programme.code);
    io:println("Title: ", programme.title);
    io:println("NQF Level: ", programme.nqfLevel);
    io:println("Faculty: ", programme.faculty);
    io:println("Department: ", programme.department);
    io:println("Registration Date: ", programme.registrationDate);
    io:println("Courses: ", programme.courses.toString());
    io:println("--------------------------");
    string exitSys = io:readln("Press 0 to go back");
    if (exitSys === "0") {
        error? rerun = main();
        if rerun is error {
            io:println("You can't go back.");
        }
    }
}

public function getProgrammesByFaculty(http:Client http, string faculty) returns error? {
    Programme[] programmes = check http->get("/faculty/" + faculty);
    foreach Programme programme in programmes {
        io:println("--------------------------");
        io:println("Code: ", programme.code);
        io:println("Title: ", programme.title);
        io:println("NQF Level: ", programme.nqfLevel);
        io:println("Faculty: ", programme.faculty);
        io:println("Department: ", programme.department);
        io:println("Registration Date: ", programme.registrationDate);
        io:println("Courses: ", programme.courses.toString());
    }
    io:println("--------------------------");
    string exitSys = io:readln("Press 0 to go back");
    if (exitSys === "0") {
        error? rerun = main();
        if rerun is error {
            io:println("You can't go back.");
        }
    }
}

public function getProgrammesDueForReview(http:Client http) returns error? {
    Programme[] programmes = check http->get("/review");
    foreach Programme programme in programmes {
        io:println("--------------------------");
        io:println("Code: ", programme.code);
        io:println("Title: ", programme.title);
        io:println("NQF Level: ", programme.nqfLevel);
        io:println("Faculty: ", programme.faculty);
        io:println("Department: ", programme.department);
        io:println("Registration Date: ", programme.registrationDate);
        io:println("Courses: ", programme.courses.toString());
    }
    io:println("--------------------------");
    string exitSys = io:readln("Press 0 to go back");
    if (exitSys === "0") {
        error? rerun = main();
        if rerun is error {
            io:println("You can't go back.");
        }
    }
}
