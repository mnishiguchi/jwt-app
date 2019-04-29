import React from 'react';
import { withRouter } from 'react-router';
import { Formik } from 'formik';
import * as Yup from 'yup';
import {
  Button,
  Card,
  CardBody,
  Container,
  Form,
  FormFeedback,
  FormGroup,
  Input,
  Label,
} from 'reactstrap';

import { UserContext } from '../store/userStore';
import routes from '../routes';

const initialValues = {
  email: '',
  password: '',
  passwordConfirmation: '',
};

const validationSchema = Yup.object().shape({
  email: Yup.string()
    .email()
    .required('Required'),
  password: Yup.string().required('Required'),
});

const formValuesToAuthParamsJson = values => JSON.stringify({
  auth: {
    email: values.email,
    password: values.password,
    password_confirmation: values.passwordConfirmation,
  },
});

const Login = ({ history }) => {
  const userContext = React.useContext(UserContext);
  const {
    actions: { userRegistrationRequest, userRegistrationFailure, userRegistrationSuccess },
  } = userContext;

  const submitLoginForm = (values) => {
    userRegistrationRequest();
    fetch(routes.useRegistration(), {
      method: 'POST',
      body: formValuesToAuthParamsJson(values),
      headers: {
        'Content-Type': 'application/json',
      },
    })
      .then((response) => {
        if (!response.ok) throw Error(response.statusText);
        return response;
      })
      .then(response => response.json())
      .then((user) => {
        userRegistrationSuccess(user);
        history.replace(routes.home());
      })
      .catch(error => userRegistrationFailure(error));
  };

  return (
    <Container className="my-3" style={{ minHeight: '30vh' }}>
      <h1>Login</h1>
      <Card>
        <CardBody>
          <Formik
            initialValues={initialValues}
            onSubmit={(values, { setSubmitting }) => {
              submitLoginForm(values);
              setSubmitting(false);
            }}
            validationSchema={validationSchema}
          >
            {(props) => {
              const {
                values,
                touched,
                errors,
                dirty,
                isSubmitting,
                handleChange,
                handleBlur,
                handleSubmit,
                handleReset,
              } = props;
              return (
                <Form onSubmit={handleSubmit}>
                  <FormGroup>
                    <Label htmlFor="email">Email</Label>
                    <Input
                      type="email"
                      id="email"
                      placeholder="Email"
                      value={values.email}
                      onChange={handleChange}
                      onBlur={handleBlur}
                      valid={touched.email && !errors.email}
                      invalid={touched.email && !!errors.email}
                    />
                    <FormFeedback>
                      <span>{touched.email && errors.email}</span>
                    </FormFeedback>
                  </FormGroup>

                  <FormGroup>
                    <Label htmlFor="password">Password</Label>
                    <Input
                      type="password"
                      id="password"
                      placeholder="password"
                      value={values.password}
                      onChange={handleChange}
                      onBlur={handleBlur}
                      valid={touched.password && !errors.password}
                      invalid={touched.password && !!errors.password}
                    />
                    <FormFeedback>
                      <span>{touched.password && errors.password}</span>
                    </FormFeedback>
                  </FormGroup>

                  <FormGroup>
                    <Label htmlFor="passwordConfirmation">Password Confirmation</Label>
                    <Input
                      type="password"
                      id="passwordConfirmation"
                      placeholder="Password Confirmation"
                      value={values.passwordConfirmation}
                      onChange={handleChange}
                      onBlur={handleBlur}
                      valid={touched.passwordConfirmation && !errors.passwordConfirmation}
                      invalid={touched.passwordConfirmation && !!errors.passwordConfirmation}
                    />
                    <FormFeedback>
                      <span>{touched.passwordConfirmation && errors.passwordConfirmation}</span>
                    </FormFeedback>
                  </FormGroup>

                  <Button
                    type="button"
                    onClick={handleReset}
                    disabled={!dirty || isSubmitting}
                    color="secondary"
                    outline
                  >
                    Reset
                  </Button>
                  <Button type="submit" disabled={isSubmitting} color="primary">
                    Login
                  </Button>
                </Form>
              );
            }}
          </Formik>
        </CardBody>
      </Card>
    </Container>
  );
};

export default withRouter(Login);
