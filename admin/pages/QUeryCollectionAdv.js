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
                text = 'Add Or Edit Bus Info'
                onClick="console.log('The link was clicked.')"
                path ='/page'
                />
              
              <QueryCard src='images/route.jpg '
                text = "Add Or Edit Route Info"
                path='/page'
                />
                
               
              <QueryCard src='images/buss.jpg'
                text = "Add Or Edit demand Info"
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