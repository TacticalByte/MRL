import React from "react";
import IBaseProps from "./interfaces/IBaseProps";

const Base = (props: IBaseProps) => {
    return(
        <>
            {props.Navbar}
            {props.Body}
            {props.Footbar}
        </>
    )
}

export default Base;