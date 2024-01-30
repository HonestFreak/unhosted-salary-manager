// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract PayrollManager is Ownable {

    struct Employee {
        uint256 salary;
        uint256 lastPaid;
        bool isActive;
    }

    mapping(address => Employee) public employees;
    address[] private allEmployees;

    event SalaryUpdated(address indexed employee, uint256 newSalary);
    event EmployeeAdded(address indexed employee);
    event EmployeeRemoved(address indexed employee);
    event PaymentMade(address indexed employee, uint256 amount);
    event DepositReceived(address indexed sender, uint256 amount);

    constructor(address _owner) Ownable(_owner) {}

    function addEmployee(address _employee, uint256 _salary) public onlyOwner {
        require(_employee != address(0), "Invalid address");
        require(_salary > 0, "Salary must be greater than 0");
        require(!employees[_employee].isActive, "Employee already exists");

        employees[_employee] = Employee(_salary, block.timestamp, true);
        allEmployees.push(_employee);
        emit EmployeeAdded(_employee);
    }

    function removeEmployee(address _employee) public onlyOwner {
        require(employees[_employee].isActive, "Employee does not exist");
        
        employees[_employee].isActive = false;
        emit EmployeeRemoved(_employee);
    }

    function updateSalary(address _employee, uint256 _newSalary) public onlyOwner {
        require(employees[_employee].isActive, "Employee does not exist");
        require(_newSalary > 0, "Salary must be greater than 0");

        employees[_employee].salary = _newSalary;
        emit SalaryUpdated(_employee, _newSalary);
    }

    function paySalary(address _employee) public payable {
        require(employees[_employee].isActive, "Employee does not exist");
        Employee storage employee = employees[_employee];
        require(block.timestamp - employee.lastPaid >= 30 days, "Salary already paid this month");

        uint256 paymentAmount = employee.salary;
        require(address(this).balance >= paymentAmount, "Insufficient funds in contract");
        
        employee.lastPaid = block.timestamp;
        payable(_employee).transfer(paymentAmount);
        emit PaymentMade(_employee, paymentAmount);
    }

    function bonus(address _employee) public payable {
    // does not check 30 day time gap
        require(employees[_employee].isActive, "Employee does not exist");
        Employee storage employee = employees[_employee];
        uint256 paymentAmount = employee.salary;
        require(address(this).balance >= paymentAmount, "Insufficient funds in contract");
        
        employee.lastPaid = block.timestamp;
        payable(_employee).transfer(paymentAmount);
        emit PaymentMade(_employee, paymentAmount);
    }

    function payAllSalaries() public payable onlyOwner {
        for (uint i = 0; i < allEmployees.length; i++) {
            if (employees[allEmployees[i]].isActive && (block.timestamp - employees[allEmployees[i]].lastPaid >= 30 days)) {
                paySalary(allEmployees[i]);
            }
        }
    }

    function withdraw(uint256 _amount) public onlyOwner {
        require(_amount <= address(this).balance, "Insufficient balance");
        payable(msg.sender).transfer(_amount);
    }

    function checkBalance() public view returns (uint256) {
        return address(this).balance;
    }

receive() external payable {
    emit DepositReceived(msg.sender, msg.value);
}

fallback() external payable {
    emit DepositReceived(msg.sender, msg.value);
}
}
