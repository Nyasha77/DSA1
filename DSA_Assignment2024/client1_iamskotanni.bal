import ballerina/http;

// Basic HTTP service
service /info on new http:Listener(8081) {
    resource function get about() returns string {
        return "Information from iamskotanni!";
    }
}
