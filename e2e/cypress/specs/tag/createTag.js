// https://docs.cypress.io/api/introduction/api.html

describe("Create tag", () => {
  const name = `tag${Date.now()}`;

  before(() => {
    cy.deleteTestData()
  });

  beforeEach(() => {
    cy.login()
    cy.visit('/tags')
    cy.get('[data-cy=tags__add_tag_button]').click();
  });

  describe('When fill data properly', () => {
    beforeEach(() => {
      cy.get('[data-cy=tag_modal__name_input]').type(name);
      cy.get('[data-cy=tag_modal__confirm_button]').click();
    });

    it("Should contains formated name: value", () => {
      cy.contains(name);
    });
  });

  describe('When fill data not properly (repeated name)', () => {
    beforeEach(() => {
      cy.get('[data-cy=tag_modal__name_input]').type(name);
      cy.get('[data-cy=tag_modal__confirm_button]').click();
    });

    it("Should has error for invalid name", () => {
      cy.get('[data-cy=tag_modal__error_message]').should("exist");
    });
  });
});
