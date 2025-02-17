// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.5.16;

import "./Utils.sol";

contract SupplyChain {

    uint32 public productId = 0;
    uint32 public participantId = 0;
    uint32 public ownerId = 0;

    string public constant Manufacturer = "Manufacturer";
    string public constant Supplier = "Supplier";
    string public constant Consumer = "Consumer";

    using Utils for string;

    struct product {
        string modelNumber;
        string serialNumber;
        address productOwner;
        uint32 cost;
        uint32 timestamp;
    }

    mapping(uint32 => product) public products;

    struct ownership {
        uint32 productId;
        uint32 ownerId;
        uint32 trxTimestamp;
        address productOwner;
    }

    mapping(uint32 => ownership) public ownerships;
    mapping(uint32 => uint32[]) public productTrack;

    struct participant {
        string username;
        string pwd;
        string participantType;
        address participantAddress;
    }

    mapping(uint32 => participant) public participants;


    modifier onlyOwner(uint32 _productId) {
        require(msg.sender == products[_productId].productOwner, "");
        _;
    }

    function addParticipant(string memory name, string memory pwd, address pAdd, string memory pType) public returns (uint32) {
        uint32 userId = participantId++;
        participants[userId].username = name;
        participants[userId].pwd = pwd;
        participants[userId].participantAddress = pAdd;
        participants[userId].participantType = pType;
        return userId;
    }

    function getParticipant(uint32 _productId) public view returns (string memory, address, string memory)  {
        return (participants[_productId].username, participants[_productId].participantAddress, participants[_productId].participantType);
    }

    function addProduct(uint32 _ownerId, string memory modelNumber, string memory serialNumber, uint32 cost) public returns (uint32) {
        if (participants[_ownerId].participantType.equal(Manufacturer)) {
            uint32 tmpProductId = productId++;
            products[tmpProductId].modelNumber = modelNumber;
            products[tmpProductId].serialNumber = serialNumber;
            products[tmpProductId].cost = cost;
            products[tmpProductId].productOwner = participants[_ownerId].participantAddress;
            products[tmpProductId].timestamp = uint32(block.timestamp);
            return tmpProductId;
        }
        return 0;
    }

    function getProduct(uint32 _productId) public view returns (string memory, string memory, uint32, address, uint32) {
        return (products[_productId].modelNumber, products[_productId].serialNumber, products[_productId].cost, products[_productId].productOwner, products[_productId].timestamp);
    }

    event TransferOwnership(uint32 productId);


    function newOwner(uint32 currentUserId, uint32 newUserId, uint32 _productId) onlyOwner(_productId) public returns (bool) {

        participant memory p1 = participants[currentUserId];
        participant memory p2 = participants[newUserId];
        uint32 ownershipId = ownerId++;

        if (p1.participantType.equal(Manufacturer) && p2.participantType.equal(Supplier)) {
            ownerships[ownershipId].productId = _productId;
            ownerships[ownershipId].productOwner = p2.participantAddress;
            ownerships[ownershipId].ownerId = newUserId;
            ownerships[ownershipId].trxTimestamp = uint32(block.timestamp);
            products[_productId].productOwner = p2.participantAddress;
            productTrack[_productId].push(ownershipId);
            emit TransferOwnership(_productId);
            return (true);
        } else if (p1.participantType.equal(Supplier) && p2.participantType.equal(Supplier)) {
            ownerships[ownershipId].productId = _productId;
            ownerships[ownershipId].productOwner = p2.participantAddress;
            ownerships[ownershipId].ownerId = newUserId;
            ownerships[ownershipId].trxTimestamp = uint32(block.timestamp);
            products[_productId].productOwner = p2.participantAddress;
            productTrack[_productId].push(ownershipId);
            emit TransferOwnership(_productId);
            return (true);
        } else if (p1.participantType.equal(Supplier) && p2.participantType.equal(Consumer)) {
            ownerships[ownershipId].productId = _productId;
            ownerships[ownershipId].productOwner = p2.participantAddress;
            ownerships[ownershipId].ownerId = newUserId;
            ownerships[ownershipId].trxTimestamp = uint32(block.timestamp);
            products[_productId].productOwner = p2.participantAddress;
            productTrack[_productId].push(ownershipId);
            emit TransferOwnership(_productId);

            return (true);
        }

        return (false);
    }


    function getProvenance(uint32 _productId) external view returns (uint32[] memory) {
        return productTrack[_productId];
    }


}
