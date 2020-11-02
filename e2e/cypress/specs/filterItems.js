// https://docs.cypress.io/api/introduction/api.html

describe("Filrer items", () => {
  const key1 = `key1${Date.now()}`;
  const value1 = `value1${Date.now()}`;
  const key2 = `key2${Date.now()}`;
  const value2 = `value2${Date.now()}`;

  describe("When item exists", () => {
    beforeEach(() => {
      cy.login()
      cy.createItem(key1, value1)
      cy.createItem(key2, value2)
    });

    it("should be filter items by key", () => {
      cy.get(`[data-cy=show_item__card_${key1}]`).should("exist");
      cy.get(`[data-cy=show_item__card_${key2}]`).should("exist");

      cy.get('[data-cy=list_items__filter_input]').type('key1');

      cy.get(`[data-cy=show_item__card_${key1}]`).should("exist");
      cy.get(`[data-cy=show_item__card_${key2}]`).should("not.exist");
    });
  });
});
