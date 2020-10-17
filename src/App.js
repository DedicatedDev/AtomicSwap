import React from 'react';
import {
  BrowserRouter as Router,
  Route
} from "react-router-dom";
import './App.css';


import StartPage from './components/start';
import Login from './login';
import AuthProvider from './components/Auth';
import PrivateRoute from './components/PrivateRoute';

function App() {

  return (
    <div className="App">
        <div>
          <h1>GymCall Admin</h1>
        </div>
        <div>
            <AuthProvider>
                <Router>
                    <div>
                        <Route exact path='/' component={ Login } />
                        <PrivateRoute exact path='/admin' component = { StartPage } />
                    </div> 
                </Router>
            </AuthProvider>
        </div>
    </div>
  );
}

export default App;
