import React from 'react';
import { NavLink as RouterNavLink } from 'react-router-dom';
import {
  Collapse,
  Navbar,
  NavbarToggler,
  NavbarBrand,
  Nav,
  NavItem,
  NavLink,
  UncontrolledDropdown,
  DropdownToggle,
  DropdownMenu,
  DropdownItem,
} from 'reactstrap';

import css from './TopNav.module';

const repoUrl = 'https://github.com/mnishiguchi/jwt-app';

const TopNav = ({ title = 'React App' }) => {
  const [isOpen, updateIsOpen] = React.useState(false);
  const toggle = () => updateIsOpen(prev => !prev);

  return (
    <Navbar dark expand="md" className={css.navbar}>
      <NavbarBrand href="/">{title}</NavbarBrand>
      <NavbarToggler onClick={toggle} />
      <Collapse isOpen={isOpen} navbar>
        <Nav className="ml-auto" navbar>
          <NavItem>
            <NavLink tag={RouterNavLink} to="/about">
              About
            </NavLink>
          </NavItem>
          <NavItem>
            <NavLink tag={RouterNavLink} to="/contact">
              Contact
            </NavLink>
          </NavItem>
          <NavItem>
            <NavLink href={repoUrl}>Repo</NavLink>
          </NavItem>
          <UncontrolledDropdown nav inNavbar>
            <DropdownToggle nav caret>
              Options
            </DropdownToggle>
            <DropdownMenu right>
              <DropdownItem>Option 1</DropdownItem>
              <DropdownItem>Option 2</DropdownItem>
              <DropdownItem divider />
              <DropdownItem>Reset</DropdownItem>
            </DropdownMenu>
          </UncontrolledDropdown>
        </Nav>
      </Collapse>
    </Navbar>
  );
};

export default TopNav;
