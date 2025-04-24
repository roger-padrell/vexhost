import ../src/aes, unittest

suite "Encryption":
    test "small-small":
        let key = "myKey"
        let data = "Hello"
        let enc = data.encryptData(key);
        let decr = enc.decryptData(key);
        assert decr == data;

    test "BIG-small":
        let key = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc nec lobortis justo. Aliquam luctus eu. "
        let data = "Hello"
        let enc = data.encryptData(key);
        let decr = enc.decryptData(key);
        assert decr == data;

    test "BIG-BIG":
        let key = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc nec lobortis justo. Aliquam luctus eu. "
        let data = "Nulla malesuada sem arcu. Donec nulla tellus, hendrerit sed luctus et, laoreet ut erat orci aliquam. "
        let enc = data.encryptData(key);
        let decr = enc.decryptData(key);
        assert decr == data;

    test "small-BIG":
        let key = "myKey"
        let data = "Nulla malesuada sem arcu. Donec nulla tellus, hendrerit sed luctus et, laoreet ut erat orci aliquam. "
        let enc = data.encryptData(key);
        let decr = enc.decryptData(key);
        assert decr == data;