// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @notice The "job description" — the read functions this contract promises to expose.
interface IStudentRecord {
    enum Status { Active, Inactive, Graduated }

    function getStudent(address _studentAddress)
        external
        view
        returns (string memory name, uint256 age, Status status);
}

/// @title Student Record Contract — Observable & Controlled
/// @notice Session 2's contract, extended with events, an onlyOwner modifier, and an interface.
contract StudentRecord is IStudentRecord {

    struct Student {
        string name;
        uint256 age;
        Status status;
        bool isRegistered;
    }

    // The address that deployed this contract — the only one allowed to register/update students.
    address public owner;

    mapping(address => Student) private students;

    // ---- Events: the "public announcement board" ----
    event StudentRegistered(address indexed studentAddress, string name, uint256 age);
    event StatusUpdated(address indexed studentAddress, Status newStatus);

    // ---- Modifier: the "bouncer" — runs before the function body, blocks if the check fails ----
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can do this");
        _; // this underscore means "now let the rest of the function run"
    }

    constructor() {
        owner = msg.sender; // whoever deploys the contract becomes the owner
    }

    /// @notice Register a new student. Restricted to the owner only.
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

    /// @notice Update a student's status. Restricted to the owner only.
    function updateStatus(address _studentAddress, Status _newStatus) public onlyOwner {
        require(students[_studentAddress].isRegistered, "Student not registered");

        students[_studentAddress].status = _newStatus;
        emit StatusUpdated(_studentAddress, _newStatus);
    }

    /// @notice Retrieve a student's record. Open to anyone — matches the IStudentRecord interface.
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