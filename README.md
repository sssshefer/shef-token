# Shef Token: A Simple Blockchain Token

## Table of Contents
- [Introduction](#introduction)
- [Theory Notes](#theory-notes)
  - [Internet Computer](#internet-computer)
  - [DFX](#dfx)
- [Features and Functionality](#features-and-functionality)
- [Implementation](#implementation)
  - [Backend Code](#backend-code)
  - [Frontend Code](#frontend-code)
- [Running the Project Locally](#running-the-project-locally)
- [Useful commands](#useful-commands)

## Introduction
Shef Token is a simple blockchain token created to learn and demonstrate the capabilities of the Internet Computer (IC) blockchain. This application implements a basic token system with functionalities such as checking balances, transferring tokens, and claiming initial payouts.

## Theory Notes

### Internet Computer
The Internet Computer is a blockchain that runs at web speed with unbounded capacity. It aims to extend the functionality of the public internet so that it can host backend software, transforming it into a global compute platform. Key features include:
- **Canisters**: Smart contracts on the Internet Computer that combine code and state.
- **Cycles**: The fuel that powers computation in the Internet Computer.
- **Motoko**: A programming language designed for the Internet Computer.

### DFX
DFX is the command-line tool used to manage, deploy, and interact with canisters on the Internet Computer. Key commands include:
- `dfx start`: Starts the local replica.
- `dfx new <project-name>`: Creates a new project.
- `dfx deploy`: Deploys the canisters.
- `dfx canister call <canister-name> <method-name>`: Calls a method on a canister.

To learn more before you start working with Shef Token, see the following documentation available online:
- [Quick Start](https://internetcomputer.org/docs/current/developer-docs/setup/deploy-locally)
- [SDK Developer Tools](https://internetcomputer.org/docs/current/developer-docs/setup/install)
- [Motoko Programming Language Guide](https://internetcomputer.org/docs/current/motoko/main/motoko)
- [Motoko Language Quick Reference](https://internetcomputer.org/docs/current/motoko/main/language-manual)

## Features and Functionality
- **Balance Inquiry**: Users can check their token balance.
- **Token Transfer**: Users can transfer tokens to another principal.
- **Claim Payout**: Users can claim an initial payout of tokens if they have not already done so.
- **Symbol Inquiry**: Users can get the token symbol.

## Implementation

### Backend Code
The backend canister is written in Motoko and manages the core token operations: balance inquiries, transfers, and initial payouts. 
>[!NOTE] 
> Hash data cannot be stored directly as a stable variable, which necessitates a different approach for persistence

The solution above demonstrates how to maintain data persistence in Motoko using a hash map to store token balances. The balances hash map, which records the token balances of different principals, is initially populated with the total supply assigned to the owner. To ensure persistence across canister upgrades, the code uses the preupgrade and postupgrade system functions. In preupgrade, the current entries of the balances hash map are converted to an array and stored in the balanceEntries stable variable because stable variables can persist across upgrades. After the upgrade, in postupgrade, the balances hash map is reconstructed from the balanceEntries array. This approach is a common solution for storing hash map data persistently, as it leverages arrays for stable storage while allowing the efficient retrieval and management of data with hash maps. This method ensures that token balance data is not lost during canister upgrades, maintaining the integrity and continuity of the token ledger

### Frontend Code
The frontend is implemented using React and handles user interactions and authentication.

The frontend code initializes an authentication client using `AuthClient` from the `@dfinity/auth-client` package. It checks if the user is authenticated and prompts them to log in via Internet Identity if not. Once authenticated, it renders the main `App` component.

### Design
 The design is inspired by https://classic.curve.fi/ website
 
## Running the Project Locally
If you want to test your project locally, you can use the following commands:

- **Starts the replica, running in the background**
```bash
dfx start --background
```

- **Deploys your canisters to the replica and generates your candid interface**
```bash
dfx deploy
```

- **Start a development server with**
```bash
npm start
```
Which will start a server at `http://localhost:8080`, proxying API requests to the replica at port 4943.
## Useful commands

- **Find out your principal id:**
```
dfx identity get-principal
```

- **Check canister ID:**
```
dfx canister id token
```
Once the job completes, your application will be available at `http://localhost:4943?canisterId={asset_canister_id}`.

- **If you have made changes to your backend canister, you can generate a new candid interface with**
```bash
npm run generate
```
at any time. This is recommended before starting the frontend development server, and will be run automatically any time you run `dfx deploy`
