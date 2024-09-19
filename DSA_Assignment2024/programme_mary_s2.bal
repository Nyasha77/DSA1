import ballerina/http;

// Sample HTTP service
service /sample on new http:Listener(8082) {
    resource function get sample() returns string {
        return "Sample response from Mary-S2!";
    }
}
