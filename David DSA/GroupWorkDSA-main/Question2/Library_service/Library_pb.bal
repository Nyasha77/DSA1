import ballerina/grpc;


listener grpc:Listener ep = new (9090);
@grpc:Descriptor {value: LIBRARY_DESC}
service "LibraryManagementService" on ep {

    remote function addBook(AddBook value) returns ISBN|error {
    }
    remote function createUser(CreateUser value) returns responce|error {
    }
    remote function updateBook(UpdateBook value) returns bookUpdate|error {
    }
    remote function removeBook(RemoveBook value) returns newList|error {
    }

     remote function listingAvailableBook() returns BookList|error {
    }
    remote function locateBook(LocateBook value) returns location|error {
    }
    remote function borrowBook(BorrowBook value) returns ISBN|error {
    }



}