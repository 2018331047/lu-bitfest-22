import React from "react";
import QueryCard from "./QueryCard";
// import './QueryCardCollectionGen.css'

function QUeryCollectionAdv() {
  return (
    <div className="cards">
      <h1>Administration</h1>
      <div className="cards__container">
        <div className="cards__wrapper">
          <ul className="cards__items">
            <QueryCard
              hoverable
              src="./images/bus.png"
              text="Bus Inventory"
              onClick="console.log('The link was clicked.')"
              path="/admin/bus-inventory"
            />

            <QueryCard
              src="images/route.jpg "
              text="Routes"
              path="/admin/routes"
            />

            <QueryCard
              src="images/buss.jpg"
              text="Transport demand"
              //  label = "Click Here"
              path="/admin/transport-demand"
            />
          </ul>
        </div>
      </div>
    </div>
  );
}

export default QUeryCollectionAdv;
