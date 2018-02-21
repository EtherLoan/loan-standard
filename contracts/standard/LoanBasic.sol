pragma solidity 0.4.18;

import './Loan.sol';

/// @title Loan Basic Standard
/// @author anibal.catalan@consensys.net andres.junge@consensys.net
contract LoanBasic is Loan {

    /// @notice returns the amount of tokens that borrower is asking for.
    /// @dev returns the amount of the loan, the amount of ERC20 Tokens that the borrower is asking for.
    function getAmount() public view returns(uint256);

    /// @notice returns the address of the token used in the loan.
    /// @dev returns the address of the ERC20 Token used in the loan.
    function getTokenAddress() public view returns(address);

    /// @notice returns the address of the beneficiary of the loan.
    /// @dev returns the address of the beneficiary of the loan 'borrower'.
    function getBorrower() public view returns(address);

    /// @notice cancel the loan. (i.e. borrower Morty got the tokens from other source and doesn't needs Rick tokens, then Morty cancel the loan).
    /// @dev change the loan stage to canceled.
    function cancel() public returns (bool success);

    /// @notice trigger when the loan is available to be funded.
    /// @dev trigger when the loan change to stage Funding.
    /// @param token address of the token to be lend.
    /// @param borrower address where the loan is received.
    event Init(address indexed token, address indexed borrower);

    /// @notice trigger when cancel function is successfully called.
    /// @dev trigger when cancel function is successfully called.
    event Cancelled();

    /// @notice trigger when total payment paid by borrower is lower than the total amout to be paid and the time to paid the loan expire.
    /// @dev trigger when total payment paid by borrower is higher than the total amout to be paid and the time to paid the loan expire.
    /// @param due amount of tokens due.
    event Defaulted(uint256 indexed due);

    /// @notice trigger when total payment paid by borrower is higher than the total amout to be paid.
    /// @dev trigger when total payment paid by borrower is higher than the total amout to be paid.
    event Finished();

}
