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


const AddVideoEntryForm = () => {
  const [category, setCategory] = useState("");
  const [description, setDescription] = useState("");
  const [open, setOpen] = useState(false);
  const [openType, setOpenType] = useState("error");
  const [openText, setOpenText] = useState("");

  const classes = useStyles();
  const handleChangeCategory = (event) => {
    setCategory(event.target.value);
  };

  const handleClose = (event, reason) => {
    if (reason === "clickaway") {
      return;
    }
    setOpen(false);
  };

  function onSave() {
    if (category === "") {
      setOpenType("error");
      setOpenText("Please select the category.");
      setOpen(true);
      return;
    }

    firebase
      .firestore()
      .collection(category)
      .add({
        category: category,
        description: description,
      })
      .then(() => {
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
