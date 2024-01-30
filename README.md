# UNHOSTED PAYROLL (Salary Manager)

## Overview

The PayrollManager is a smart contract module designed for integration with the Unhosted Wallet, specifically tailored for managing employee payrolls in a decentralized environment. This module provides a streamlined and secure way to handle payroll operations including adding, removing, updating salaries, and processing payments for employees.

## Features

- **Employee Management**: Add and remove employees from the payroll system.
- **Salary Management**: Update employee salaries as required.
- **Salary Payments**: Process monthly salary payments and bonus payments.
- **Batch Payments**: Pay all active employees at once with the `payAllSalaries` function.
- **Security**: Inherits from OpenZeppelin's Ownable, ensuring that only the owner (employer) can manage employees and their salaries.
- **Transparency and Trust**: All transactions are recorded on the blockchain, ensuring transparency and trust in the payroll process.

## Functions

- `addEmployee(address _employee, uint256 _salary)`: Add a new employee with their salary.
- `removeEmployee(address _employee)`: Remove an existing employee from the payroll.
- `updateSalary(address _employee, uint256 _newSalary)`: Update the salary of an existing employee.
- `paySalary(address _employee)`: Pay the monthly salary to a specific employee.
- `bonus(address _employee)`: Pay a bonus to a specific employee.
- `payAllSalaries()`: Pay all active employees their monthly salary in one transaction.
- `withdraw(uint256 _amount)`: Withdraw funds from the contract.
- `checkBalance()`: Check the contract's current balance.


---

This documentation provides a high-level overview and should be supplemented with more detailed technical documentation, particularly around security measures and integration steps specific to the Unhosted Wallet.
