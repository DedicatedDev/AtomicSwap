import React, { useState, useEffect } from "react";
import TextField from "@material-ui/core/TextField";
import { makeStyles } from "@material-ui/core/styles";
import InputLabel from "@material-ui/core/InputLabel";
import MenuItem from "@material-ui/core/MenuItem";
import FormControl from "@material-ui/core/FormControl";
import Select from "@material-ui/core/Select";
import Button from "@material-ui/core/Button";
import Snackbar from "@material-ui/core/Snackbar";
import MuiAlert from "@material-ui/lab/Alert";
import { Grid } from "@material-ui/core";

import firebase from "../firebase";
const useStyles = makeStyles((theme) => ({
  formControl: {
    minWidth: 120,
    width: "100%",
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

  try {
    new URL(userInput);
    return true;
  } catch (err) {
    return false;
  }
}

function useInfluencers() {
  const [influencers, setInfluencers] = useState([]);

  useEffect(() => {
    const unsubscribe = firebase
      .firestore()
      .collection("influencers")
      // .orderBy(SORT_OPTIONS[sortBy].column, SORT_OPTIONS[sortBy].direction)
      .onSnapshot((snapshot) => {
        const newInfluencers = snapshot.docs.map((doc) => ({
          id: doc.id,
          ...doc.data(),
        }));

        setInfluencers(newInfluencers);
      });

    return () => unsubscribe();
  }, []);

  return influencers;
}

const AddVideoEntryForm = () => {
  const [name, setName] = useState("");
  const [category, setCategory] = useState("");
  const [url, setUrl] = useState("");
  const [time, setTime] = useState("");
  const [description, setDescription] = useState("");
  const [open, setOpen] = useState(false);
  const [openType, setOpenType] = useState("error");
  const [openText, setOpenText] = useState("");

  const classes = useStyles();
  const handleChangeCategory = (event) => {
    setCategory(event.target.value);
  };

  const handleChangeTime = (event) => {
    setTime(event.target.value);
  };

  const handleClose = (event, reason) => {
    if (reason === "clickaway") {
      return;
    }
    setOpen(false);
  };

  function onSave() {
    if (name === "") {
      setOpenType("error");
      setOpenText("Please select the influencer.");
      setOpen(true);
      return;
    }

    if (category === "") {
      setOpenType("error");
      setOpenText("Please select the category.");
      setOpen(true);
      return;
    }

    if (time === "") {
      setOpenType("error");
      setOpenText("Please select the exercise time.");
      setOpen(true);
      return;
    }

    if (!isUrlValid(url)) {
      setOpenType("error");
      setOpenText("Please input the url correctly.");
      setOpen(true);
      return;
    }

    firebase
      .firestore()
      .collection("videos")
      .add({
        influencer: name,
        category: category,
        url: url,
        time: time,
        description: description,
      })
      .then(() => {
        setUrl("");
        setDescription("");
      });
  }

  return (
    <form className={classes.formStyle}>
      <div className={classes.snackroot}>
        <Snackbar open={open} autoHideDuration={1500} onClose={handleClose}>
          {
            <Alert onClose={handleClose} severity={openType}>
              {openText}
            </Alert>
          }
        </Snackbar>
      </div>
      <Grid
        container
        spacing={3}
        alignContent="center"
        alignItems="center"
        justify="center"
      >
        <Grid item xs={2}>
          <FormControl variant="outlined" className={classes.formControl}>
            <InputLabel id="demo-simple-select-outlined-label">
              Exercise Category
            </InputLabel>
            <Select
              labelId="demo-simple-select-outlined-label"
              id="demo-simple-select-outlined"
              value={category}
              onChange={handleChangeCategory}
              label="Exercise Category"
              // autoWidth
            >
              <MenuItem value="Fat Loss">Fat Loss</MenuItem>
              <MenuItem value="Yoga">Yoga</MenuItem>
              <MenuItem value="Body Pump">Body Pump</MenuItem>
            </Select>
          </FormControl>
        </Grid>

        {/* <Grid item xs={2}>
          <TextField
            error={!isUrlValid(url)}
            id="outlined-textarea"
            label="Youtube Link"
            variant="outlined"
            autoComplete="off"
            value={url}
            onChange={(e) => setUrl(e.currentTarget.value)}
          />
        </Grid> */}

        {/* <Grid item xs={2}>
          <FormControl variant="outlined" className={classes.formControl}>
            <InputLabel id="demo-simple-select-outlined-label">
              Exercise Time
            </InputLabel>
            <Select
              labelId="demo-simple-select-outlined-label"
              id="demo-simple-select-outlined"
              value={time}
              onChange={handleChangeTime}
              label="Exercise Time"
              // autoWidth
            >
              <MenuItem value="10 Minutes">10 Minutes</MenuItem>
              <MenuItem value="20 Minutes">20 Minutes</MenuItem>
              <MenuItem value="30 Minutes">30 Minutes</MenuItem>
              <MenuItem value="40 Minutes">40 Minutes</MenuItem>
              <MenuItem value="50 Minutes">50 Minutes</MenuItem>
              <MenuItem value="60 Minutes">60 Minutes</MenuItem>
              <MenuItem value="70 Minutes">70 Minutes</MenuItem>
              <MenuItem value="80 Minutes">80 Minutes</MenuItem>
              <MenuItem value="90 Minutes">90 Minutes</MenuItem>
            </Select>
          </FormControl>
        </Grid> */}
        <Grid item xs={2}>
          <TextField
            id="outlined-textarea"
            label="Description"
            placeholder="Write Topics here"
            multiline
            variant="outlined"
            autoComplete="off"
            value={description}
            onChange={(e) => setDescription(e.currentTarget.value)}
          />
        </Grid>
        <Grid item xs={2}>
          <Button
            variant="outlined"
            color="primary"
            onClick={() => {
              onSave();
            }}
          >
            Add
          </Button>
        </Grid>
      </Grid>
    </form>
  );
};

export default AddVideoEntryForm;