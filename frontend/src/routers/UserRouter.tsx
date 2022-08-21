import React from "react";
import { BrowserRouter, Route } from "react-router-dom";
import Navbar from "../components/Navbar";
import Base from "../views/Base";

const UserRouter = () => {
    return(
        <BrowserRouter>
            <Route path="/" element={
                <Base 
                    Navbar= {<Navbar/>}
                    Body = {null}
                    Footbar = {null}
                    />
                } />
        </BrowserRouter>
    )
}

export default UserRouter;