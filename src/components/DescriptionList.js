import React from "react";
import { makeStyles } from "@material-ui/core/styles";
import List from "@material-ui/core/List";
import ListItem from "@material-ui/core/ListItem";
import ListItemSecondaryAction from "@material-ui/core/ListItemSecondaryAction";
import ListItemText from "@material-ui/core/ListItemText";
import IconButton from "@material-ui/core/IconButton";
import Grid from "@material-ui/core/Grid";
import DeleteIcon from "@material-ui/icons/Delete";
import { Typography } from "@material-ui/core";
import firebase from "../firebase";

const useStyles = makeStyles((theme) => ({
  root: {
    flexGrow: 1,
    maxWidth: 752,
  },
  demo: {
    backgroundColor: theme.palette.background.paper,
  },
  title: {
    margin: theme.spacing(4, 0, 2),
  },
}));

export default function DescriptionList({ title, data }) {
  const classes = useStyles();
  const [dense, setDense] = React.useState(false);
  const [secondary, setSecondary] = React.useState(false);
  const handleDelete = (id, title) => {
    console.log("Item id ", id);
    console.log("title", title);
    firebase.firestore().collection(title).doc(id).delete();
  };
  console.log("Recived data", data);
  return (
    <div className={classes.root}>
      <Typography>{title}</Typography>

      <Grid container spacing={2}>
        <Grid item xs={12}>
          <div className={classes.demo}>
            {data.map((item, index) => (
              <List dense={dense}>
                <ListItem>
                  {console.log("Item descriptin", item.description)}
                  <ListItemText
                    primary={item.description}
                    secondary={secondary ? "Secondary text" : null}
                  />
                  <ListItemSecondaryAction>
                    <IconButton
                      edge="end"
                      aria-label="delete"
                      onClick={() => handleDelete(item.id, title)}
                    >
                      <DeleteIcon />
                    </IconButton>
                  </ListItemSecondaryAction>
                </ListItem>
              </List>
            ))}
          </div>
        </Grid>
      </Grid>
    </div>
  );
}
