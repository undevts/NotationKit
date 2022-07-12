# NotationKit

The fastest Swift decoding & encoding framework.

## Artifacts

+ NotationKit

    The overlay module that re-exports the complete public interface of notation kit.

+ JSONKit

    The JSON related encoders and decoders.

+ JSONBuilerKit

    The `SwiftUI` API style JSON builer.

+ AnyNotationKit (WIP)

    The toolkit to dealing with `[AnyHashable: Any]`.

## Adding notation kit to your project.

Notation kit only available with SPM:

1. Add the following line to the dependencies in your Package.swift file:

    ```swift
    .package(url: "https://github.com/undevts/NotationKit.git", from: "0.3.0"),
    ```

2. Add Numerics as a dependency for your target:

    ```swift
    .target(name: "MyTarget", dependencies: [
      .product(name: "JSONKit", package: "NotationKit"),
    ]),
    ```

3. Add `import JSONKit` in your source code.

## Common tasks

### Decoding from JSON

To decoding an entity from JSON string or data,
a class or struct just needs to implement the `JSONDecodable` protocol.

`JSONDecodable` has only a requirement: `init(_ json: JSON)`.

In most cases, a single `decoded` function is enough to use.

```swift
import JSONKit

// If your prefer string keys.
struct User: JSONDecodable {
    let username: String
    let age: Int
    let array: [JSON]
    let dictionary: [String: String]
    let friends: [User]
    
    init(_ json: JSON) {
        var keyed = json.keyed()
        username = keyed.decoded(key: "username")
        age = keyed.decoded(key: "age")
        array = keyed.decoded(key: "list")
        dictionary = keyed.decoded(key: "map")
        friends = keyed.decoded(key: "friends")
    }
}

// Or if your prefer typed keys.
struct User: JSONDecodable {
    let username: String
    let age: Int
    let array: [JSON]
    let dictionary: [String: String]
    let friends: [User]

    init(_ json: JSON) {
        var keyed = json.keyed(by: CodingKeys.self)
        username = keyed.decoded(key: .username)
        age = keyed.decoded(key: .age)
        array = keyed.decoded(key: .array)
        dictionary = keyed.decoded(key: .dictionary)
        friends = keyed.decoded(key: .friends)
    }
    
    enum CodingKeys: String, CodingKey {
        case username
        case age
        case array = "list"
        case dictionary = "map"
        case friends
    }
}
```

Now, we can convert a JSON data to the `User` model with a single line code.

```swift
let result: Result<User, JSONParseError> = JSON.parse(data, as: User.self)
```

### Encoding to JSON



## Use the JSON decoding API

Any scalar types (Int, UInt, Bool, Double, String etc.) could use `decoded` series method to create new scalar values, arrays or dictionarys.
For example:

1. Int： `let age: Int = json.decoded("age")`

1. Int?: `let age: Int? = json.decodedValue("age")`, note the "Value" suffix.

1. [Int]: `let array: [Int] = json.decoded("array")`

1. [String: Int]: `let map: [String: Int] = json.decoded("map")`

For performance reasons, scalar types are **NOT** `JSONDecodable`. The above methods are directly dealt with scalar types.
So, 

```swift
let age: Int? = json.decoded("age") // ❎ Age is declared optional but never will be `nil`.
let age: Int? = json.decodedValue("age") // ✅ The correct way.
```

## Keyed JSON

Although the `JSON` struct can use subscripts to get arrays or dictionarys,
the most efficient way is to use `KeyedJSON` or `StringedKeyJSON`.

```swift
let json: JSON = ...
var keyed = json.keyed()
let bar = keyed.decoded("bar") as String
// Same as above, with a slight performance penalty.
let foo = json["foo"].string
```

## SwiftyJSON style API

`JSON` do provide `SwiftyJSON` style API, and `decoded` series method is built on top of it.
But don't use it unless there is a specific reason.

Unlike `SwiftyJSON`, the scalar getters returns a non-null value, and vice versa.

```swift
let name: String = json["name"].string
let age: Int? = json["age"].intValue
```

## Codable style API

JSON kit comes with standard decoder: `JSONSimdDecoder`.
Just replace `JSONDecoder` with `JSONSimdDecoder` and things are done.

```swift
let product = try JSONDecoder().decode(GroceryProduct.self, from: json)
let product = try JSONSimdDecoder().decode(GroceryProduct.self, from: json)
```

**Note**: `JSONSimdDecoder` has no support of `Swift.JSONDecoder.KeyDecodingStrategy`.

## Known issues

1. When installing with SPM, `JSON` is `class` insteal of `struct`. Even though the code is exactly the same and it all compiles, using `struct` will cause crazy and weird crashes.

2. There is no way to get the raw text of a number.

## Why another JSON decoding framework

1. `JSONDecoder` and `Codable` is slow.
2. `Codable` API is difficult to use.
3. There is no **fast** and **handy** Swift JSON framework.
