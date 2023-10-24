#if SWIFT_PACKAGE
@_implementationOnly import JSONSimd
#endif

extension JSON {
    @inlinable
    public func keyed() -> StringKeyedJSON {
        if let root = objectRoot {
            return StringKeyedJSON(storage: storage, root: root)
        }
        return StringKeyedJSON(storage: storage)
    }

    @inlinable
    public func keyed<Key>(by type: Key.Type) -> KeyedJSON<Key> where Key: CodingKey {
        if let root = objectRoot {
            return KeyedJSON(storage: storage, root: root)
        }
        return KeyedJSON(storage: storage)
    }
}

// Direct use of the `struct` will cause **Crash**, same as `JSON`. so, wrapped by `class`.
@usableFromInline
final class KeyedContainer {
    let storage: JSONStorage
    let isEmpty: Bool
    private var root: json_object
    private var start: json_object_iterator
    private var end: json_object_iterator
    private var cache: Set<Item> = []

    @inline(__always)
    @usableFromInline
    init(storage: JSONStorage) {
        self.storage = storage
        isEmpty = true
        root = json_object()
        start = json_object_iterator()
        end = json_object_iterator()
    }

    @inline(__always)
    @usableFromInline
    init(storage: JSONStorage, root: json_object) {
        var root = root
        var start = json_object_iterator()
        var end = json_object_iterator()
        nk_json_object_get_begin_iterator(&root, &start)
        nk_json_object_get_end_iterator(&root, &end)
        self.storage = storage
        isEmpty = nk_json_object_iterator_is_equal(&start, &end)
        self.root = root
        self.start = start
        self.end = end
    }

    @inline(__always)
    @usableFromInline
    func item(key: String) -> JSON {
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
        if nk_json_object_iterator_is_equal(&start, &end) {
            // All key is read but no match.
            return JSON.null
        }
        var size = 0
        var value = json_value()
        while !nk_json_object_iterator_is_equal(&start, &end) {
            let raw = nk_json_object_iterator_get_key(&start, &size)
            _ = nk_json_object_iterator_get_value(&start, &value)
            nk_json_object_iterator_move_next(&start)
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
        let value: json_value

        init(key: String) {
            self.key = key
            value = json_value()
        }

        init(key: String, value: json_value) {
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

/// Decode a JSON Object with String keys.
@frozen
public struct StringKeyedJSON {
    @usableFromInline
    let delegate: KeyedContainer

    @inlinable
    @inline(__always)
    init(storage: JSONStorage) {
        delegate = KeyedContainer(storage: storage)
    }

    @inlinable
    @inline(__always)
    init(storage: JSONStorage, root: json_object) {
        delegate = KeyedContainer(storage: storage, root: root)
    }

    @inlinable
    public subscript(key: String) -> JSON {
        mutating get {
            item(key: key)
        }
    }

    @inlinable
    public mutating func item(key: String) -> JSON {
        // No need to COW here.
        delegate.item(key: key)
    }
}

/// Decode a JSON Object with typed keys.
@frozen
public struct KeyedJSON<Key> where Key: CodingKey {
    @usableFromInline
    let delegate: KeyedContainer

    @inlinable
    @inline(__always)
    init(storage: JSONStorage) {
        delegate = KeyedContainer(storage: storage)
    }

    @inlinable
    @inline(__always)
    init(storage: JSONStorage, root: json_object) {
        delegate = KeyedContainer(storage: storage, root: root)
    }

    @inlinable
    public subscript(key: Key) -> JSON {
        mutating get {
            item(key: key)
        }
    }

    @inlinable
    public mutating func item(key: Key) -> JSON {
        // No need to COW here.
        delegate.item(key: key.stringValue)
    }
}
