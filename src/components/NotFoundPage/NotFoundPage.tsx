import React from "react";
import { Link } from "react-router-dom";

import notFound from "../Assets/img/notFound.png"

import styles from "./NotFoundPage.module.scss"

const NotFoundPage = () => {
    return(
        <div className={styles.notFoundContainer}>
            <img src={notFound} alt="" />
            <br />
            Page not Found!
            <br />
            <Link to="/">Go to the home page</Link>
        </div>
    )
    
    
}

export default NotFoundPage;