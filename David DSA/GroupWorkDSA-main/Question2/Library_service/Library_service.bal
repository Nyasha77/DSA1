import ballerina/grpc;
import ballerina/protobuf;
import ballerina/protobuf.types.empty;

public const string LIBRARY_DESC = "0A0D4C6962726172792E70726F746F";

 type AddBook record {
     
  
};

type ContextAddBook record {|

    ISBN content;
    map<string|string[]> headers; 
|};


@protobuf:Descriptor {value: LIBRARY_DESC}
type ISBN record {|
   string ISBN = "";
    string title ="";
    string author_1 ="";
    string author_2 = "";
    
|};


type CreateUser record {
    
};

type ContextCreateUser record {|
 responce content;
    map<string|string[]> headers;
    
|};


@protobuf:Descriptor {value: LIBRARY_DESC}
type responce record {|
int id = 0;
  string name ="" ;
|};


type UpdateBook record {
    
};

type ContextUpdateBook record {|
 bookUpdate content;
    map<string|string[]> headers;
    
|};


@protobuf:Descriptor {value: LIBRARY_DESC}
type bookUpdate record {|
string content = "";
    
|};

type RemoveBook record {
    
};

type ContextRemoveBook record {|

 RemoveBook content;
    map<string|string[]> headers;
    
|};


type Book record {
    
};

@protobuf:Descriptor {value: LIBRARY_DESC}
type newList record {|

 Book[] newList=[];
    
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
type BookList record {|
Book[] BookList=[];
    
|};

type LocateBook record {
    
};

type ContextLocateBook record {|
 location content;
    map<string|string[]> headers;
    
|};


@protobuf:Descriptor {value: LIBRARY_DESC}
type location record {|
string location = "";

    
|};

type BorrowBook record {
    
};

type ContextBorrowBook record {|
 BorrowBook content;
    map<string|string[]> headers;
    
|};





public isolated client class LibraryManagementClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, LIBRARY_DESC);
    }

  isolated remote function addBook(AddBook|ContextAddBook req) returns ISBN|grpc:Error {
        map<string|string[]> headers = {};
        AddBook message;
        if req is ContextAddBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManagement.ISBN/addBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ISBN>result;
    }

      isolated remote function createUser(CreateUser|ContextCreateUser req) returns responce|grpc:Error {
        map<string|string[]> headers = {};
        CreateUser message;
        if req is ContextCreateUser {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManagement.response/createUser", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <responce>result;
    }


  isolated remote function updateBook(UpdateBook|ContextUpdateBook req) returns bookUpdate|grpc:Error {
        map<string|string[]> headers = {};
        UpdateBook message;
        if req is ContextUpdateBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManagement.bookUpdate/updateBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <bookUpdate>result;
    }

  isolated remote function removeBook(RemoveBook|ContextRemoveBook req) returns newList|grpc:Error {
        map<string|string[]> headers = {};
        RemoveBook message;
        if req is ContextRemoveBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManagement.newList/removeBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <newList>result;
    }

    isolated remote function listingAvailableBooks() returns BookList|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManagement.BookList/listAvailableBooks", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <BookList>result;
    }

 isolated remote function locateBook(LocateBook|ContextLocateBook req) returns location|grpc:Error {
        map<string|string[]> headers = {};
        LocateBook message;
        if req is ContextLocateBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManagement.location/locateBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <location>result;
    }
 isolated remote function borrowBook(BorrowBook|ContextBorrowBook req) returns ISBN|grpc:Error {
        map<string|string[]> headers = {};
        BorrowBook message;
        if req is ContextBorrowBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManagement.ISBN/borrowBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ISBN>result;
    }



}