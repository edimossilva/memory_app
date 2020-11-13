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
  cy.get('[data-cy=item_modal__key_input]').type(key);
  cy.get('[data-cy=item_modal__value_input]').type(value);
  cy.get('[data-cy=item_modal__confirm_button]').click();
  cy.wait(600)
})

Cypress.Commands.add("deleteItemByKey", (key) => {
  cy.visit("/");
  cy.get(`[data-cy=show_item__delete_button_${key}]`).click();
})

Cypress.Commands.add("createTag", (name) => {
  cy.visit('/tags')
  cy.get('[data-cy=tags__add_tag_button]').click();
  cy.get('[data-cy=tag_modal__name_input]').type(name);
  cy.get('[data-cy=tag_modal__confirm_button]').click();
  cy.wait(600)
})

Cypress.Commands.add("deleteTagByName", (name) => {
  cy.visit("/tags");
  cy.get(`[data-cy=show_tag__delete_button_${name}]`).click();
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
