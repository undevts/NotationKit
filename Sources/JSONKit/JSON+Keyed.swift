#if SWIFT_PACKAGE
@_implementationOnly import JSONSimd
#endif

extension JSON {
    public func keyed() -> StringKeyedJSON {
        if let root = objectRoot {
            return StringKeyedJSON(storage: storage, root: root)
        }
        return StringKeyedJSON(storage: storage)
    }

    public func keyed<Key>(by type: Key.Type) -> KeyedJSON<Key> where Key: CodingKey {
        if let root = objectRoot {
            return KeyedJSON(storage: storage, root: root)
        }
        return KeyedJSON(storage: storage)
    }
}

/// Decode a JSON Object with String keys.
public final class StringKeyedJSON {
    let storage: JSONStorage
    let isEmpty: Bool
    private var root: JSONObject
    private var start: JSONObjectIterator
    private var end: JSONObjectIterator
    private var cache: Set<Item> = []

    @inline(__always)
    init(storage: JSONStorage) {
        self.storage = storage
        isEmpty = true
        root = JSONObject()
        start = JSONObjectIterator()
        end = JSONObjectIterator()
    }

    @inline(__always)
    init(storage: JSONStorage, root: JSONObject) {
        var root = root
        var start = JSONObjectIterator()
        var end = JSONObjectIterator()
        json_object_get_begin_iterator(&root, &start)
        json_object_get_end_iterator(&root, &end)
        self.storage = storage
        isEmpty = json_object_iterator_is_equal(&start, &end)
        self.root = root
        self.start = start
        self.end = end
    }

    @inlinable
    public subscript(key: String) -> JSON {
        get {
            item(key: key)
        }
    }

    public func item(key: String) -> JSON {
        // Current root is empty.
        if isEmpty {
            return JSON.null
        }
        // Find in cache first.
        let first = cache.firstIndex(of: Item(key: key))
        if let index = first {
            return JSON(storage: storage, value: cache[index].value)
        }
        // Next find in JSON Object.
        if json_object_iterator_is_equal(&start, &end) {
            // All key is read but no match.
            return JSON.null
        }
        var size = 0
        var value = JSONValue()
        while !json_object_iterator_is_equal(&start, &end) {
            let raw = json_object_iterator_get_key(&start, &size)
            _ = json_object_iterator_get_value(&start, &value)
            json_object_iterator_move_next(&start)
            // TODO: use size
            if let raw = raw, size > 0 {
                let _key = String(cString: raw)
                cache.insert(Item(key: _key, value: value))
                if _key == key {
                    return JSON(storage: storage, value: value)
                }
            } else if key == "" {
                cache.insert(Item(key: "", value: value))
                return JSON(storage: storage, value: value)
            }
        }
        return JSON.null
    }

    struct Item: Hashable {
        let key: String
        let value: JSONValue

        init(key: String) {
            self.key = key
            value = JSONValue()
        }

        init(key: String, value: JSONValue) {
            self.key = key
            self.value = value
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(key)
        }

        static func ==(lhs: Item, rhs: Item) -> Bool {
            lhs.key == rhs.key
        }
    }
}

/// Decode a JSON Object with typed keys.
public final class KeyedJSON<Key> where Key: CodingKey {
    private var delegate: StringKeyedJSON

    @inline(__always)
    init(storage: JSONStorage) {
        delegate = StringKeyedJSON(storage: storage)
    }

    @inline(__always)
    init(storage: JSONStorage, root: JSONObject) {
        delegate = StringKeyedJSON(storage: storage, root: root)
    }

    @inlinable
    public subscript(key: Key) -> JSON {
        get {
            item(key: key)
        }
    }

    public func item(key: Key) -> JSON {
        delegate.item(key: key.stringValue)
    }
}

extension StringKeyedJSON {
    @inlinable
    public func decoded<T>(key: String, map method: (JSON) -> T) -> [T] {
        item(key: key).decoded(map: method)
    }

    @inlinable
    public func decoded<T>(key: String, compactMap method: (JSON) -> T?) -> [T] {
        item(key: key).decoded(compactMap: method)
    }
}

extension KeyedJSON {
    @inlinable
    public func decoded<T>(key: Key, map method: (JSON) -> T) -> [T] {
        item(key: key).decoded(map: method)
    }

    @inlinable
    public func decoded<T>(key: Key, compactMap method: (JSON) -> T?) -> [T] {
        item(key: key).decoded(compactMap: method)
    }
}
