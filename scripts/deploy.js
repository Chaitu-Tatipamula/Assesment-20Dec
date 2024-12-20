
const hre = require("hardhat");

async function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

async function main() {
  const empToken = await hre.ethers.deployContract("EMPToken");
  await empToken.waitForDeployment();
  console.log("EMPToken Contract Deployed at : ", empToken.target);
  
  const wempToken = await hre.ethers.deployContract("WrappedEMP",[empToken.target]);
  await wempToken.waitForDeployment();
  console.log("WEMPToken Contract Deployed at : ", wempToken.target);

  await sleep(30*1000);

  await hre.run("verify:verify",{
    address : empToken.target,
    constructorArguments : []
  })

  await hre.run("verify:verify",{
    address : wempToken.target,
    constructorArguments : [empToken.target]
  })
  
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
