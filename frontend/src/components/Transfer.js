import React from "react";

export function Transfer({ transferTokens }) {
  return (
    <div>
      <h4>Become King</h4>
      <form
        onSubmit={(event) => {
          // This function just calls the transferTokens callback with the
          // form's data.
          event.preventDefault();

          const formData = new FormData(event.target);
          // const to = formData.get("to");
          const amount = formData.get("amount");

          if (amount) {
            transferTokens( amount);
          }
        }}
      >
        <div className="form-group">
          <label>Amount to deposit</label>
          <input
            className="form-control"
            type="number"
            step="0.000001"
            name="amount"
            placeholder=""
            required
          />
        </div>
        {/* <div className="form-group">
          <label>Deposit in ETH or USDC</label>
          <input className="form-control" type="text" name="to" required />
        </div> */}
        <div className="form-group">
          <input className="btn btn-primary" type="submit" value="Transfer" />
        </div>
      </form>
    </div>
  );
}
