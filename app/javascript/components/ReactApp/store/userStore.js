import React from 'react';

const defaultState = {
  jwt: undefined,
  isFetching: false,
  isError: false,
};

// Example: https://github.com/mnishiguchi/memory_game_2019/blob/master/src/store/appStore.js

// private constants (implementation detail)
// naming convention adopted from: https://decembersoft.com/posts/a-simple-naming-convention-for-action-creators-in-redux-js/
const USER_REGISTRATION_REQUEST = 'USER_REGISTRATION_REQUEST';
const USER_REGISTRATION_FAILURE = 'USER_REGISTRATION_FAILURE';
const USER_REGISTRATION_SUCCESS = 'USER_REGISTRATION_SUCCESS';

// private reducer (implementation detail)
const appReducer = (state, action) => {
  const { type, payload } = action;
  switch (type) {
    case USER_REGISTRATION_REQUEST:
      return {
        ...state,
        isFetching: true,
        isError: false,
      };
    case USER_REGISTRATION_FAILURE:
      return {
        ...state,
        isFetching: false,
        isError: !!payload.error,
      };
    case USER_REGISTRATION_SUCCESS:
      if (!payload.user.jwt) throw new Error();
      return {
        ...state,
        ...payload.user,
        isFetching: false,
        isError: false,
      };
    default:
      throw new Error();
  }
};

const createActions = dispatch => ({
  userRegistrationRequest() {
    console.log('userRegistrationRequest');
    dispatch({ type: USER_REGISTRATION_REQUEST, payload: {} });
  },
  userRegistrationFailure(error) {
    // TODO: handle "not_modified"
    console.log('userRegistrationFailure', error);
    dispatch({ type: USER_REGISTRATION_FAILURE, payload: { error } });
  },
  userRegistrationSuccess(user) {
    console.log('userRegistrationSuccess', user);
    dispatch({ type: USER_REGISTRATION_SUCCESS, payload: { user } });
  },
});

// returns a public store object that contains state and action dispatchers
export const useUserStore = (initialState = defaultState) => {
  const [state, dispatch] = React.useReducer(appReducer, initialState);

  return {
    ...state,
    actions: createActions(dispatch),
  };
};

// public context that is used to share state with child components
export const UserContext = React.createContext();
