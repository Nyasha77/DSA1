import ballerina/io;

ShoppingSystemClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    while true {
        printMenu();
        string choice = io:readln("Enter your choice: ");

        match choice {
            "1" => {
                check addProduct();
            }
            "2" => {
                check updateProduct();
            }
            "3" => {
                check removeProduct();
            }
            "4" => {
                check searchProduct();
            }
            "5" => {
                check addToCart();
            }
            "6" => {
                check placeOrder();
            }
            "7" => {
                check listAvailableProducts();
            }
            "8" => {
                check createUsers();
            }
            "9" => {
                io:println("Exiting...");
                return;
            }
            _ => {
                io:println("Invalid choice. Please try again.");
            }
        }
    }
}

function printMenu() {
    io:println("\n--- Shopping System Menu ---");
    io:println("1. Add Product");
    io:println("2. Update Product");
    io:println("3. Remove Product");
    io:println("4. Search Product");
    io:println("5. Add to Cart");
    io:println("6. Place Order");
    io:println("7. List Available Products");
    io:println("8. Create Users");
    io:println("9. Exit");
}

function addProduct() returns error? {
    string name = io:readln("Enter product name: ");
    string description = io:readln("Enter product description: ");
    float price = check float:fromString(io:readln("Enter product price: "));
    int stockQuantity = check int:fromString(io:readln("Enter stock quantity: "));
    string sku = io:readln("Enter product SKU: ");
    boolean status = check boolean:fromString(io:readln("Enter product status (true/false): "));

    AddProduct addProductRequest = {
        product: {
            name: name,
            description: description,
            price: price,
            stock_quantity: stockQuantity,
            sku: sku,
            status: status
        }
    };
    string addProductResponse = check ep->addProduct(addProductRequest);
    io:println(addProductResponse);
}

function updateProduct() returns error? {
    string sku = io:readln("Enter product SKU to update: ");
    string name = io:readln("Enter new product name: ");
    string description = io:readln("Enter new product description: ");
    float price = check float:fromString(io:readln("Enter new product price: "));
    int stockQuantity = check int:fromString(io:readln("Enter new stock quantity: "));
    boolean status = check boolean:fromString(io:readln("Enter new product status (true/false): "));

    UpdateProduct updateProductRequest = {
        product: {
            name: name,
            description: description,
            price: price,
            stock_quantity: stockQuantity,
            sku: sku,
            status: status
        }
    };
    string updateProductResponse = check ep->updateProduct(updateProductRequest);
    io:println(updateProductResponse);
}

function removeProduct() returns error? {
    string sku = io:readln("Enter product SKU to remove: ");
    RemoveProduct removeProductRequest = {sku: sku};
    string removeProductResponse = check ep->removeProduct(removeProductRequest);
    io:println(removeProductResponse);
}

function searchProduct() returns error? {
    string sku = io:readln("Enter product SKU to search: ");
    SearchProduct searchProductRequest = {sku: sku};
    SearchProductResponse searchProductResponse = check ep->searchProduct(searchProductRequest);
    io:println(searchProductResponse);
}

function addToCart() returns error? {
    string userId = io:readln("Enter user ID: ");
    string sku = io:readln("Enter product SKU to add to cart: ");
    AddToCart addToCartRequest = {user_id: userId, sku: sku};
    string addToCartResponse = check ep->addToCart(addToCartRequest);
    io:println(addToCartResponse);
}

function placeOrder() returns error? {
    string userId = io:readln("Enter user ID to place order: ");
    PlaceOrder placeOrderRequest = {user_id: userId};
    string placeOrderResponse = check ep->placeOrder(placeOrderRequest);
    io:println(placeOrderResponse);
}

function listAvailableProducts() returns error? {
    stream<ListAvailableProducts, error?> listAvailableProductsResponse = check ep->listAvailableProducts();
    check listAvailableProductsResponse.forEach(function(ListAvailableProducts value) {
        io:println(value);
    });
}

function createUsers() returns error? {
    CreateUsersStreamingClient createUsersStreamingClient = check ep->createUsers();
    while true {
        string userId = io:readln("Enter user ID (or 'done' to finish): ");
        if userId == "done" {
            break;
        }
        string userType = io:readln("Enter user type: ");
        CreateUser createUsersRequest = {user_id: userId, user_type: userType};
        check createUsersStreamingClient->sendCreateUser(createUsersRequest);
    }
    check createUsersStreamingClient->complete();
    string? createUsersResponse = check createUsersStreamingClient->receiveString();
    io:println(createUsersResponse);
}