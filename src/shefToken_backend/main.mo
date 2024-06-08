import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Debug "mo:base/Debug";

actor Token{
  var owner :  Principal = Principal.fromText("yf6gs-xom45-fjxsm-6i3gc-ocukx-u44qv-wec23-qahsh-3sccd-fhlfc-vqe");
  var totalSupply: Nat = 1*10**9;
  var symbol : Text = "SHEF";

  var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);
  balances.put(owner, totalSupply);

  public query func balanceOf(who:Principal):async Nat{
    //this is how to handle optional value
    let balance : Nat = switch (balances.get(who)){
      case null 0;
      case(?result) result;
    };

    return balance;
  };

  public query func getSymbol():async Text{
    return symbol;
  };

  public shared(msg) func payOut():async Text {
    Debug.print(debug_show(msg.caller));
     Debug.print(debug_show(balances.get(msg.caller)));
    if(balances.get(msg.caller)==null){
      let amount = 10000;
      let result = await transfer(msg.caller, amount);
      return "Success";
    } else{
      return "Already claimed";
    }
  };

  public shared(msg) func transfer(to:Principal, amount:Nat):async Text{
    let fromBalance = await balanceOf(msg.caller);

    if(fromBalance > amount){
      let newFromBalance:Nat = fromBalance - amount;
      balances.put(msg.caller, newFromBalance);

      let toBalance = await balanceOf(to);
      let newToBalance = toBalance + amount;
      balances.put(to, newToBalance);

      return "Success";
    }else{
      return "insufficient funds";
    };
  }
};