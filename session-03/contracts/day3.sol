// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IStudentRecord {
    enum Status { Active, Inactive, Graduated }

    function getStudent(address _studentAddress)
        external
        view
        returns (string memory name, uint256 age, Status status);
}

contract StudentRecord is IStudentRecord {
    struct Student {
        string name;
        uint256 age;
        Status status;
        bool isRegistered;
    }

    address public owner;
    mapping(address => Student) private students;

    event StudentRegistered(address indexed studentAddress, string name, uint256 age);
    event StatusUpdated(address indexed studentAddress, Status newStatus);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can do this");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function registerStudent(
        address _studentAddress,
        string memory _name,
        uint256 _age
    ) public onlyOwner {
        require(!students[_studentAddress].isRegistered, "Student already registered");

        students[_studentAddress] = Student({
            name: _name,
            age: _age,
            status: Status.Active,
            isRegistered: true
        });

        emit StudentRegistered(_studentAddress, _name, _age);
    }

    function updateStatus(address _studentAddress, Status _newStatus) public onlyOwner {
        require(students[_studentAddress].isRegistered, "Student not registered");

        students[_studentAddress].status = _newStatus;
        emit StatusUpdated(_studentAddress, _newStatus);
    }

    function getStudent(address _studentAddress)
        public
        view
        override
        returns (string memory name, uint256 age, Status status)
    {
        require(students[_studentAddress].isRegistered, "No record found for this address");

        Student memory s = students[_studentAddress];
        return (s.name, s.age, s.status);
    }
}