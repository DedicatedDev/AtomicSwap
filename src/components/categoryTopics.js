/* eslint-disable react-hooks/rules-of-hooks */
import React, { useState, useEffect } from "react";
import PropTypes from "prop-types";
import { makeStyles } from "@material-ui/core/styles";
import TableCell from "@material-ui/core/TableCell";
import TableHead from "@material-ui/core/TableHead";
import TableRow from "@material-ui/core/TableRow";
import TableSortLabel from "@material-ui/core/TableSortLabel";
import Grid from "@material-ui/core/Grid";
import DescriptionList from "./DescriptionList";

import firebase from "../firebase";
import AddSubTopics from "./addSubCategory";
import { Divider, Typography } from "@material-ui/core";

function createData(id, name, category, url, time, description) {
  return { id, name, category, url, time, description };
}

function descendingComparator(a, b, orderBy) {
  if (b[orderBy] < a[orderBy]) {
    return -1;
  }
  if (b[orderBy] > a[orderBy]) {
    return 1;
  }
  return 0;
}

const headCells = [
  {
    id: "yoga",
    numeric: false,
    disablePadding: true,
    label: "Yoga",
  },
  {
    id: "fatloss",
    numeric: true,
    disablePadding: false,
    label: "FatLoss",
  },

  {
    id: "bodypump",
    numeric: true,
    disablePadding: false,
    label: "Body Pump",
  },
  { id: "", numeric: true, disablePadding: false, label: "" },
];

function EnhancedTableHead(props) {
  const { classes, order, orderBy, onRequestSort } = props;
  const createSortHandler = (property) => (event) => {
    onRequestSort(event, property);
  };

  return (
    <TableHead>
      <TableRow>
        {headCells.map((headCell) => (
          <TableCell
            key={headCell.id}
            align={headCell.numeric ? "right" : "center"}
            padding={headCell.disablePadding ? "none" : "default"}
            sortDirection={orderBy === headCell.id ? order : false}
          >
            <TableSortLabel
              active={orderBy === headCell.id}
              direction={orderBy === headCell.id ? order : "asc"}
              onClick={createSortHandler(headCell.id)}
            >
              {headCell.label}
              {orderBy === headCell.id ? (
                <span className={classes.visuallyHidden}>
                  {order === "desc" ? "sorted descending" : "sorted ascending"}
                </span>
              ) : null}
            </TableSortLabel>
          </TableCell>
        ))}
      </TableRow>
    </TableHead>
  );
}

EnhancedTableHead.propTypes = {
  classes: PropTypes.object.isRequired,
  numSelected: PropTypes.number.isRequired,
  onRequestSort: PropTypes.func.isRequired,
  onSelectAllClick: PropTypes.func.isRequired,
  order: PropTypes.oneOf(["asc", "desc"]).isRequired,
  orderBy: PropTypes.string.isRequired,
  rowCount: PropTypes.number.isRequired,
};

const useStyles = makeStyles((theme) => ({
  root: {
    width: "100%",
  },
  paper: {
    width: "100%",
    marginBottom: theme.spacing(2),
  },
  table: {
    minWidth: 750,
  },
  talbeItem: {
    width: "100%",
    alignItems: "center",
    justifyContent: "center",
  },
  visuallyHidden: {
    border: 0,
    clip: "rect(0 0 0 0)",
    height: 1,
    margin: -1,
    overflow: "hidden",
    padding: 0,
    position: "absolute",
    top: 20,
    width: 1,
  },
  paperModal: {
    position: "absolute",
    width: 400,
    backgroundColor: theme.palette.background.paper,
    border: "2px solid #000",
    boxShadow: theme.shadows[5],
    padding: theme.spacing(2, 4, 3),
  },
}));

function useVideos() {
  const [videos, setVideos] = useState([]);

  useEffect(() => {
    const unsubscribe = firebase
      .firestore()
      .collection("videos")
      // .orderBy(SORT_OPTIONS[sortBy].column, SORT_OPTIONS[sortBy].direction)
      .onSnapshot((snapshot) => {
        const newVideos = snapshot.docs.map((doc) => ({
          id: doc.id,
          ...doc.data(),
        }));

        setVideos(newVideos);
      });

    return () => unsubscribe();
  }, []);

  return videos;
}

function getItems(title) {
  console.log("List title", title);
  const [items, setItems] = useState([]);
  useEffect(() => {
    const unsubscribe = firebase
      .firestore()
      .collection(title)
      // .orderBy(SORT_OPTIONS[sortBy].column, SORT_OPTIONS[sortBy].direction)
      .onSnapshot((snapshot) => {
        const newInfluencers = snapshot.docs.map((doc) => ({
          id: doc.id,
          ...doc.data(),
        }));

        setItems(newInfluencers);
      });
    return () => unsubscribe();
  }, [title]);
  return items;
}

export default function EnhancedTable() {
  const classes = useStyles();
  const [order, setOrder] = React.useState("asc");
  const [orderBy, setOrderBy] = React.useState("calories");
  const [selected, setSelected] = React.useState([]);
  const [page, setPage] = React.useState(0);
  const [dense, setDense] = React.useState(false);
  const [rowsPerPage, setRowsPerPage] = React.useState(10);
  const videos = useVideos();
  const yogaList = getItems("Yoga");
  const fatLossList = getItems("Fat Loss");
  const bodyPumpList = getItems("Body Pump");

  let rows = [];

  videos.map((video) =>
    rows.push(
      createData(
        video.id,
        video.influencer,
        video.category,
        video.url,
        video.time,
        video.description
      )
    )
  );

  const handleRequestSort = (event, property) => {
    const isAsc = orderBy === property && order === "asc";
    setOrder(isAsc ? "desc" : "asc");
    setOrderBy(property);
  };

  const handleSelectAllClick = (event) => {
    if (event.target.checked) {
      const newSelecteds = rows.map((n) => n.name);
      setSelected(newSelecteds);
      return;
    }
    setSelected([]);
  };

  const handleChangePage = (event, newPage) => {
    setPage(newPage);
  };

  const handleChangeDense = (event) => {
    setDense(event.target.checked);
  };

  const isSelected = (name) => selected.indexOf(name) !== -1;

  const emptyRows =
    rowsPerPage - Math.min(rowsPerPage, rows.length - page * rowsPerPage);

  const handleClickRow = (id) => {
    console.log(id);
    firebase.firestore().collection("videos").doc(id).delete();
  };

  return (
    <div className={classes.root}>
      <div>
        <AddSubTopics />
      </div>

      <Grid container spacing={4}>
        <Grid item xs={12} lg={4}>
          {console.log("Yoga List before", yogaList)}
          <DescriptionList title={"Yoga"} data={yogaList} />
        </Grid>
        {/* <Divider orientation={'vertical'} /> */}
        <Grid item xs={12} lg={4}>
          <DescriptionList title={"Fat Loss"} data={fatLossList} />
        </Grid>
        {/* <Divider orientation={'vertical'} /> */}

        <Grid item xs={12} lg={4}>
          <DescriptionList title={"Body Pump"} data={bodyPumpList} />
        </Grid>
      </Grid>
    </div>
  );
}
