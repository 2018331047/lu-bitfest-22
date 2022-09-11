import React from 'react'
import Link from 'next/link'
import Image from 'next/image'


function QueryCard(props) {
  return (
    <>
    <Link href={props.path} passHref>
        <li className='cards__item'>
        {/* <Link href={props.path} passHref> */}
            <figure className='cards__item__pic-wrap'
            data-category={props.label}>
                <img src={props.src} alt = "Query"
                className='cards__item__img'/>
            </figure>
            {/* </Link> */}
            <div className='cards__item__info'>
                <h5 className='cards__item__text'>{props.text}</h5>
            </div>
        </li>
        </Link>
    </>
  )
}

export default QueryCard