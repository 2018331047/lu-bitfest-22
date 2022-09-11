import React from 'react'
import QueryCard from './QueryCard'
// import './QueryCardCollectionGen.css'


function QUeryCollectionAdv() {
 


  return (
    <div className='cards'>
        <h1>Administration</h1>
        <div className='cards__container'>
          <div className='cards__wrapper'>
            <ul className='cards__items'>
               
          
              <QueryCard hoverable
                src='./images/bus.png'
                text = 'Bus Inventory'
                onClick="console.log('The link was clicked.')"
                path ='/page'
                />
              
              <QueryCard src='images/route.jpg '
                text = "Create/Update Routes"
                path='/page'
                />
                
               
              <QueryCard src='images/buss.jpg'
                text = "Input Transport DemandS"
                //  label = "Click Here"
                 path='/page'
                /> 

            

            </ul>
          </div>
        </div>
    </div>
  )
}

export default QUeryCollectionAdv