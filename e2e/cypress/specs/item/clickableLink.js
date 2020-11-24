// https://docs.cypress.io/api/introduction/api.html

describe("Clickable Link", () => {
  const key1 = `key1${Date.now()}`;
  const value1 = `value1${Date.now()}`;
  const key2 = `key2${Date.now()}`;
  const value2 = `http:\/\/value2${Date.now()}`;

  before(() => {
    cy.deleteTestData()
  });

  describe("When value is a url it is displayed as link", () => {
    beforeEach(() => {
      cy.login()
      cy.createItem(key1, value1)
      cy.createItem(key2, value2)
    });

    it("should have key only for links", () => {
      cy.get(`[data-cy=show_item__a_${key2}]`).should('have.attr', 'href', value2);
      cy.get(`[data-cy=show_item__a_${key1}]`).should('not.have.attr', 'href', value1);
    });
  });
});
