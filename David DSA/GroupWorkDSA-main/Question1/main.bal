import ballerina/http;

type TeacherRecord record {
    readonly string employeeId;
    string employeeName;
    string gender;
    string officeNumber;
    string title;
    string course;
};

table<TeacherRecord> key(employeeId) teachersTable = table[];

service / on new http:Listener(9090) {
    resource function post addTeacher(TeacherRecord newTeacher) returns string | error {
        error? addTeacherResult = teachersTable.add(newTeacher);
        if addTeacherResult is error {
            return error("Failed to add new teacher.");
        }
        return newTeacher.employeeName + " created successfully.";
    }

    resource function get getAllTeachers() returns TeacherRecord[] | error {
        TeacherRecord[] teacherList = [];
        foreach var teacher in teachersTable {
            teacherList.push(teacher);
        }
        return teacherList;
    }

    resource function put updateTeacher(string employeeId, TeacherRecord updatedTeacher) returns string | error {
        TeacherRecord? existingTeacher = teachersTable[employeeId];
        if (existingTeacher == null) {
            return error("Teacher with employee ID " + employeeId + " not found.");
        }

        existingTeacher.employeeName = updatedTeacher.employeeName;
        existingTeacher.gender = updatedTeacher.gender;
        existingTeacher.officeNumber = updatedTeacher.officeNumber;
        existingTeacher.title = updatedTeacher.title;

        return "Teacher with employee ID " + employeeId + " updated successfully.";
    }

    resource function get getTeacherByEmployeeId(string employeeId) returns TeacherRecord | error {
        TeacherRecord? teacher = teachersTable[employeeId];
        if (teacher == null) {
            return error("Teacher with employee ID " + employeeId + " not found.");
        }
        return teacher;
    }

    resource function delete deleteTeacherByEmployeeId(string employeeId) returns string | error {
        TeacherRecord? existingTeacher = teachersTable[employeeId];
        if (existingTeacher == null) {
            return error("Teacher with employee ID " + employeeId + " not found.");
        }

        _ = teachersTable.remove(existingTeacher.employeeId);

        return "Teacher with employee ID " + employeeId + " deleted successfully.";
    }

    resource function get getTeachersInSameOffice(string officeNumber) returns TeacherRecord[] | error {
        TeacherRecord[] teachersInSameOffice = [];
        foreach var teacher in teachersTable {
            if (teacher.officeNumber == officeNumber) {
                teachersInSameOffice.push(teacher);
            }
        }
        return teachersInSameOffice;
    }

    resource function get getTeachersTeachingCourse(string courseName) returns TeacherRecord[] | error {
        TeacherRecord[] teachersTeachingCourse = [];
        foreach var teacher in teachersTable {
            if (teacher.course == courseName) {
                teachersTeachingCourse.push(teacher);
            }
        }
        return teachersTeachingCourse;
    }
}
