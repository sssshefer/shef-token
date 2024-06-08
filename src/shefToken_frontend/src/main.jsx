import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './components/App';
import './index.scss';
import {AuthClient} from "@dfinity/auth-client";


const authClient = await AuthClient.create();

if(await authClient.isAuthenticated()){
    handleAuthentication(authClient)
}else{
    const proceedToLogin = confirm("Do you want to log in? \nClick 'OK' to proceed to Internet Identity log in page");
    if(proceedToLogin){
        await authClient.login({
            onSuccess:()=> handleAuthentication(authClient)
        }
    )}else{
    handleAuthentication(authClient)
    }
}
async function handleAuthentication(authClient){
    ReactDOM.createRoot(document.getElementById('root')).render(
        <App />
    );
}



