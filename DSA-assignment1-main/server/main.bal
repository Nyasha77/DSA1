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

public final table<Lecturers> key(staffNumber) lecturerTable = table [
    {staffNumber: 1, officeNumber: 2, firstName: "henry", lastName: "johnson", title: "Junior lecturer of CS", listOfCourses: ["math", "english", "cs"], faculty: "computing"}
];

service / on new http:Listener(9000){

    // 1. Add lecturer
    resource function post addLecturer(Lecturers lecturer) returns string{
        error? createLecturer = lecturerTable.add(lecturer);

        if(createLecturer is error){
            return string `error`;
        } else {
            return lecturer.staffNumber.toString() + "saved";
        }
    }

    // 2. Get all lecturers in same faculty
    resource function get searchLecturerInFaculty(string faculty) returns table<Lecturers>{
        table<Lecturers> sameFaculty = table key(staffNumber) from var e in lecturerTable
                    where e.faculty == faculty
                    select e;  
        return sameFaculty;                                          
    }

    // 3. update existing lecturer info
    resource function put updateLecturer(Lecturers updatedLecturer) returns Lecturers{
        error? lecturer = lecturerTable.put(updatedLecturer);

        if(lecturer is error){
            io:println("Error " + lecturer.message());
        } else {
            io:println("Lecturer with staff number: " +  updatedLecturer.staffNumber.toString() + "hasaved");
            return updatedLecturer;
        }
        return updatedLecturer;
    }


    // 4. Search for lecturer with staffNumber
        resource function get searchLecturerByNumber(int staffNumber) returns table<Lecturers> {
        table<Lecturers> lecturerNumber = table key(staffNumber) from var e in lecturerTable
                    where e.staffNumber == staffNumber
                    select e;  
        return lecturerNumber;                                          
    }

    // 5. Delete lecturer by staff number

        resource function delete lecturerByNumber/[int staffNumber]() returns string{
        Lecturers|error deleteLecturer = lecturerTable.remove(staffNumber);

        if(deleteLecturer is error){
            return string `error`;
        } else {
            return deleteLecturer.staffNumber.toString() + "saved";
        }
        }


    // 6. Get all lecturers by course 
        resource function get searchLecturerByCourse(string courseName ) returns table<Lecturers>{
        table<Lecturers> lecturerCourses = table key(staffNumber) from var lecturer in lecturerTable
                    from var course in lecturer.listOfCourses
                    where course == courseName
                    select lecturer;  
        return lecturerCourses;                                          
    }

    // 7. Get all lecturers in same office

        resource function get searchLecturerByOffice(int officeNumber) returns table<Lecturers> {
        table<Lecturers> lecturerInOffice = table key(staffNumber) from var e in lecturerTable
                    where e.officeNumber == officeNumber
                    select e;  
        return lecturerInOffice;                                        
    }

    // 8. Get all lecturers
        resource function get allLecturers() returns Lecturers[]{
            return lecturerTable.toArray();
        }

}

public function main() {
    io:println("Hello, World!");
    io:println("This is the starting data: " + lecturerTable.toString());

}