
describe("Logout", () => {
  beforeEach(() => {
    cy.login()
  });

  describe("When click logout button", () => {
    beforeEach(() => {
      cy.get('.navbar-burger').click();
      cy.get(`[data-cy=main_menu__logout]`).click()
    });

    it("should be redirected to login", () => {
      cy.url().should('include', '/login')
      expect(localStorage.getItem('token')).to.eq('')
    });
  });

  describe("When token is invalid", () => {
    beforeEach(() => {
      localStorage.setItem('token', 'invalid token')
      cy.reload()
    });

    it("should be redirected to login", () => {
      cy.url().should('include', '/login')
    });
  });
});
