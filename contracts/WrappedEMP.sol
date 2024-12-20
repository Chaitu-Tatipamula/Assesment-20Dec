    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.0;

    import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

    contract WrappedEMP is ERC20 {
        ERC20 public empToken;

        constructor(address _empToken) ERC20("Wrapped EMP", "wEMP") {
            empToken = ERC20(_empToken);
        }

        // Function to wrap EMP into wEMP
        function wrapEMP(uint256 _empAmount) external {
            require(empToken.transferFrom(msg.sender, address(this), _empAmount), "EMP transfer failed");
            _mint(msg.sender, _empAmount);
        }

        // Function to unwrap wEMP back into EMP
        function unwrapEMP(uint256 _wempAmount) external {
            _burn(msg.sender, _wempAmount);
            require(empToken.transfer(msg.sender, _wempAmount), "EMP transfer failed");
        }
    }
