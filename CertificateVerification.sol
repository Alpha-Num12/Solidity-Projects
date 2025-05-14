// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CertificateVerification {
    struct Certificate {
        string holderName;
        string courseName;
        uint256 issuedDate;
        uint256 expiryDate;
        bool isValid;
    }

    mapping(uint256 => Certificate) public certificates;
    address public issuer;

    constructor() {
        issuer = msg.sender;
    }

    function issueCertificate(uint256 certificateId, string memory holderName, string memory courseName, uint256 duration) public {
        require(msg.sender == issuer, "Only the authorized issuer can issue certificates");
        certificates[certificateId] = Certificate(holderName, courseName, block.timestamp, block.timestamp + duration, true);
    }

    function verifyCertificate(uint256 certificateId) public view returns (string memory holderName, string memory courseName, uint256 issuedDate, uint256 expiryDate, bool isValid) {
        Certificate memory cert = certificates[certificateId];
        bool validStatus = cert.isValid && block.timestamp < cert.expiryDate;
        return (cert.holderName, cert.courseName, cert.issuedDate, cert.expiryDate, validStatus);
    }

    function revokeCertificate(uint256 certificateId) public {
        require(msg.sender == issuer, "Only the authorized issuer can revoke certificates");
        certificates[certificateId].isValid = false;
    }
}

