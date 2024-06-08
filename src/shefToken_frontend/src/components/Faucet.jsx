import React, { useState } from "react";
import {shefToken_backend} from '../../../declarations/shefToken_backend'
function Faucet() {
  const [isDisabled, setDisabled] = useState(false);
  const [buttonText, setText] = useState("Gimme gimme");

  async function handleClick(event) {
    setDisabled(true);
    const result = await shefToken_backend.payOut();
    setText(result)
  }


  return (
    <div className="blue window">
      <h2>
        <span role="img" aria-label="tap emoji">
          🚰
        </span>
        Faucet
      </h2>
      <label>Get your free Shefer tokens here! Claim 10,000 SHEF tokens to your account.</label>
      <p className="trade-buttons">
        <button id="btn-payout" onClick={handleClick} disabled={isDisabled}>
         {buttonText}
        </button>
      </p>
    </div>
  );
}

export default Faucet;
