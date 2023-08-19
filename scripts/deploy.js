async function main(){
    const [deployer] = await ethers.getSigners()
    const Files = await ethers.getContractFactory("Files")
    const files = await Files.deploy()
    console.log("Deployed Files Contract at:", files.address);
}

main()
.then(() => process.exit(0))
.catch((error) => {
  console.error(error);
  process.exit(1)
})