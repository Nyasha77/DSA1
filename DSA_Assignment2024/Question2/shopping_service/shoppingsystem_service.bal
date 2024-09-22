import ballerina/grpc;

listener grpc:Listener ep = new (9090);

// In-memory storage
map<Product> products = {};
map<string[]> carts = {};
map<string> users = {};

@grpc:Descriptor {value: SHOPPING_DESC}
service "ShoppingSystem" on ep {
    remote function addProduct(AddProduct value) returns string|error {
        Product product = value.product;
        products[product.sku] = product;
        return "Product added successfully";
    }

    remote function updateProduct(UpdateProduct value) returns string|error {
        Product product = value.product;
        if !products.hasKey(product.sku) {
            return error("Product not found");
        }
        products[product.sku] = product;
        return "Product updated successfully";
    }

    remote function removeProduct(RemoveProduct value) returns string|error {
        if !products.hasKey(value.sku) {
            return error("Product not found");
        }
        _ = products.remove(value.sku);
        return "Product removed successfully";
    }

    remote function searchProduct(SearchProduct value) returns SearchProductResponse|error {
        if !products.hasKey(value.sku) {
            return error("Product not found");
        }
        SearchProductResponse response = {product: products.get(value.sku)};
        return response;
    }

    remote function addToCart(AddToCart value) returns string|error {
        if !users.hasKey(value.user_id) {
            return error("User not found");
        }
        if !products.hasKey(value.sku) {
            return error("Product not found");
        }
        if !carts.hasKey(value.user_id) {
            carts[value.user_id] = [];
        }
        carts.get(value.user_id).push(value.sku);
        return "Product added to cart successfully";
    }

    remote function placeOrder(PlaceOrder value) returns string|error {
        if !users.hasKey(value.user_id) {
            return error("User not found");
        }
        if !carts.hasKey(value.user_id) || carts.get(value.user_id).length() == 0 {
            return error("Cart is empty");
        }
        // In a real implementation, you would process the order here
        _ = carts.remove(value.user_id);
        return "Order placed successfully";
    }

    remote function createUsers(stream<CreateUser, grpc:Error?> clientStream) returns string|error {
        error? e = clientStream.forEach(function(CreateUser user) {
            users[user.user_id] = user.user_type;
        });
        if (e is error) {
            return e;
        }
        return "Users created successfully";
    }

    remote function listAvailableProducts() returns stream<ListAvailableProducts, error?>|error {
        return stream from [string, Product] [_, product] in products.entries()
            select {product: product};
    }
}

