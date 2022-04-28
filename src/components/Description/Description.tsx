import React from "react";

import polygonLogo from "../Assets/img/polygonLogo.svg"

import styles from "./Description.module.scss"

const Description = () => {
    return(
        <div className={styles.descriptionContainer}>
            <div className={styles.text}>
                <img src={polygonLogo} width="100px" alt="" />
                <h1>Crypto Pay</h1>
                <p>A single payment system built on the polygon blockchain.</p>
            </div>
        </div>
    )
    
    
}

export default Description;