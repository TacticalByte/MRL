import React, { useEffect } from 'react'; 
import FacebookIcon from '../media/images/icons/FACEBOOK.png';
import YoutubeIcon from '../media/images/icons/YOUTUBE.jpg';
import DiscordIcon from '../media/images/icons/DISCORD.png';
import '../styles/css/footer.css';

const Footer = () => {
    const GetCopyrigthMessage = () => {
        let div: HTMLDivElement | null = document.getElementById('divCopyright') as HTMLDivElement;
        div.innerText = `©  ${new Date().getFullYear()} SMC LATINOAMERICA`;
    }

    useEffect(() => {
        GetCopyrigthMessage();
        document.title = 'MRL - Welcome';
    })

    return(
        <>
            <div className='footer-base-container'>
                <div className='footer-icons-container'>
                    <a href='www.google.com.sv'><img src={FacebookIcon} className='footer-icon-style'/></a>
                    <a href='www.google.com.sv'><img src={YoutubeIcon} className='footer-icon-style'/></a>
                    <a href='www.google.com.sv'><img src={DiscordIcon} className='footer-icon-style'/></a>
                </div>
                <div className='footer-text-container'>
                    <div id='divCopyright'></div>
                </div>
            </div>
        </>
        )
    }
    
    export default Footer;