const ethers = require('ethers');

// Module Factory Contract Details Goerli
const moduleFactoryAddress = '0x2b2EA246FcEf28fE90f5de6FD54Bd121E0eD7066'; // Replace with the Module Factory address
const moduleFactoryABI = [...] // Replace with the Module Factory ABI

// Your PayrollManager Contract Details
const payrollManagerAddress = 'PAYROLL_MANAGER_ADDRESS'; // Replace with your PayrollManager address

async function deployStrategyModule() {
    // Connect to the Ethereum network
    const provider = new ethers.providers.JsonRpcProvider(providerUrl);
    const wallet = new ethers.Wallet(privateKey, provider);

    // Connect to the Module Factory Contract
    const moduleFactoryContract = new ethers.Contract(moduleFactoryAddress, moduleFactoryABI, wallet);

    try {
        // Deploy the Strategy Module
        const tx = await moduleFactoryContract.createStrategyModule(payrollManagerAddress, { gasLimit: 1000000 });
        console.log(`Transaction Hash: ${tx.hash}`);

        // Wait for the transaction to be mined
        const receipt = await tx.wait();
        console.log(`Transaction confirmed in block: ${receipt.blockNumber}`);

        // The address of the deployed strategy module will be in the event logs
        const strategyModuleAddress = '...'; // Extract from event logs
        console.log(`Strategy Module Deployed at: ${strategyModuleAddress}`);
    } catch (error) {
        console.error(`Error in deploying strategy module: ${error}`);
    }
}

deployStrategyModule();
