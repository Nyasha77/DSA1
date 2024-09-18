import ballerina/io;
import ballerina/grpc;
import com.example.grpc.library;

function main() {
    // Initialize the gRPC client
    grpc:Client libraryClient = new("http://localhost:9090", library.Client);

    // Create gRPC requests and handle responses
    // Example:
    library:Empty listAvailableBooksRequest = {};
    
    var listAvailableBooksResponse = libraryClient->ListAvailableBooks(listAvailableBooksRequest);

    if (listAvailableBooksResponse is library:Book[]) {
        foreach var book in listAvailableBooksResponse {
            io:println("ISBN: " + book.isbn);
            io:println("Title: " + book.title);
            io:println("Author 1: " + book.author_1);
            io:println("Author 2: " + book.author_2);
            io:println("Location: " + book.location);
            io:println("Available: " + book.available);
            io:println("");
        }
    } else {
        io:println("Error: Failed to retrieve available books");
    }
    
    // Implement other gRPC client operations similarly
}
