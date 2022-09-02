import React from "react";
import LOGO from "../media/images/icons/mrl.png";
import MENU from "../media/images/icons/MENU.png";
import "../styles/css/navbar.css";

const Navbar = () => {
    return(
        <nav>
            <div>
                <a href='www.google.com.sv'><img src={LOGO} className='nav-main-logo'/></a>
            </div>
            <div className='nav-container-menu'>
                <a href='www.google.com.sv' className="selected">Inicio</a>
                <a href='www.google.com.sv'>Lobby League</a>
                <a href='www.google.com.sv'>Menu GlobalMap</a>
                <a href='www.google.com.sv'>Wall Of Honor</a>
            </div>
            <div>
                <a href='www.google.com.sv' className="selected">Login</a>
                <a href='www.google.com.sv'>Register</a>
            </div>
            <div>
                <a href="www.google.com.sv"><img src={MENU} className='nav-main-logo' /></a>
            </div>
        </nav>
    )
}

export default Navbar;