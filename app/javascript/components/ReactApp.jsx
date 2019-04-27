import React from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';

import { useUserStore, UserContext } from './ReactApp/store/userStore';
import routes from './ReactApp/routes';
import TopNav from './ReactApp/TopNav';
import NoMatch from './ReactApp/pages/NoMatch';
import Home from './ReactApp/pages/Home';
import About from './ReactApp/pages/About';
import Contact from './ReactApp/pages/Contact';
import Signup from './ReactApp/pages/Signup';
import Login from './ReactApp/pages/Login';

// https://reacttraining.com/react-router/web/guides/quick-start
const ReactApp = () => {
  const userStore = useUserStore();

  return (
    <React.Suspense fallback="Loading...">
      <UserContext.Provider value={userStore}>
        <Router>
          <TopNav />

          <Switch>
            <Route path={routes.home()} exact component={Home} />
            <Route path={routes.about()} exact component={About} />
            <Route path={routes.contact()} exact component={Contact} />
            <Route path={routes.signup()} exact component={Signup} />
            <Route path={routes.login()} exact component={Login} />
            <Route component={NoMatch} />
          </Switch>
        </Router>
      </UserContext.Provider>
    </React.Suspense>
  );
};

export default ReactApp;
