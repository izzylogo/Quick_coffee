//SPDX-License-Identifier: Unlicense
// BuyMeACoffee deployed to: 0xa123e91385f3307c929C85B6f52A4D56e918a150
pragma solidity ^0.8.0;


contract BuyMeACoffee {
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );
    
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }
    
    address payable owner;

    Memo[] memos;

    constructor() {
        owner = payable(msg.sender);
    }

   
    function getMemos() public view returns (Memo[] memory) {
        return memos;
    }

    /**
     * @dev buy a coffee for owner (sends an ETH tip and leaves a memo)
     * @param _name name of the coffee purchaser
     * @param _message a nice message from the purchaser
     */
    function buyCoffee(string memory _name, string memory _message) public payable {
        // Must accept more than 0 ETH for a coffee.
        require(msg.value > 0, "can't buy coffee for free!");

        // Add the memo to storage!
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        // Emit a NewMemo event with details about the memo.
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }

    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }
}