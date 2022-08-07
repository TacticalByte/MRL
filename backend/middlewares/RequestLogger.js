const RequestLogger = (req,res,next) => {
    const today = new Date();
    const todaystr = `${today.toLocaleDateString('en-US')} ${today.toLocaleTimeString('en-US',{hour12:false, hour:'2-digit', minute:'2-digit', second:'2-digit'})}`;
    console.log(`${todaystr} || ${req.method} => ${req.url}`);
    next();
}

module.exports = RequestLogger;