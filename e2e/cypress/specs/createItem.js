// https://docs.cypress.io/api/introduction/api.html

describe("Create task", () => {
  const key1 = `key1${Date.now()}`;
  const value1 = `value1${Date.now()}`;

  beforeEach(() => {
    cy.login()
    cy.get('[data-cy=home__add_item_button]').click();
  });

  describe('When fill data properly', () => {
    beforeEach(() => {
      cy.get('[data-cy=add_item_modal__key_input]').type(key1);
      cy.get('[data-cy=add_item_modal__value_input]').type(value1);
      cy.get('[data-cy=add_item_modal__add_button]').click();
    });

    it("Should contains formated key: value", () => {
      cy.contains(`${key1}: ${value1}`);
    });
  });

  describe('When fill data not properly (repeated key)', () => {
    beforeEach(() => {
      cy.get('[data-cy=add_item_modal__key_input]').type(key1);
      cy.get('[data-cy=add_item_modal__value_input]').type(value1);
      cy.get('[data-cy=add_item_modal__add_button]').click();
    });

    it("Should has error for invalid key", () => {
      cy.get('[data-cy=add_item_modal__error_message]').should("exist");
    });
  });
});
