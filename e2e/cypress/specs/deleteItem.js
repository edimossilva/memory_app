// https://docs.cypress.io/api/introduction/api.html

describe("Delete item", () => {
  const key1 = `key1${Date.now()}`;
  const value1 = `value1${Date.now()}`;

  describe("When item exists", () => {
    beforeEach(() => {
      cy.login()
      cy.createItem(key1, value1)
    });

    it("should be deleted when click on delete button", () => {
      cy.get(`[data-cy=show_item__delete_button_${key1}]`).should("exist");
      cy.get(`[data-cy=show_item__delete_button_${key1}]`).click();+
      cy.wait(500)
      cy.get(`[data-cy=show_item__delete_button_${key1}]`).should("not.exist");
    });
  });
});
