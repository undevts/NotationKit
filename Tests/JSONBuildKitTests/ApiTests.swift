import JSONBuildKit

private func consume<Content>(@JSONBuilder build: () -> Content) where Content: Component {
    _ = build()
}

func basic(user: User, keyedUser: KeyedUser) {
    consume {
        Int(1)
    }
    consume {
        Int32(1)
    }
    consume {
        Int64(1)
    }
    consume {
        UInt(1)
    }
    consume {
        UInt32(1)
    }
    consume {
        UInt64(1)
    }
    consume {
        true
    }
    consume {
        120.34
    }
    consume {
        Float.pi
    }
    consume {
        WrapComponent(user)
    }
    consume {
        WrapComponent(keyedUser)
    }
}

func list(user: User, keyedUser: KeyedUser) {
    consume {
        List([Int(1)])
    }
    consume {
        List([Int32(1)])
    }
    consume {
        List([Int64(1)])
    }
    consume {
        List([UInt(1)])
    }
    consume {
        List([UInt32(1)])
    }
    consume {
        List([UInt64(1)])
    }
    consume {
        List([true])
    }
    consume {
        List([120.34])
    }
    consume {
        List([Float.pi])
    }
    consume {
        List([user])
    }
    consume {
        List([keyedUser])
    }
}
