// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentRecord {

    // Enum for student status
    enum Status { Active, Inactive, Graduated }

    // Struct to hold student data
    struct Student {
        string name;
        uint age;
        Status status;
        bool isRegistered;
    }

    // Mapping from address to their student record
    mapping(address => Student) private students;

    // Register a new student
    function registerStudent(string memory _name, uint _age) public {
        require(!students[msg.sender].isRegistered, "Student already registered");

        students[msg.sender] = Student({
            name: _name,
            age: _age,
            status: Status.Active,
            isRegistered: true
        });
    }

    // Update a student's status
    function updateStatus(Status _newStatus) public {
        require(students[msg.sender].isRegistered, "Student not registered");
        students[msg.sender].status = _newStatus;
    }

    // Retrieve a student's record
    function getStudent(address _studentAddress) public view returns (string memory, uint, Status) {
        require(students[_studentAddress].isRegistered, "No record found for this address");

        Student memory s = students[_studentAddress];
        return (s.name, s.age, s.status);
    }
}
