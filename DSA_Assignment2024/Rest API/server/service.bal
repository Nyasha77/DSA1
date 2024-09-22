import ballerina/http;
import ballerina/io;

type Programme readonly & record {
    string code;
    string nqfLevel;
    string faculty;
    string department;
    string title;
    int registrationDate;
    string[] courses;
};

int currentDate = 2024;

table<Programme> key(code) programmeDevelopmentUnit = table [
{code: "sum", nqfLevel: "3", faculty: "Computing and Informatics", department: "Computer Science", title: "", registrationDate: 2023, courses: ["Computer Science", "Cyber Security"]}
];

service / on new http:Listener(9090) {

    resource function post addProgramme(Programme programmeDevelopment) returns Programme {
        programmeDevelopmentUnit.add(programmeDevelopment);
        return programmeDevelopment;
    };

    resource function put updateProgramme(Programme programmeDevelopment) returns string {
        io:println(programmeDevelopment);
        error? err = programmeDevelopmentUnit.put(programmeDevelopment);
        if (err is error) {
            return string `Error, ${err.message()}`;
        }
        return string `${programmeDevelopment.code} saved successfully`;
    };

    resource function get getAllProgrammes() returns Programme[] {
        return programmeDevelopmentUnit.toArray();
    }

    resource function get getProgrammeByCode/[string code]() returns Programme|string {
        foreach Programme programmeDevelopment in programmeDevelopmentUnit {
            if (programmeDevelopment.code === code) {
                return programmeDevelopment;
            }
        }
        return "Invalid Code";
    }

    resource function get getProgrammesByFaculty/[string faculty]() returns Programme[]|string {
        Programme[] facultyProgrammes = [];
        foreach Programme programmeDevelopment in programmeDevelopmentUnit {
            if (programmeDevelopment.faculty == faculty) {
                facultyProgrammes.push(programmeDevelopment);
            }
        }
        if facultyProgrammes.length() > 0 {
            return facultyProgrammes;
        } else {
            return [];
        }
    }

    resource function get getProgrammesDueForReview() returns Programme[]|string {
        Programme[] dueProgrammes = [];
        foreach Programme programmeDevelopment in programmeDevelopmentUnit {
            if ((currentDate - programmeDevelopment.registrationDate) >= 1) {
                dueProgrammes.push(programmeDevelopment);
            }
        }
        if dueProgrammes.length() > 0 {
            return dueProgrammes;
        } else {
            return "No programmes are due for review.";
        }
    }

    resource function delete deleteProgrammeByCode/[string code]() returns string|Programme[] {
        _ = programmeDevelopmentUnit.remove(code);
        return programmeDevelopmentUnit.toString();
    }
};
