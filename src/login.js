import React, { useCallback, useState, useEffect } from "react";
import { withRouter } from "react-router";
import Avatar from '@material-ui/core/Avatar';
import Button from '@material-ui/core/Button';
import CssBaseline from '@material-ui/core/CssBaseline';
import TextField from '@material-ui/core/TextField';
import Link from '@material-ui/core/Link';
import Box from '@material-ui/core/Box';
import LockOutlinedIcon from '@material-ui/icons/LockOutlined';
import Typography from '@material-ui/core/Typography';
import { makeStyles } from '@material-ui/core/styles';
import Container from '@material-ui/core/Container';
import Snackbar from '@material-ui/core/Snackbar';
import MuiAlert from '@material-ui/lab/Alert';
import { Grid } from '@material-ui/core'

import app from "./firebase";
// import { AuthContext } from "./components/Auth";

function Alert(props) {
    return <MuiAlert elevation={6} variant="filled" {...props} />;
}

function Copyright() {
    return (
        <Typography variant="body2" color="textSecondary" align="center">
            {'Copyright © '}
            <Link color="inherit" href="https://gymcall-9cbc4.web.app/">
                GymCall Admin
            </Link>{' '}
            {new Date().getFullYear()}
            {'.'}
        </Typography>
    );
}
 
const useStyles = makeStyles((theme) => ({
    root: {
        width: '100%',
        '& > * + *': {
          marginTop: theme.spacing(2),
        },
    },
    paper: {
        marginTop: theme.spacing(8),
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
    },
    avatar: {
        margin: theme.spacing(1),
        backgroundColor: theme.palette.secondary.main,
    },
    form: {
        width: '100%', // Fix IE 11 issue.
        marginTop: theme.spacing(1),
    },
    submit: {
        margin: theme.spacing(3, 0, 2),
    },
}));

function isEmailValid(str){
    return new RegExp(/[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,15}/g).test(str);
}

const Login = ({ history }) => {
    const classes = useStyles();
    const [open, setOpen] = useState(false);
    const [emailAddress, setEmail] = useState('');
    const [err, setError] = useState('Login was failed. Please try again.');

    const handleClose = (event, reason) => {
        if (reason === 'clickaway') {
            return;
        }
        setOpen(false);
    };

    const handleLogin = useCallback(
        async event => {
            event.preventDefault();
            setError('Login was failed. Please try again.');
            const { email, password } = event.target.elements;
            try {
                await app
                .auth()
                .signInWithEmailAndPassword(email.value, password.value);
                await app.firestore().collection('admin').doc('admin').get()
                .then(doc => {
                    if(doc.data().email === email.value){
                        history.push("/admin");
                    } else {
                        history.push("/");
                        setOpen(true);
                    }
                }).catch(error => {
                    setOpen(true);
                })
            } catch (error) {
                setOpen(true);
            }
        },
        [history]
    );

    function onSave() {
        if(emailAddress === '' || !isEmailValid(emailAddress)) {
            setError("Please enter your email address correctly.");
            setOpen(true);
            return;
        }

        app.auth().sendPasswordResetEmail(emailAddress)
        .then(() => {
            setError("Email has been sent to you, please check and verify.");
            setOpen(true);
        })
    }

//   const { currentUser } = useContext(AuthContext);

//   if (currentUser) {
//     return <Redirect to="/admin" />;
//   }

  return (
    <div>
        <Container component="main" maxWidth="xs">
            <CssBaseline />
            <div className={classes.root}>
                <Snackbar open={open} autoHideDuration={1500} onClose={handleClose}>
                    {
                        <Alert onClose={handleClose} severity="error">
                            { err }
                        </Alert>
                    }
                </Snackbar>
            </div>

            <div className={classes.paper}>
                <Avatar className={classes.avatar}>
                    <LockOutlinedIcon />
                </Avatar>
                <Typography component="h1" variant="h5">
                    Log In
                </Typography>
                <form className={classes.form} onSubmit={handleLogin} >
                    <TextField
                        variant="outlined"
                        margin="normal"
                        required
                        fullWidth
                        id = "email"
                        label = "Email Address"
                        name = "email"
                        type="email"
                        autoComplete = 'off'
                        value = { emailAddress }
                        onChange={e => setEmail(e.currentTarget.value)}
                        autoFocus
                    />
                
                    <TextField
                        variant="outlined"
                        margin="normal"
                        required
                        fullWidth
                        name="pass"
                        label="Password"
                        type="password"
                        id="password"
                        autoComplete = "off"
                    />
                    
                    <Button
                        type="submit"
                        fullWidth
                        variant="contained"
                        color="primary"
                        className={classes.submit}
                        // onClick={ handleButton }
                    >
                        Log In
                    </Button>
                    <Grid container>
                        <Grid item xs>
                            <Button color="primary" onClick={() => { onSave() }}>
                                Forgot password?
                            </Button>
                        </Grid>
                    </Grid>
                </form>
            </div>
            <Box mt={8}>
                <Copyright />
            </Box>
        </Container>
    </div>
  );
};

export default withRouter(Login);
