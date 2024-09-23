import ballerina/grpc;
import ballerina/protobuf;
import ballerina/protobuf.types.empty;
import ballerina/protobuf.types.wrappers;

public const string SHOPPING_DESC = "0A0E73686F7070696E672E70726F746F120E73686F7070696E6773797374656D1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F1A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F22A6010A0750726F6475637412120A046E616D6518012001280952046E616D6512200A0B6465736372697074696F6E180220012809520B6465736372697074696F6E12140A0570726963651803200128015205707269636512250A0E73746F636B5F7175616E74697479180420012805520D73746F636B5175616E7469747912100A03736B751805200128095203736B7512160A067374617475731806200128085206737461747573223F0A0A41646450726F6475637412310A0770726F6475637418012001280B32172E73686F7070696E6773797374656D2E50726F64756374520770726F6475637422420A0A4372656174655573657212170A07757365725F69641801200128095206757365724964121B0A09757365725F747970651802200128095208757365725479706522420A0D55706461746550726F6475637412310A0770726F6475637418012001280B32172E73686F7070696E6773797374656D2E50726F64756374520770726F6475637422210A0D52656D6F766550726F6475637412100A03736B751801200128095203736B75224A0A154C697374417661696C61626C6550726F647563747312310A0770726F6475637418012001280B32172E73686F7070696E6773797374656D2E50726F64756374520770726F6475637422210A0D53656172636850726F6475637412100A03736B751801200128095203736B75224A0A1553656172636850726F64756374526573706F6E736512310A0770726F6475637418012001280B32172E73686F7070696E6773797374656D2E50726F64756374520770726F6475637422360A09416464546F4361727412170A07757365725F6964180120012809520675736572496412100A03736B751802200128095203736B7522250A0A506C6163654F7264657212170A07757365725F69641801200128095206757365724964328E050A0E53686F7070696E6753797374656D12480A0A61646450726F64756374121A2E73686F7070696E6773797374656D2E41646450726F647563741A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C75652200124B0A0B6372656174655573657273121A2E73686F7070696E6773797374656D2E437265617465557365721A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756522002801124E0A0D75706461746550726F64756374121D2E73686F7070696E6773797374656D2E55706461746550726F647563741A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C75652200124E0A0D72656D6F766550726F64756374121D2E73686F7070696E6773797374656D2E52656D6F766550726F647563741A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C75652200125A0A156C697374417661696C61626C6550726F647563747312162E676F6F676C652E70726F746F6275662E456D7074791A252E73686F7070696E6773797374656D2E4C697374417661696C61626C6550726F64756374732200300112570A0D73656172636850726F64756374121D2E73686F7070696E6773797374656D2E53656172636850726F647563741A252E73686F7070696E6773797374656D2E53656172636850726F64756374526573706F6E7365220012460A09616464546F4361727412192E73686F7070696E6773797374656D2E416464546F436172741A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565220012480A0A706C6163654F72646572121A2E73686F7070696E6773797374656D2E506C6163654F726465721A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C75652200620670726F746F33";

