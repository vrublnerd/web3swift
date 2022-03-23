//
//  web3swiftHelpers.swift
//  Tests
//
//  Created by Anton Grigorev on 30.07.2021.
//  Copyright © 2021 Anton Grigorev. All rights reserved.
//

import Foundation
import BigInt

import web3swift

class web3swiftHelpers {
    static func localDeployERC20() throws -> (web3, TransactionSendingResult, TransactionReceipt, String) {
        let abiString = "[{\"inputs\":[{\"internalType\":\"string\",\"name\":\"name_\",\"type\":\"string\"},{\"internalType\":\"string\",\"name\":\"symbol_\",\"type\":\"string\"},{\"internalType\":\"address\",\"name\":\"mintRecipient\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"mintAmount\",\"type\":\"uint256\"}],\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internalType\":\"address\",\"name\":\"owner\",\"type\":\"address\"},{\"indexed\":true,\"internalType\":\"address\",\"name\":\"spender\",\"type\":\"address\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"Approval\",\"type\":\"event\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"spender\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"amount\",\"type\":\"uint256\"}],\"name\":\"approve\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"spender\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"subtractedValue\",\"type\":\"uint256\"}],\"name\":\"decreaseAllowance\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"spender\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"addedValue\",\"type\":\"uint256\"}],\"name\":\"increaseAllowance\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"to\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"amount\",\"type\":\"uint256\"}],\"name\":\"mint\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"recipient\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"amount\",\"type\":\"uint256\"}],\"name\":\"transfer\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"internalType\":\"address\",\"name\":\"from\",\"type\":\"address\"},{\"indexed\":true,\"internalType\":\"address\",\"name\":\"to\",\"type\":\"address\"},{\"indexed\":false,\"internalType\":\"uint256\",\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"Transfer\",\"type\":\"event\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"sender\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"recipient\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"amount\",\"type\":\"uint256\"}],\"name\":\"transferFrom\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"to\",\"type\":\"address\"}],\"name\":\"transferOwnership\",\"outputs\":[],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"owner\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"spender\",\"type\":\"address\"}],\"name\":\"allowance\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"account\",\"type\":\"address\"}],\"name\":\"balanceOf\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"decimals\",\"outputs\":[{\"internalType\":\"uint8\",\"name\":\"\",\"type\":\"uint8\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"name\",\"outputs\":[{\"internalType\":\"string\",\"name\":\"\",\"type\":\"string\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"symbol\",\"outputs\":[{\"internalType\":\"string\",\"name\":\"\",\"type\":\"string\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"totalSupply\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"}]"
        let bytecode = Data.fromHex("60806040523480156200001157600080fd5b5060405162001f0c38038062001f0c8339818101604052810190620000379190620003af565b83600490805190602001906200004f9291906200025f565b508260059080519060200190620000689291906200025f565b5033600360006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff160217905550600073ffffffffffffffffffffffffffffffffffffffff168273ffffffffffffffffffffffffffffffffffffffff16146200012b576000811162000125576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016200011c90620004ce565b60405180910390fd5b620001aa565b6000811115620001a957600073ffffffffffffffffffffffffffffffffffffffff168273ffffffffffffffffffffffffffffffffffffffff161415620001a8576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016200019f90620004ac565b60405180910390fd5b5b5b806000808473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020819055508173ffffffffffffffffffffffffffffffffffffffff16600073ffffffffffffffffffffffffffffffffffffffff167fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef836040516200024d9190620004f0565b60405180910390a3505050506200079e565b8280546200026d90620005f1565b90600052602060002090601f016020900481019282620002915760008555620002dd565b82601f10620002ac57805160ff1916838001178555620002dd565b82800160010185558215620002dd579182015b82811115620002dc578251825591602001919060010190620002bf565b5b509050620002ec9190620002f0565b5090565b5b808211156200030b576000816000905550600101620002f1565b5090565b600062000326620003208462000536565b6200050d565b9050828152602081018484840111156200033f57600080fd5b6200034c848285620005bb565b509392505050565b60008151905062000365816200076a565b92915050565b600082601f8301126200037d57600080fd5b81516200038f8482602086016200030f565b91505092915050565b600081519050620003a98162000784565b92915050565b60008060008060808587031215620003c657600080fd5b600085015167ffffffffffffffff811115620003e157600080fd5b620003ef878288016200036b565b945050602085015167ffffffffffffffff8111156200040d57600080fd5b6200041b878288016200036b565b93505060406200042e8782880162000354565b9250506060620004418782880162000398565b91505092959194509250565b60006200045c6037836200056c565b91506200046982620006cc565b604082019050919050565b600062000483602e836200056c565b915062000490826200071b565b604082019050919050565b620004a681620005b1565b82525050565b60006020820190508181036000830152620004c7816200044d565b9050919050565b60006020820190508181036000830152620004e98162000474565b9050919050565b60006020820190506200050760008301846200049b565b92915050565b6000620005196200052c565b905062000527828262000627565b919050565b6000604051905090565b600067ffffffffffffffff8211156200055457620005536200068c565b5b6200055f82620006bb565b9050602081019050919050565b600082825260208201905092915050565b60006200058a8262000591565b9050919050565b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b6000819050919050565b60005b83811015620005db578082015181840152602081019050620005be565b83811115620005eb576000848401525b50505050565b600060028204905060018216806200060a57607f821691505b602082108114156200062157620006206200065d565b5b50919050565b6200063282620006bb565b810181811067ffffffffffffffff821117156200065457620006536200068c565b5b80604052505050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052602260045260246000fd5b7f4e487b7100000000000000000000000000000000000000000000000000000000600052604160045260246000fd5b6000601f19601f8301169050919050565b7f45524332303a206d696e7420726563697069656e7420697320656d7074792c2060008201527f627574206d696e7420616d6f756e742069736e27742030000000000000000000602082015250565b7f45524332303a206d696e7420616d6f756e74206973203020746f206e6f6e2d6560008201527f6d70747920726563697069656e74000000000000000000000000000000000000602082015250565b62000775816200057d565b81146200078157600080fd5b50565b6200078f81620005b1565b81146200079b57600080fd5b50565b61175e80620007ae6000396000f3fe608060405234801561001057600080fd5b50600436106100cf5760003560e01c806340c10f191161008c578063a457c2d711610066578063a457c2d714610228578063a9059cbb14610258578063dd62ed3e14610288578063f2fde38b146102b8576100cf565b806340c10f19146101be57806370a08231146101da57806395d89b411461020a576100cf565b806306fdde03146100d4578063095ea7b3146100f257806318160ddd1461012257806323b872dd14610140578063313ce56714610170578063395093511461018e575b600080fd5b6100dc6102d4565b6040516100e9919061116c565b60405180910390f35b61010c60048036038101906101079190610f74565b610366565b6040516101199190611151565b60405180910390f35b61012a610384565b60405161013791906112ae565b60405180910390f35b61015a60048036038101906101559190610f25565b61038e565b6040516101679190611151565b60405180910390f35b610178610486565b60405161018591906112c9565b60405180910390f35b6101a860048036038101906101a39190610f74565b61048f565b6040516101b59190611151565b60405180910390f35b6101d860048036038101906101d39190610f74565b61053b565b005b6101f460048036038101906101ef9190610ec0565b6106fa565b60405161020191906112ae565b60405180910390f35b610212610742565b60405161021f919061116c565b60405180910390f35b610242600480360381019061023d9190610f74565b6107d4565b60405161024f9190611151565b60405180910390f35b610272600480360381019061026d9190610f74565b6108bf565b60405161027f9190611151565b60405180910390f35b6102a2600480360381019061029d9190610ee9565b6108dd565b6040516102af91906112ae565b60405180910390f35b6102d260048036038101906102cd9190610ec0565b610964565b005b6060600480546102e3906113de565b80601f016020809104026020016040519081016040528092919081815260200182805461030f906113de565b801561035c5780601f106103315761010080835404028352916020019161035c565b820191906000526020600020905b81548152906001019060200180831161033f57829003601f168201915b5050505050905090565b600061037a610373610a38565b8484610a40565b6001905092915050565b6000600254905090565b600061039b848484610c0b565b6000600160008673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060006103e6610a38565b73ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002054905082811015610466576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161045d9061120e565b60405180910390fd5b61047a85610472610a38565b858403610a40565b60019150509392505050565b60006012905090565b600061053161049c610a38565b8484600160006104aa610a38565b73ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060008873ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000205461052c9190611300565b610a40565b6001905092915050565b600360009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff16146105cb576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016105c2906111ee565b60405180910390fd5b600073ffffffffffffffffffffffffffffffffffffffff168273ffffffffffffffffffffffffffffffffffffffff16141561063b576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016106329061128e565b60405180910390fd5b806000808473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060008282546106899190611300565b925050819055508173ffffffffffffffffffffffffffffffffffffffff16600073ffffffffffffffffffffffffffffffffffffffff167fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef836040516106ee91906112ae565b60405180910390a35050565b60008060008373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020549050919050565b606060058054610751906113de565b80601f016020809104026020016040519081016040528092919081815260200182805461077d906113de565b80156107ca5780601f1061079f576101008083540402835291602001916107ca565b820191906000526020600020905b8154815290600101906020018083116107ad57829003601f168201915b5050505050905090565b600080600160006107e3610a38565b73ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060008573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020549050828110156108a0576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016108979061126e565b60405180910390fd5b6108b46108ab610a38565b85858403610a40565b600191505092915050565b60006108d36108cc610a38565b8484610c0b565b6001905092915050565b6000600160008473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060008373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002054905092915050565b600360009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff16146109f4576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016109eb906111ee565b60405180910390fd5b80600360006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555050565b600033905090565b600073ffffffffffffffffffffffffffffffffffffffff168373ffffffffffffffffffffffffffffffffffffffff161415610ab0576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610aa79061124e565b60405180910390fd5b600073ffffffffffffffffffffffffffffffffffffffff168273ffffffffffffffffffffffffffffffffffffffff161415610b20576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610b17906111ae565b60405180910390fd5b80600160008573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002060008473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020819055508173ffffffffffffffffffffffffffffffffffffffff168373ffffffffffffffffffffffffffffffffffffffff167f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b92583604051610bfe91906112ae565b60405180910390a3505050565b600073ffffffffffffffffffffffffffffffffffffffff168373ffffffffffffffffffffffffffffffffffffffff161415610c7b576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610c729061122e565b60405180910390fd5b600073ffffffffffffffffffffffffffffffffffffffff168273ffffffffffffffffffffffffffffffffffffffff161415610ceb576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610ce29061118e565b60405180910390fd5b610cf6838383610e8c565b60008060008573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002054905081811015610d7c576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610d73906111ce565b60405180910390fd5b8181036000808673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002081905550816000808573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000206000828254610e0f9190611300565b925050819055508273ffffffffffffffffffffffffffffffffffffffff168473ffffffffffffffffffffffffffffffffffffffff167fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef84604051610e7391906112ae565b60405180910390a3610e86848484610e91565b50505050565b505050565b505050565b600081359050610ea5816116fa565b92915050565b600081359050610eba81611711565b92915050565b600060208284031215610ed257600080fd5b6000610ee084828501610e96565b91505092915050565b60008060408385031215610efc57600080fd5b6000610f0a85828601610e96565b9250506020610f1b85828601610e96565b9150509250929050565b600080600060608486031215610f3a57600080fd5b6000610f4886828701610e96565b9350506020610f5986828701610e96565b9250506040610f6a86828701610eab565b9150509250925092565b60008060408385031215610f8757600080fd5b6000610f9585828601610e96565b9250506020610fa685828601610eab565b9150509250929050565b610fb981611368565b82525050565b6000610fca826112e4565b610fd481856112ef565b9350610fe48185602086016113ab565b610fed8161146e565b840191505092915050565b60006110056023836112ef565b91506110108261147f565b604082019050919050565b60006110286022836112ef565b9150611033826114ce565b604082019050919050565b600061104b6026836112ef565b91506110568261151d565b604082019050919050565b600061106e6010836112ef565b91506110798261156c565b602082019050919050565b60006110916028836112ef565b915061109c82611595565b604082019050919050565b60006110b46025836112ef565b91506110bf826115e4565b604082019050919050565b60006110d76024836112ef565b91506110e282611633565b604082019050919050565b60006110fa6025836112ef565b915061110582611682565b604082019050919050565b600061111d601f836112ef565b9150611128826116d1565b602082019050919050565b61113c81611394565b82525050565b61114b8161139e565b82525050565b60006020820190506111666000830184610fb0565b92915050565b600060208201905081810360008301526111868184610fbf565b905092915050565b600060208201905081810360008301526111a781610ff8565b9050919050565b600060208201905081810360008301526111c78161101b565b9050919050565b600060208201905081810360008301526111e78161103e565b9050919050565b6000602082019050818103600083015261120781611061565b9050919050565b6000602082019050818103600083015261122781611084565b9050919050565b60006020820190508181036000830152611247816110a7565b9050919050565b60006020820190508181036000830152611267816110ca565b9050919050565b60006020820190508181036000830152611287816110ed565b9050919050565b600060208201905081810360008301526112a781611110565b9050919050565b60006020820190506112c36000830184611133565b92915050565b60006020820190506112de6000830184611142565b92915050565b600081519050919050565b600082825260208201905092915050565b600061130b82611394565b915061131683611394565b9250827fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0382111561134b5761134a611410565b5b828201905092915050565b600061136182611374565b9050919050565b60008115159050919050565b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b6000819050919050565b600060ff82169050919050565b60005b838110156113c95780820151818401526020810190506113ae565b838111156113d8576000848401525b50505050565b600060028204905060018216806113f657607f821691505b6020821081141561140a5761140961143f565b5b50919050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052601160045260246000fd5b7f4e487b7100000000000000000000000000000000000000000000000000000000600052602260045260246000fd5b6000601f19601f8301169050919050565b7f45524332303a207472616e7366657220746f20746865207a65726f206164647260008201527f6573730000000000000000000000000000000000000000000000000000000000602082015250565b7f45524332303a20617070726f766520746f20746865207a65726f20616464726560008201527f7373000000000000000000000000000000000000000000000000000000000000602082015250565b7f45524332303a207472616e7366657220616d6f756e742065786365656473206260008201527f616c616e63650000000000000000000000000000000000000000000000000000602082015250565b7f45524332303a204e6f74206f776e657200000000000000000000000000000000600082015250565b7f45524332303a207472616e7366657220616d6f756e742065786365656473206160008201527f6c6c6f77616e6365000000000000000000000000000000000000000000000000602082015250565b7f45524332303a207472616e736665722066726f6d20746865207a65726f20616460008201527f6472657373000000000000000000000000000000000000000000000000000000602082015250565b7f45524332303a20617070726f76652066726f6d20746865207a65726f2061646460008201527f7265737300000000000000000000000000000000000000000000000000000000602082015250565b7f45524332303a2064656372656173656420616c6c6f77616e63652062656c6f7760008201527f207a65726f000000000000000000000000000000000000000000000000000000602082015250565b7f45524332303a206d696e7420746f20746865207a65726f206164647265737300600082015250565b61170381611356565b811461170e57600080fd5b50565b61171a81611394565b811461172557600080fd5b5056fea2646970667358221220b6ac3a3baa1a92f9f5628a993657177a7d65adf57696ee461d89686f85a28d6164736f6c63430008040033")!
        
        let web3 = try Web3.new(URL.init(string: "http://127.0.0.1:8545")!)
        let allAddresses = try web3.eth.getAccounts()
        let contract = web3.contract(abiString, at: nil, abiVersion: 2)!
        
        let parameters = [
            "web3swift",
            "w3s",
            EthereumAddress("0xe22b8979739D724343bd002F9f432F5990879901")!,
            1024
        ] as [AnyObject]
        let deployTx = contract.deploy(bytecode: bytecode, parameters: parameters)!
        deployTx.transactionOptions.from = allAddresses[0]
        deployTx.transactionOptions.gasLimit = .manual(3000000)
        let result = try deployTx.sendPromise().wait()
        let txHash = result.hash
        print("Transaction with hash " + txHash)
        
        Thread.sleep(forTimeInterval: 1.0)
        
        let receipt = try web3.eth.getTransactionReceipt(txHash)
        print(receipt)
        
        switch receipt.status {
        case .notYetProcessed:
            throw Web3Error.processingError(desc: "Transaction is unprocessed")
        default:
            break
        }
        
        return (web3, result, receipt, abiString)
    }
}