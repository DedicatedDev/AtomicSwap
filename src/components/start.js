import React from "react";
import PropTypes from "prop-types";
import { makeStyles } from "@material-ui/core/styles";
import AppBar from "@material-ui/core/AppBar";
import Tabs from "@material-ui/core/Tabs";
import Tab from "@material-ui/core/Tab";
import Box from "@material-ui/core/Box";
import Grid from "@material-ui/core/Grid";
import IconButton from "@material-ui/core/IconButton";
import ExitToAppIcon from "@material-ui/icons/ExitToApp";
import { blue } from "@material-ui/core/colors";

import VideosList from "./video-list";
import InfluencerList from "./influencer-list";
import CategoryTopics from "./categoryTopics";
import app from "../firebase";

function TabPanel(props) {
  const { children, value, index, ...other } = props;

  return (
    <div
      role="tabpanel"
      hidden={value !== index}
      id={`simple-tabpanel-${index}`}
      aria-labelledby={`simple-tab-${index}`}
      {...other}
    >
      {value === index && <Box p={3}>{children}</Box>}
    </div>
  );
}

TabPanel.propTypes = {
  children: PropTypes.node,
  index: PropTypes.any.isRequired,
  value: PropTypes.any.isRequired,
};

function a11yProps(index) {
  return {
    id: `simple-tab-${index}`,
    "aria-controls": `simple-tabpanel-${index}`,
  };
}

const useStyles = makeStyles((theme) => ({
  root: {
    flexGrow: 1,
    backgroundColor: theme.palette.background.paper,
  },
}));

export default function SimpleTabs() {
  const classes = useStyles();
  const [value, setValue] = React.useState(0);

  const handleChange = (event, newValue) => {
    setValue(newValue);
  };

  return (
    <div className={classes.root}>
      <AppBar position="static">
        <Grid container spacing={3}>
          <Grid item xs={11}>
            <Tabs
              value={value}
              onChange={handleChange}
              aria-label="simple tabs example"
            >
              <Tab label="Influencers" {...a11yProps(0)} />
              <Tab label="Videos" {...a11yProps(1)} />
              <Tab label="Category Topics" {...a11yProps(2)} />
            </Tabs>
          </Grid>
          <Grid item xs={1}>
            <IconButton
              style={{ color: blue[50], zIndex: 1 }}
              aria-label="Logout"
              onClick={() => app.auth().signOut()}
            >
              <ExitToAppIcon />
            </IconButton>
          </Grid>
        </Grid>
      </AppBar>
      <TabPanel value={value} index={0}>
        <InfluencerList />
      </TabPanel>
      <TabPanel value={value} index={1}>
        <VideosList />
      </TabPanel>
      <TabPanel value={value} index={2}>
        <CategoryTopics />
      </TabPanel>
    </div>
  );
}
