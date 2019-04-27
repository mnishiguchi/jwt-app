import React from 'react';
import { Container } from 'reactstrap';

import { UserContext } from '../store/userStore';

const Home = () => {
  const userContext = React.useContext(UserContext);
  const { jwt, email } = userContext;

  return (
    <Container className="my-3" style={{ minHeight: '30vh' }}>
      <h1>Home</h1>
      <p>{jwt ? "logged in" : ''}</p>
      <p>{email ? email : ''}</p>
      <p>
        Lorem ipsum dolor sit, amet consectetur adipisicing elit. Cupiditate et nulla non, tempore a
        molestias nesciunt velit. Nobis quibusdam ipsam deserunt vero at ex eos eveniet. Rerum
        similique illo doloribus?
      </p>
    </Container>
  );
};

export default Home;
