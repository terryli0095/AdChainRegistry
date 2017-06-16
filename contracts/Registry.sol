pragma solidity 0.4.11;
contract Registry {
        mapping(bytes32 => bool) public domainMap;
        function add(string _domain) {
                bytes32 domainHash = sha3(_domain);
                domainMap[domainHash] = true;
        }
        function isVerified(string _domain) returns (bool) {
                bytes32 domainHash = sha3(_domain);
                return domainMap[domainHash];
        }
}
