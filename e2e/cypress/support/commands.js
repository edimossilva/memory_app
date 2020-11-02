// ***********************************************
// This example commands.js shows you how to
// create various custom commands and overwrite
// existing commands.
//
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************
//
//
// -- This is a parent command --
Cypress.Commands.add("login", () => {
  cy.visit("/login");
  cy.get('[data-cy=username]').clear().type("registered_user1");
  cy.get('[data-cy=password]').clear().type("111");
  cy.get('[data-cy=loginButton]').click();
  cy.wait(600)
})
Cypress.Commands.add("createItem", (key, value) => {
  cy.visit("/");
  cy.get('[data-cy=home__add_item_button]').click();
  cy.get('[data-cy=add_item_modal__key_input]').type(key);
  cy.get('[data-cy=add_item_modal__value_input]').type(value);
  cy.get('[data-cy=add_item_modal__add_button]').click();
  cy.wait(600)
})
//
//
// -- This is a child command --
// Cypress.Commands.add("drag", { prevSubject: 'element'}, (subject, options) => { ... })
//
//
// -- This is a dual command --
// Cypress.Commands.add("dismiss", { prevSubject: 'optional'}, (subject, options) => { ... })
//
//
// -- This is will overwrite an existing command --
// Cypress.Commands.overwrite("visit", (originalFn, url, options) => { ... })
