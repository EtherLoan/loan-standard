<pre>
EIP: <to be assigned>
Title: ERC-<not assigned yet> Loan Standard
Author: Andres Junge <andres.junge@consensys.net>, Anibal Catalán <anibal.catalan@consensys.net>
Type: Standard
Category ERC
Status: Draft
Created: 
</pre>

## Simple Summary
A standard interface for loans. Tries to be as flexible as posible to allow different loan scenarios, p2p lending, crowdfunding, reverse dutch auction for interest and other to be came in the future.

## Abstract
The following standard allows for the implementation of a standard API for loans within smart contracts. This standard provides basic functionalities to fund loan, accept the raised amount, payback the due, and recover the investment by lenders. as well the loan contract can have diferent features so many of the features are optional, like interest, loan as token, collateral, review borrower behaivor, risk alasysis, etc.

## Motivation
This standard interface will allow the development of interoperable lending systems. dApp developers can build their solutions based on already deployed loan contracts. Posible solutions that will benefit of having a loan standard are: credit rating systems, curated loan markets and decentralized hedge funds.

## Definitions
* `msg.sender`: is always the address where the current (external) function call came from.
* `borrower`: entity that receive ERC-20 Tokens from `lenders` with the intention of giving it back after a period of time.
* `lender`: entity that contribute with ERC-20 Tokens to the `borrower` on condition of return. Can be one or many.
* `capital`: amount lended. The amount is represented as a balance of a ERC-20 Token.
* `payment`: amount repaid. The amount is represented as a balance of a ERC-20 Token.
* `principal`: amount collected. The amount is represented as a balance of a ERC-20 Token.
* `terms`: The temrs parameter was choosen to have the type `bytes32`. This in order to make the temrs entries as general as possible while maintaining a very simple code base.

## Specification

### Basic loan
The basic loan allows to register the most basic credit operation.

### Methods

#### getAmount
Returns the amount of the loan, the amount of ERC20 Tokens that the `borrower` is asking for.

OPTIONAL - This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present.

``` js
function getAmount() public view returns(uint256);
```

#### getTokenAddress
Returns the address of the ERC20 Token used in the loan.

OPTIONAL - This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present.

``` js
function getTokenAddress() public view returns(address);
```

#### getBorrower

Returns the address of the beneficiary of the loan (`borrower`).

OPTIONAL - This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present.

``` js
function getBorrower() public view returns(address);
```

#### getTerms

Returns the terms `bytes32` of the loan.

OPTIONAL - This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present.

``` js
function getTerms() public view returns(bytes32);
```

#### fund
the `msg.sender`, transfers `capital` amount of tokens to the smart contract, The `lender`, should be registered  with the capital added to the fund.

The variable `_lender` was added to differentiate between who transfers the tokens, and who can claim the tokens back.

The function SHOULD throw if the `msg.sender` account balance does not have enough tokens to spend or if `msg.sender `does not aprove that the smart contract can transfer the `capital`.

Note fund of 0 `capital` MUST be throw.

``` js
function fund(address _lender, uint256 _capital) public returns (bool success);
```

##### Triggers Event: Funded

#### withdraw
`lender`, the `msg.sender`, retire `capital`, tranfer tokens from the loan to the `msg.sender`.

The variable `_to` was added to differentiate between who can claim the tokens back, and where the tokens will going.

SHOULD throw if the `msg.sender` account balance does not have enough tokens to retire. the retire could means the amount payback by the borrower, or in some cases, the lender may regret his investment and retire that amount, only in funding stage.

Note withdraw of 0 `capital` MUST be throw.

``` js
function withdraw(address _to, uint256 _capital) public returns (bool success);
```

##### Triggers Event: Withdrawn

#### cancel
The `msg.sender`, cancel loan, the state of the loan change to cenceled.

SHOULD throw if the current stage of the loan is not funding.

OPTIONAL - This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present.

``` js
function cancel() public returns (bool success);
```

##### Triggers Event: Cancelled

#### accept
`borrower`, the `msg.sender`, collect the `principal` in the loan, the loan change his stage to paying.

when the `borrower` collects the `principal` implicitly accepts the `terms` of the loan.

Note collect of 0 `principal` MUST be throw.

``` js
function accept() public returns (bool success);
```
##### Triggers Event: Accepted

#### payback
The `msg.sender`, transfers `payment` amount of tokens to the smart contract, if the total amount paid by borrower is higher than the total amout to be paid, change the stage to finished.

The variable `_from` was added to differentiate between who transfers the tokens and the `borrower`.

Note payback of 0 `payment` MUST be throw.

``` js
function payback(address _from, uint256 _payment) public returns (bool successs);
```
##### Triggers Event: Paid

#### stage

Returns the stage of the loan -e.g. "2", the meaning of the number will depend on your implementation.

``` js
function stage() public view returns (uint8)
```

### Events

#### Begun

MUST be triggered when you set all the parameters and the loan is ready to start been fundable.

``` js
event Begun(address token, address borrower, uint256 requiredCapital);
```

OPTIONAL - This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present.

#### Funded

MUST be triggered when `fund` was succesfully called.

``` js
event Funded(address indexed from, address indexed lender, uint256 capital);
```

#### Withdrawn

MUST be triggered when `withdraw` was succesfully called.

``` js
event Withdrawn(address indexed lender, address indexed receiver, uint256 capital);
```

#### Cancelled

MUST be triggered when `cancel` was succesfully called.

OPTIONAL - This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present.

``` js
event Cancelled(address _who);;
```

#### Accepted
MUST be triggered when `collect` was succesfully called.

``` js
event Accepted(address borrower, uint256 principal, bytes32 terms);
```

#### Paid

MUST be triggered when `payback` was succesfully called.

``` js
event Paid(address indexed from, address borrower, uint256 payment);
```

#### Defaulted
MUST be triggered when the loan time end and the borrower still due tokens.

``` js
event Defaulted(address borrower, uint256 debt);
```
OPTIONAL - This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present.

#### Finished
MUST be triggered when when the loan time end and it is fully paid.

``` js
event Finished(address borrower);
```
OPTIONAL - This method can be used to improve usability, but interfaces and other contracts MUST NOT expect these values to be present.

## Implementation

### Interface Implementation

[Loan](https://github.com/EtherLoan/loan-standard/blob/master/contracts/standard/Loan.sol) just the obligatory functions.

[LoanBasic](https://github.com/EtherLoan/loan-standard/blob/master/contracts/standard/LoanBasic.sol) add optional functions.

### Logic Implementations

## Copyright
Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
