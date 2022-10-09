const { expect } = require('chai');

describe('Token Contract', () => {
  let Token;
  let owner;
  let addr1;
  let addr2;
  let addrs;
  let hardhatToken;

  beforeEach(async () => {
    [owner, addr1, addr2, ...addrs] = await ethers.getSigners();
    Token = await ethers.getContractFactory('Token');
    hardhatToken = await Token.deploy();
  });
  describe('Deploy Contract', () => {
    it('Owner address', async () => {
      expect(await hardhatToken.owner()).to.equal(owner.address);
    });
    it('Deployment should assign to total supply of token to the owner', async () => {
      const ownerBalance = await hardhatToken.balanceOf(owner.address);
      expect(await hardhatToken.totalSupply()).to.equal(ownerBalance);
    });
    it('Should transfer', async () => {
      // Transfer 10 token from owner to addr1.
      await hardhatToken.transfer(addr1.address, 10);
      expect(await hardhatToken.balanceOf(addr1.address)).to.equal(10);

      // Transfer 5 token from addr1 to addr2.
      await hardhatToken.connect(addr1).transfer(addr2.address, 5);
      expect(await hardhatToken.balanceOf(addr2.address)).to.equal(5);
    });
    it('Should fail if sender does not have enough tokens', async () => {
      const initialOwnerBalance = await hardhatToken.balanceOf(owner.address);
      await expect(
        hardhatToken.connect(addr1).transfer(owner.address, 1)
      ).to.revertedWith('Not enaught token!');
      expect(await hardhatToken.balanceOf(owner.address)).to.equal(
        initialOwnerBalance
      );
    });
    it('Balance after transfer', async () => {
      const initialOwnerBalance = await hardhatToken.balanceOf(owner.address);
      await hardhatToken.transfer(addr1.address, 5);
      await hardhatToken.transfer(addr2.address, 10);

      expect(await hardhatToken.balanceOf(owner.address)).to.equal(
        initialOwnerBalance - 15
      );
      expect(await hardhatToken.balanceOf(addr1.address)).to.equal(5);
      expect(await hardhatToken.balanceOf(addr2.address)).to.equal(10);
    });
  });
});
