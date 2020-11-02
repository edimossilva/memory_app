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

    it("Shold be redirected to List items page", () => {
      cy.url().should('not.include', '/login')
      cy.get('[data-cy=list_items]').should("exist");
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
      cy.contains("Invalid Login or password.");
    });
  });
});
