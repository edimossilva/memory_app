describe("Login", () => {
  beforeEach(() => {
    cy.visit("/login");
  });

  describe('When fill login properly and click login', () => {
    beforeEach(() => {
      cy.get('[data-cy=username]').clear().type("registered_user1");
      cy.get('[data-cy=password]').clear().type("111");
      cy.get('[data-cy=loginButton]').click();
    });

    it("Shold be redirected to home page", () => {
      cy.url().should('not.include', '/login')
      cy.get('[data-cy=home__title]').should("exist");
    });
  });

  describe('When does not fill login properly and click login', () => {
    beforeEach(() => {
      cy.get('[data-cy=username]').clear().type("invalid");
      cy.get('[data-cy=password]').clear().type("invalid");
      cy.get('[data-cy=loginButton]').click();
    });

    it("Shold stay at login page", () => {
      cy.url().should('include', '/login')
      cy.get('[data-cy=home__title]').should("not.exist");
    });
  });
});
