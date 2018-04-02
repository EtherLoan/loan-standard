pragma solidity 0.4.19;

/// @title Loan Standard
/// @author anibal.catalan@consensys.net andres.junge@consensys.net
contract Loan {

    /// @notice funding the loan. (i.e. investors Rick send _capital Galactic Federation tokens to the contract, the contract transfers principal raised to borrower Morty, contract records Rick's ownership prorated by the amount each contributed).
    /// @dev needs the token ERC20 functions to use _capital. This function will trigger Contribute event.
    /// @param _capital is the amount of token to contribute.
    function fund(address _lender, uint256 _capital) public returns (bool success);

    /// @notice retire capital from the loan. (i.e. borrower Morty has already paid back his due and investor Rick withdraw his loot).
    /// @dev Needs the token ERC20 functions to transfer _capital to msg.sender. This function will trigger Withdraw event.
    /// @param _capital is the amount of token to retire.
    function withdraw(address _to, uint256 _capital) public returns (bool success);

    /// @notice the borrower accept loan termns and collect the capital. (i.e. the principal raised at the moment is X tokens and borrower Morty needs Y<X tokens, then Morty collect the principal raised and accept the loan terms).
    /// @dev change the loan stage to repayment.
    function accept() public returns (bool success);

    /// @notice pay back the due by borrower. (i.e. Morty send _payment Galactic Federation tokens to the contract, the contract distributes the _paymen to loan investors prorated by the amount each contributed).
    /// @dev Needs the token ERC20 functions to transfer _payment. This function will trigger PayBack event.
    /// @param _payment is the amount of token to payback.
    function payback(address _who, uint256 _payment) public returns (bool success);

    /// @notice return the loan current stage. (i.e. Summer wants contribute in Morty loan, but first need see if the loan is in funding stage).
    /// @dev return loan current stage.
    /// @return current stage
    function stage() public view returns (uint8);

    /// @notice trigger when contribute function is successfully called.
    /// @dev trigger when contribute function is successfully called.
    /// @param capital amount of token to contribute.
    event Funded(address indexed from, address indexed lender, uint256 capital);

    /// @notice trigger when withdraw function is successfully called.
    /// @dev trigger when withdraw function is successfully called.
    /// @param capital amount of token to retire.
    event Withdrawn(address indexed lender, address indexed receiver, uint256 capital);

    /// @notice trigger when collect function is successfully called.
    /// @dev trigger when collect function is successfully called.
    /// @param principal total amount lended.
    event Accepted(address borrower, uint256 principal, bytes32 terms);

    /// @notice trigger when payback function is successfully called.
    /// @dev trigger when payback function is successfully called.
    /// @param payment amount of token to repay.
    event Paid(address indexed from, address borrower, uint256 payment);

}
