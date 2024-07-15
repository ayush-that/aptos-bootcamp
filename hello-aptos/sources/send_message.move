// There are three main components in this file
// 1. Structs
// 2. Functions
// 3. Tests

module send_message.move::hello {
    use std::string:: {utf8, String, self};
    use std::signer;
    use aptos_framework::account;

    // 1. Structs
    struct message has key {
        Message: String;
    }

    // 2. Functions
    public entry fun message_fun(account:&signer, msg:String) acquires signer {
        // Get the address of the signer
        let signer_address = signer::address_of(account);

        // Check if the signer has already sent a message
        if(!exists<Message>(signer_address)){
            let message = Message {
                my_msg: msg,
                };
                move_to(account, message);
        }
        // If the signer has already sent a message
        else {
            // To fetch the value of the struct from the storage we use the borrow function
            let message = borrow_global_mut<Message>(signer_address);
            message.my_msg = msg;
        }
    }
}
