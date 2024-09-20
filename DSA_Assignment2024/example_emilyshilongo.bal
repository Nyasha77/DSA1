import ballerina/http;

// Create a simple HTTP service
service /hello on new http:Listener(8080) {
    resource function get sayHello() returns string {
        return "Hello, Ballerina!";
    }
}
