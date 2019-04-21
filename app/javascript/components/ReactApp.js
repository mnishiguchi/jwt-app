import React from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';

import Home from './ReactApp/Home';
import About from './ReactApp/About';
import Contact from './ReactApp/Contact';
import NoMatch from './ReactApp/NoMatch';
import TopNav from './ReactApp/TopNav';

// https://reacttraining.com/react-router/web/guides/quick-start
const ReactApp = () => (
  <Router>
    <TopNav />

    <Switch>
      <Route path="/" exact component={Home} />
      <Route path="/about" exact component={About} />
      <Route path="/contact" exact component={Contact} />
      <Route component={NoMatch} />
    </Switch>
  </Router>
);

export default ReactApp;
