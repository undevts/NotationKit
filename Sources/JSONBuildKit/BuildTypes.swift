extension List {
    @inlinable
    public init<Data>(_ data: Data)
        where Content == ForEach<Data, ValueComponent>, Data: RandomAccessCollection, Data.Element == Int {
        content = ForEach(data) { element in
            ValueComponent(element)
        }
    }

    @inlinable
    public init<Data>(_ data: Data)
        where Content == ForEach<Data, ValueComponent>, Data: RandomAccessCollection, Data.Element == Int32 {
        content = ForEach(data) { element in
            ValueComponent(element)
        }
    }

    @inlinable
    public init<Data>(_ data: Data)
        where Content == ForEach<Data, ValueComponent>, Data: RandomAccessCollection, Data.Element == Int64 {
        content = ForEach(data) { element in
            ValueComponent(element)
        }
    }

    @inlinable
    public init<Data>(_ data: Data)
        where Content == ForEach<Data, ValueComponent>, Data: RandomAccessCollection, Data.Element == UInt {
        content = ForEach(data) { element in
            ValueComponent(element)
        }
    }

    @inlinable
    public init<Data>(_ data: Data)
        where Content == ForEach<Data, ValueComponent>, Data: RandomAccessCollection, Data.Element == UInt32 {
        content = ForEach(data) { element in
            ValueComponent(element)
        }
    }

    @inlinable
    public init<Data>(_ data: Data)
        where Content == ForEach<Data, ValueComponent>, Data: RandomAccessCollection, Data.Element == UInt64 {
        content = ForEach(data) { element in
            ValueComponent(element)
        }
    }

    @inlinable
    public init<Data>(_ data: Data)
        where Content == ForEach<Data, ValueComponent>, Data: RandomAccessCollection, Data.Element == Double {
        content = ForEach(data) { element in
            ValueComponent(element)
        }
    }

    @inlinable
    public init<Data>(_ data: Data)
        where Content == ForEach<Data, ValueComponent>, Data: RandomAccessCollection, Data.Element == Float {
        content = ForEach(data) { element in
            ValueComponent(element)
        }
    }

    @inlinable
    public init<Data>(_ data: Data)
        where Content == ForEach<Data, ValueComponent>, Data: RandomAccessCollection, Data.Element == Bool {
        content = ForEach(data) { element in
            ValueComponent(element)
        }
    }

    @inlinable
    public init<Data>(_ data: Data)
        where Content == ForEach<Data, ValueComponent>, Data: RandomAccessCollection, Data.Element == String {
        content = ForEach(data) { element in
            ValueComponent(element)
        }
    }

    @inlinable
    public init<Data>(_ data: Data)
        where Content == ForEach<Data, WrapComponent<Data.Element>>, Data: RandomAccessCollection,
        Data.Element: JSONEncodable {
        content = ForEach(data) { element in
            WrapComponent(element)
        }
    }

}
