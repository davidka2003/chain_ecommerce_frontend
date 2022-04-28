import React from "react";
import logoImage from "../Assets/img/logo.svg"
import {Menu} from "./menu"
import {Link} from 'react-router-dom'

import styles from "./Header.module.scss"

// import connButtonText from "./Dashboard.jsx"
// import connectWalletHandler from "./Dashboard.jsx"

const Header = () => {
    return(
        <div className={styles.header}>
            <div className={styles.logo}>
                <img src={logoImage} height='50px' alt="" />
            </div>
            <div className={styles.wrapper}>
                <ul className={styles.menu}>
                    {Menu.map((item, idx) => (
                        <li key={`item ${idx}`}>
                            <Link to={item.link}>{item.tittle}</Link>
                        </li>
                    ))}
                    <li><a href=" "></a></li>
                </ul>
                {/* <div className={styles.authButtons}>
                    <button className={styles.connectButton}>Connect</button>
                    <button className={styles.connectButton} onClick={connectWalletHandler}>{connButtonText}</button>
                </div> */}
            </div>


        </div>
    )
    
    
}

export default Header;