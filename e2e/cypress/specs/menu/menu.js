// https://docs.cypress.io/api/introduction/api.html

describe("Menu", () => {
  const name = `tag${Date.now()}`;

  beforeEach(() => {
    cy.login()
    cy.visit('/')
  });

  it("should navigate", () => {
    cy.get('.navbar-burger').click();
    cy.get('[data-cy=main-menu__navbar-item-tags]').click()
    cy.get('[data-cy=list_tags]').should("exist");

    cy.get('.navbar-burger').click();
    cy.get('[data-cy=main-menu__navbar-item-items]').click()
    cy.get('[data-cy=list_items]').should("exist");
  });
});
