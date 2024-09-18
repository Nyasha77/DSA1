import ballerina/grpc;

// Define a map to store our books and users in memory.
map<Book> books = {};
map<User> users = {};

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: LIBRARY_DESC}
service "Library" on ep {

    remote function AddBook(AddBookRequest value) returns AddBookResponse|error {
        // Check if the book already exists.
        if (books.hasKey(value.book.isbn)) {
            return error("The book already exists.");
        }

        // Add the book to our map.
        books[value.book.isbn] = value.book;

        // Create a new AddBookResponse message.
        AddBookResponse response = {
            isbn: value.book.isbn
        };

        // Return the response.
        return response;
    }

    remote function CreateUsers(stream<User, grpc:Error?> clientStream) returns CreateUsersResponse|error {
    // Iterate over the client stream and add each user to our map.
    error? e = clientStream.forEach(function(User user) {
        // Check if the user already exists.
        if (users.hasKey(user.id)) {
            error err = error("The user already exists.");
            panic err;
        }

        users[user.id] = user;
    });

    // Handle any errors that occurred while reading from the stream.
    if (e is error) {
        return e;
    }

    // Create a new CreateUsersResponse message.
    string[] userIds = [];
    foreach var userId in users.keys() {
        userIds.push(userId);
    }
    CreateUsersResponse response = {
        userIds: userIds
    };

    // Return the response.
    return response;
}

    remote function UpdateBook(UpdateBookRequest value) returns UpdateBookResponse|error {
        // Check if the book exists.
        if (!books.hasKey(value.isbn)) {
            return error("The book does not exist.");
        }

        // Update the book in our map.
        books[value.isbn] = value.book;

        // Create a new UpdateBookResponse message.
        UpdateBookResponse response = {
            success: true
        };

        // Return the response.
        return response;
    }

    remote function RemoveBook(RemoveBookRequest value) returns RemoveBookResponse|error {
         // Check if the book exists.
         if (!books.hasKey(value.isbn)) {
             return error("The book does not exist.");
         }

         // Remove the book from our map.
         _ = books.remove(value.isbn);

         // Create a new RemoveBookResponse message with the updated list of books.
         Book[] bookArray = [];
        
         foreach var bookEntry in books.entries() {
             bookArray.push(bookEntry[1]);
         }
        
         RemoveBookResponse response = {
             books: bookArray
         };

         // Return the response.
         return response;
     }

     remote function ListAvailableBooks(ListAvailableBooksRequest value) returns stream<Book, error?>|error {
          // Convert our map of books to a stream.
          Book[] bookArray = [];
          foreach var bookEntry in books.entries() {
              if (bookEntry[1].status) {  // only add the book to the list if it's available
                  bookArray.push(bookEntry[1]);
              }
          }
          stream<Book, error?> bookStream = bookArray.toStream();

          // Return the stream of books.
          return bookStream;
      }

     remote function LocateBook(LocateBookRequest value) returns LocateBookResponse|error {
          // Find the book in our map.
          Book? bookOptional = books[value.isbn];

          // If the book is not found or is not available, return an error.
          if (bookOptional is ()) || (!bookOptional.status) {
              return error("The book is not available.");
          }

          Book book = <Book>bookOptional;

          // Create a new LocateBookResponse message with the location of the book.
          LocateBookResponse response = {
              location: book.location
          };

          // Return the response.
          return response;
      }

     remote function BorrowBook(BorrowBookRequest value) returns BorrowBookResponse|error {
    // Find the user in our map.
    User? userOptional = users[value.userId];

    // If the user is not found, return an error.
    if (userOptional is ()) {
        return error("The user does not exist.");
    }

    // Find the book in our map.
    Book? bookOptional = books[value.isbn];

    // If the book is not found or is not available, return an error.
    if (bookOptional is ()) || (!bookOptional.status) {
        return error("The book is not available.");
    }

    Book book = <Book>bookOptional;

    // Create a new Book record with the updated status.
    Book updatedBook = {
        title: book.title,
        author_1: book.author_1,
        author_2: book.author_2,
        location: book.location,
        isbn: book.isbn,
        status: false
    };

    // Update the book in our map.
    books[value.isbn] = updatedBook;

    // Create a new BorrowBookResponse message indicating success.
    BorrowBookResponse response = {
        success: true
    };

    // Return the response.
    return response;
}
}
