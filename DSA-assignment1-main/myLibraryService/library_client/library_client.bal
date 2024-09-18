import ballerina/grpc;
import ballerina/io;

public function main() returns error? {
    // Create a new gRPC client.
    LibraryClient libraryClient = check new("http://localhost:9090");

    // 1. Create users
    io:println("Enter user details to create a user:");
    string id = io:readln("Enter ID: ");
    string name = io:readln("Enter name: ");

    User user = {
        id: id,
        name: name
    };

    stream<User, grpc:Error?> userStream = [user].toStream();

    var createUsersRes = libraryClient->CreateUsers();

    if (createUsersRes is grpc:Error) {
        io:println(createUsersRes.message());
        return;
    }

    io:println("Successfully created user with ID ", user.id);

    // 2. Add book
    io:println("Enter book details to add a book:");
    string title = io:readln("Enter title: ");
    string author_1 = io:readln("Enter author 1: ");
    string author_2 = io:readln("Enter author 2: ");
    string location = io:readln("Enter location: ");
    string isbn = io:readln("Enter ISBN: ");

    AddBookRequest addBookReq = {
        book: {
            title: title,
            author_1: author_1,
            author_2: author_2,
            location: location,
            isbn: isbn,
            status: true
        }
    };

    var addBookRes = libraryClient->AddBook(addBookReq);

    if (addBookRes is grpc:Error) {
        io:println(addBookRes.message());
        return;
      }

      io:println("Successfully added book with ISBN ", addBookReq.book.isbn);

      // 3. Update book
      string updateIsbn = io:readln("Enter ISBN to update a book:");
      string newTitle = io:readln("Enter new title: ");
      string newAuthor_1 = io:readln("Enter new author 1: ");
      string newAuthor_2 = io:readln("Enter new author 2: ");
      string newLocation = io:readln("Enter new location: ");

      UpdateBookRequest updateBookReq = {
          isbn:updateIsbn,
          book:{
              title:newTitle,
              author_1:newAuthor_1,
              author_2:newAuthor_2,
              location:newLocation,
              isbn:updateIsbn,
              status:true
          }
      };

      var updateBookRes = libraryClient->UpdateBook(updateBookReq);

      if (updateBookRes is grpc:Error) {
          io:println(updateBookRes.message());
          return;
      }

      io:println("Successfully updated book with ISBN ", updateBookReq.isbn);
      
     // 4. List available books
     var listAvailableBooksRes = libraryClient->ListAvailableBooks({});

     if (listAvailableBooksRes is grpc:Error) {
         io:println(listAvailableBooksRes.message());
         return;
     } else {
         error? e = listAvailableBooksRes.forEach(function(Book book) {
             io:println("Title: ", book.title, ", ISBN: ", book.isbn);
         });
         if (e is error) {
             io:println(e.message());
             return;
         }
     }

     io:println("Successfully listed available books");

     // 5. Locate book
     string locateIsbn = io:readln("Enter ISBN to locate a book:");

     LocateBookRequest locateBookReq = {
         isbn:locateIsbn
     };

     var locateBookRes = libraryClient->LocateBook(locateBookReq);

     if (locateBookRes is grpc:Error) {
         io:println("Error when calling LocateBook:", locateBookRes.message());
         return;
     }

     io:println("Successfully located book with ISBN", locateBookReq.isbn);

      // 6. Borrow book
      string borrowUserId = io:readln("Enter user ID:");
      string borrowIsbn = io:readln("Enter ISBN to borrow a book:");

      BorrowBookRequest borrowBookReq = {
          userId:borrowUserId,
          isbn:borrowIsbn
      };

      var borrowBookRes = libraryClient->BorrowBook(borrowBookReq);

      if (borrowBookRes is grpc:Error) {
          io:println("Error when calling Borrow Book:", borrowBookRes.message());
          return;
      }

      io:println("Successfully borrowed book with ISBN", borrowBookReq.isbn);

      // 7. Remove book
      string removeIsbn = io:readln("Enter ISBN to remove a book:");

      RemoveBookRequest removeBookReq = {
          isbn:removeIsbn
      };

      var removeBookRes = libraryClient->RemoveBook(removeBookReq);

      if (removeBookRes is grpc:Error) {
          io:println("Error when calling Remove Book:", removeBookRes.message());
          return;
      }

      io:println("Successfully removed book with ISBN", removeBookReq.isbn);
}
