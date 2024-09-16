import ballerina/http;

// Add the 'readonly' keyword to the staffNumber field


// Use a map instead of a table for simplicity
map<Lecturer> lecturers = {};

service /api on new http:Listener(8080) {

    resource function post lecturers(@http:Payload Lecturer lecturer) returns http:Created|error {
        lecturers[lecturer.staffNumber] = lecturer;
        return http:CREATED;
    }

    resource function get lecturers() returns Lecturer[]|error {
        return lecturers.toArray();
    }

    resource function get lecturers/[string staffNumber]() returns Lecturer|http:NotFound {
        if (lecturers.hasKey(staffNumber)) {
            return lecturers.get(staffNumber);
        }
        return http:NOT_FOUND;
    }

    resource function put lecturers/[string staffNumber](@http:Payload Lecturer updatedLecturer) returns Lecturer|http:NotFound {
        if (lecturers.hasKey(staffNumber)) {
            lecturers[staffNumber] = updatedLecturer;
            return updatedLecturer;
        }
        return http:NOT_FOUND;
    }

    resource function delete lecturers/[string staffNumber]() returns http:NoContent|http:NotFound {
        if (lecturers.hasKey(staffNumber)) {
            _ = lecturers.remove(staffNumber);
            return http:NO_CONTENT;
        }
        return http:NOT_FOUND;
    }

    resource function get lecturers/course/[string courseCode]() returns Lecturer[]|error {
        return lecturers.toArray().filter(lecturer => lecturer.courses.some(course => course.courseCode == courseCode));
    }

    resource function get lecturers/office/[string officeNumber]() returns Lecturer[]|error {
        return lecturers.toArray().filter(lecturer => lecturer.officeNumber == officeNumber);
    }
}