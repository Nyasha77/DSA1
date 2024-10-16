import ballerina/http;

// Another basic HTTP service
service /test on new http:Listener(8083) {
    resource function get hello() returns string {
        return "Hello from Natangue123rza!";
    }
}
