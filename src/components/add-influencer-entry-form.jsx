import React, {useState} from 'react'
import TextField from '@material-ui/core/TextField';
import { makeStyles } from '@material-ui/core/styles';
import Button from '@material-ui/core/Button';
import Snackbar from '@material-ui/core/Snackbar';
import MuiAlert from '@material-ui/lab/Alert';
import { Grid } from '@material-ui/core'

import firebase from '../firebase'
;

const useStyles = makeStyles((theme) => ({
    formControl: {
      minWidth: 120,
      width: '100%',
      fullWidth: true,
    },
    formStyle: {
      marginBottom: theme.spacing(2),
    },
}));

function Alert(props) {
    return <MuiAlert elevation={6} variant="filled" {...props} />;
}



function isUrlValid(userInput) {
    // let pat = /^https?:\/\//i;
    // if (pat.test(userInput)){
    //     let res = userInput.match(/(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/g);
    //     if(res == null)
    //         return false;
    //     else
    //         return true;
    // } else {
    //     return false;
    // }
    // let validUrl = require('valid-url');
  
    // if (validUrl.isUri(userInput)){
    //     return true;
    // } else {
    //     return false;
    // }

    try{
        new URL(userInput);
        return true;
    } catch(err){
        return false;
    }
}

function isEmailValid(str){
    return new RegExp(/[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,15}/g).test(str);
}


const AddInfluencerEntryForm = () => {

    const [name, setName] = useState('');
    const [instaUrl, setInstaUrl] = useState('');
    const [ytbUrl, setYtbUrl] = useState('');
    const [email, setEmail] = useState('');
  
    const [open, setOpen] = useState(false);
    const [openType, setOpenType] = useState("error");
    const [openText, setOpenText] = useState("");

    const classes = useStyles();

    const handleClose = (event, reason) => {
        if (reason === 'clickaway') {
            return;
        }
        setOpen(false);
    };

    function onSave() {
        if(name === '') {
            setOpenType("error");
            setOpenText("Please input the influencer name.");
            setOpen(true);
            return;
        }

        if(!isUrlValid(instaUrl) && instaUrl !== "") {
            setOpenType("error");
            setOpenText("Please input the instagram link correctly.");
            setOpen(true);
            return;
        }

        if(!isUrlValid(ytbUrl) && ytbUrl !== "") {
            setOpenType("error");
            setOpenText("Please input the youtube link correctly.");
            setOpen(true);
            return;
        }

        if(!isEmailValid(email)) {
            setOpenType("error");
            setOpenText("Please input email address correctly.");
            setOpen(true);
            return;
        }
        
        firebase.firestore().collection("influencers").add(
            {
              name: name,
              instagram: instaUrl,
              youtube: ytbUrl,
              email: email
            } 
        ).then(() => {
            setName('')
            setInstaUrl('')
            setYtbUrl('')
            setEmail('')
        })
    }

    return(
        <div className={classes.formStyle} >
            <div className={classes.snackroot}>
                <Snackbar open={open} autoHideDuration={1500} onClose={handleClose}>
                    {
                        <Alert onClose={handleClose} severity={openType}>
                            {openText}
                        </Alert>
                    }
                </Snackbar>
            </div>
            <div>
                <Grid container spacing={3} >
                    <Grid item xs={1}></Grid>
                    <Grid item xs={2}>
                        <TextField
                            id="outlined-textarea"
                            label="Influencer Name"
                            variant="outlined"
                            autoComplete = 'off'
                            value = { name }
                            onChange={e => setName(e.currentTarget.value)}
                        />
                    </Grid>

                    <Grid item xs={2}> 
                        <TextField
                            error = { !isUrlValid(instaUrl) && instaUrl !== "" }
                            id="outlined-textarea"
                            label="Instagram Link"
                            variant="outlined"
                            autoComplete = 'off'
                            value = { instaUrl}
                            onChange={e => setInstaUrl(e.currentTarget.value)}
                        />
                    </Grid>

                    <Grid item xs={2}>
                        <TextField
                            error = { !isUrlValid(ytbUrl) && ytbUrl !== "" }
                            id="outlined-textarea"
                            label="Youtube Link"
                            placeholder="Please enter youtube url."
                            variant="outlined"
                            autoComplete = 'off'
                            value = { ytbUrl }
                            onChange={e => setYtbUrl(e.currentTarget.value)}
                        />
                    </Grid>
                    <Grid item xs={2}>
                        <TextField
                            error = { !isEmailValid(email) && email !== "" }
                            id="outlined-textarea"
                            label="Email Address"
                            placeholder="Please enter email address."
                            variant="outlined"
                            autoComplete = 'off'
                            value = { email }
                            onChange={e => setEmail(e.currentTarget.value)}
                        />
                    </Grid>
                    <Grid item xs={2}>
                        <Button variant="outlined" color="primary" onClick={() => { onSave() }}>
                            Add
                        </Button> 
                    </Grid>
                    <Grid item xs={1}></Grid>
                </Grid>
            </div>
        </div>
    )
}

export default AddInfluencerEntryForm