// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

contract Files{
    struct Patients{
        string id;
        string name;
        uint256 age;
        string height;
        uint256 weight;
        string gender;
        string dob;
        string phone;
        string houseaddr;
        string bloodgroup;
        string allergies;
        string medication;
        string emergencyName;
        string emergencyContact;
        address addr;
        address doctoraddr;
        uint date;
    }

    struct Doctors{
        string id;
        string name;
        uint age;
        string phone;
        string gender;
        string dob;
        string qualification;
        string major;
        address addr;
        uint date;
    }

    struct Appointments{
        string name;
        address doctoraddr;
        address patientaddr;
        string date;
        string time;
        string prescription;
        string description;
        string diagnosis;
        uint creationDate;
    }

    mapping(address => Patients) patients;
    mapping(address => Doctors) doctors;
    mapping(address => Appointments) appointments;

    address public owner;
    address[] public patientList;
    address[] public doctorList;
    address[] public appointmentList;

    // mapping(address => address[]) appointmentMap;
    mapping(address => mapping(address => bool)) appointmentConfirmed;
    mapping(address => bool) isPatient;
    mapping(address => bool) isDoctor;

    function setFile(string memory _id, string memory _name, uint256 _age, string memory _phone, string memory _gender, string memory _dob, string memory _height, uint256 _weight, string memory _houseaddr, string memory _bloodgroup, string memory _allergies, string memory _medication, string memory _emergencyName, string memory _emergencyContact) public {
        require(!isPatient[msg.sender], "File already exists");
        Patients storage p = patients[msg.sender];

        p.id = _id;
        p.name = _name;
        p.phone = _phone;
        p.age = _age;
        p.gender = _gender;
        p.dob = _dob;
        p.height = _height; 
        p.weight = _weight;
        p.houseaddr = _houseaddr;
        p.bloodgroup = _bloodgroup;
        p.allergies = _allergies;
        p.medication = _medication;
        p.emergencyName = _emergencyName;
        p.emergencyContact = _emergencyContact;
        p.addr = msg.sender;
        p.date = block.timestamp;

        isPatient[msg.sender] = true;
        patientList.push(msg.sender);
    }

    function editFile(string memory _id, string memory _name, uint256 _age, string memory _phone, string memory _gender, string memory _dob, string memory _height, uint256 _weight, string memory _houseaddr, string memory _bloodgroup, string memory _allergies, string memory _medication, string memory _emergencyName, string memory _emergencyContact) public {
        require(isPatient[msg.sender]);
        Patients storage p = patients[msg.sender];
        p.id = _id;
        p.name = _name;
        p.age = _age;
        p.phone = _phone;
        p.gender = _gender;
        p.dob = _dob;
        p.height = _height; 
        p.weight = _weight;
        p.houseaddr = _houseaddr;
        p.bloodgroup = _bloodgroup;
        p.allergies = _allergies;
        p.medication = _medication;
        p.emergencyName = _emergencyName;
        p.emergencyContact = _emergencyContact;
    }

    function setDoctor(string memory _id, string memory _name, string memory _phone, string memory _gender, string memory _dob, string memory _qualification, string memory _major) public {
        require(!isDoctor[msg.sender]);
        Doctors storage d = doctors[msg.sender];
        d.id = _id;
        d.name = _name;
        d.phone = _phone;
        d.gender = _gender;
        d.dob = _dob;
        d.qualification = _qualification;
        d.major = _major;
        d.addr = msg.sender;
        d.date = block.timestamp;

        isDoctor[msg.sender] = true;
        doctorList.push(msg.sender);
    }

    function editDoctor(string memory _id, string memory _name, string memory _phone, string memory _gender, string memory _dob, string memory _qualification, string memory _major) public {
        require(isDoctor[msg.sender]);
        Doctors storage d = doctors[msg.sender];
        
        d.id = _id;
        d.name = _name;
        d.phone = _phone;
        d.gender = _gender;
        d.dob = _dob;
        d.qualification = _qualification;
        d.major = _major;
        d.addr = msg.sender;
    }

    function setAppointment(string memory _name, address _addr, string memory _date, string memory _time, string memory _diagnosis, string memory _prescription, string memory _description) public {
        require(isPatient[msg.sender] && isDoctor[_addr]);
        Appointments storage a = appointments[msg.sender];
        a.name = _name;
        a.doctoraddr = _addr;
        a.patientaddr = msg.sender;
        a.date = _date;
        a.time = _time;
        a.diagnosis = _diagnosis;
        a.prescription = _prescription;
        a.description = _description;
        a.creationDate = block.timestamp;

    }

    function confirmAppointment (address _patientaddr) public returns (bool success){
        require(isPatient[_patientaddr], "This patient file does not exist.");
        require(msg.sender == appointments[_patientaddr].doctoraddr, "You are not authorized");
        appointmentConfirmed[msg.sender][_patientaddr] = true;
        return true;

    }

    function revokeConfirmation (address _patientaddr) public returns (bool success){
        require(isPatient[_patientaddr], "This patient file does not exist.");
        require(appointmentConfirmed[msg.sender][_patientaddr]);

        appointmentConfirmed[msg.sender][_patientaddr] = false;
        return true;
    }

    function getDoctorDetails(address _addr) public view returns (string memory , string memory , string memory , string memory , string memory , string memory , string memory ){
        Doctors storage d = doctors[_addr];
        return (d.id, d.name, d.phone, d.gender, d.dob, d.qualification, d.major);
    }

    function getPatientDemo(address _addr) public view returns (string memory , string memory , uint256, string memory , uint256, string memory , string memory , string memory , string memory ){
        Patients storage p = patients[_addr];
        return (p.id, p.name, p.age, p.height, p.weight, p.gender, p.dob, p.phone, p.houseaddr);
    }

    function getPatientMedical(address _addr) public view returns (string memory , string memory , string memory , string memory , string memory ){
        Patients storage p = patients[_addr];
        return (p.bloodgroup, p.allergies, p.medication, p.emergencyName, p.emergencyContact);
    }

}