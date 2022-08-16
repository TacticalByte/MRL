import React from "react";
import { BrowserRouter, Route } from "react-router-dom";
import Welcome from "../views/Welcome";

const UserRouter = () => {
    return(
        <BrowserRouter>
            <Route path="/" element={<Welcome/>} />
        </BrowserRouter>
    )
}

export default UserRouter;