public isolated client class ShoppingSystemClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, SHOPPING_DESC);
    }

    isolated remote function addProduct(AddProduct|ContextAddProduct req) returns string|grpc:Error {
        map<string|string[]> headers = {};
        AddProduct message;
        if req is ContextAddProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shoppingsystem.ShoppingSystem/addProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return result.toString();
    }

    isolated remote function addProductContext(AddProduct|ContextAddProduct req) returns wrappers:ContextString|grpc:Error {
        map<string|string[]> headers = {};
        AddProduct message;
        if req is ContextAddProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shoppingsystem.ShoppingSystem/addProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function updateProduct(UpdateProduct|ContextUpdateProduct req) returns string|grpc:Error {
        map<string|string[]> headers = {};
        UpdateProduct message;
        if req is ContextUpdateProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shoppingsystem.ShoppingSystem/updateProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return result.toString();
    }

    isolated remote function updateProductContext(UpdateProduct|ContextUpdateProduct req) returns wrappers:ContextString|grpc:Error {
        map<string|string[]> headers = {};
        UpdateProduct message;
        if req is ContextUpdateProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shoppingsystem.ShoppingSystem/updateProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function removeProduct(RemoveProduct|ContextRemoveProduct req) returns string|grpc:Error {
        map<string|string[]> headers = {};
        RemoveProduct message;
        if req is ContextRemoveProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shoppingsystem.ShoppingSystem/removeProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return result.toString();
    }

    isolated remote function removeProductContext(RemoveProduct|ContextRemoveProduct req) returns wrappers:ContextString|grpc:Error {
        map<string|string[]> headers = {};
        RemoveProduct message;
        if req is ContextRemoveProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shoppingsystem.ShoppingSystem/removeProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function searchProduct(SearchProduct|ContextSearchProduct req) returns SearchProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        SearchProduct message;
        if req is ContextSearchProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shoppingsystem.ShoppingSystem/searchProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <SearchProductResponse>result;
    }

    isolated remote function searchProductContext(SearchProduct|ContextSearchProduct req) returns ContextSearchProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        SearchProduct message;
        if req is ContextSearchProduct {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shoppingsystem.ShoppingSystem/searchProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <SearchProductResponse>result, headers: respHeaders};
    }

    isolated remote function addToCart(AddToCart|ContextAddToCart req) returns string|grpc:Error {
        map<string|string[]> headers = {};
        AddToCart message;
        if req is ContextAddToCart {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shoppingsystem.ShoppingSystem/addToCart", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return result.toString();
    }

    isolated remote function addToCartContext(AddToCart|ContextAddToCart req) returns wrappers:ContextString|grpc:Error {
        map<string|string[]> headers = {};
        AddToCart message;
        if req is ContextAddToCart {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shoppingsystem.ShoppingSystem/addToCart", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function placeOrder(PlaceOrder|ContextPlaceOrder req) returns string|grpc:Error {
        map<string|string[]> headers = {};
        PlaceOrder message;
        if req is ContextPlaceOrder {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shoppingsystem.ShoppingSystem/placeOrder", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return result.toString();
    }

    isolated remote function placeOrderContext(PlaceOrder|ContextPlaceOrder req) returns wrappers:ContextString|grpc:Error {
        map<string|string[]> headers = {};
        PlaceOrder message;
        if req is ContextPlaceOrder {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shoppingsystem.ShoppingSystem/placeOrder", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function createUsers() returns CreateUsersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("shoppingsystem.ShoppingSystem/createUsers");
        return new CreateUsersStreamingClient(sClient);
    }

    isolated remote function listAvailableProducts() returns stream<ListAvailableProducts, grpc:Error?>|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("shoppingsystem.ShoppingSystem/listAvailableProducts", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        ListAvailableProductsStream outputStream = new ListAvailableProductsStream(result);
        return new stream<ListAvailableProducts, grpc:Error?>(outputStream);
    }

    isolated remote function listAvailableProductsContext() returns ContextListAvailableProductsStream|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("shoppingsystem.ShoppingSystem/listAvailableProducts", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        ListAvailableProductsStream outputStream = new ListAvailableProductsStream(result);
        return {content: new stream<ListAvailableProducts, grpc:Error?>(outputStream), headers: respHeaders};
    }
}

public client class CreateUsersStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendCreateUser(CreateUser message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextCreateUser(ContextCreateUser message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveString() returns string|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return payload.toString();
        }
    }

    isolated remote function receiveContextString() returns wrappers:ContextString|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: payload.toString(), headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public class ListAvailableProductsStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|ListAvailableProducts value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if (streamValue is ()) {
            return streamValue;
        } else if (streamValue is grpc:Error) {
            return streamValue;
        } else {
            record {|ListAvailableProducts value;|} nextRecord = {value: <ListAvailableProducts>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

public type ContextListAvailableProductsStream record {|
    stream<ListAvailableProducts, error?> content;
    map<string|string[]> headers;
|};

public type ContextCreateUserStream record {|
    stream<CreateUser, error?> content;
    map<string|string[]> headers;
|};

public type ContextSearchProduct record {|
    SearchProduct content;
    map<string|string[]> headers;
|};

public type ContextPlaceOrder record {|
    PlaceOrder content;
    map<string|string[]> headers;
|};

public type ContextAddProduct record {|
    AddProduct content;
    map<string|string[]> headers;
|};

public type ContextUpdateProduct record {|
    UpdateProduct content;
    map<string|string[]> headers;
|};

public type ContextListAvailableProducts record {|
    ListAvailableProducts content;
    map<string|string[]> headers;
|};

public type ContextAddToCart record {|
    AddToCart content;
    map<string|string[]> headers;
|};

public type ContextRemoveProduct record {|
    RemoveProduct content;
    map<string|string[]> headers;
|};

public type ContextCreateUser record {|
    CreateUser content;
    map<string|string[]> headers;
|};

public type ContextSearchProductResponse record {|
    SearchProductResponse content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type SearchProduct record {|
    string sku = "";
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type PlaceOrder record {|
    string user_id = "";
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type AddProduct record {|
    Product product = {};
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type UpdateProduct record {|
    Product product = {};
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type ListAvailableProducts record {|
    Product product = {};
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type AddToCart record {|
    string user_id = "";
    string sku = "";
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type RemoveProduct record {|
    string sku = "";
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type Product record {|
    string name = "";
    string description = "";
    float price = 0.0;
    int stock_quantity = 0;
    string sku = "";
    boolean status = false;
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type CreateUser record {|
    string user_id = "";
    string user_type = "";
|};

@protobuf:Descriptor {value: SHOPPING_DESC}
public type SearchProductResponse record {|
    Product product = {};
|};

