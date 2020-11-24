// https://docs.cypress.io/api/introduction/api.html

describe("Delete tag", () => {
  const tag = `tag${Date.now()}`;

  describe("When tag exists", () => {
    beforeEach(() => {
      cy.login()
      cy.createTag(tag)
    });

    it("should be deleted when click on delete button", () => {
      cy.get(`[data-cy=show_tag__delete_button_${tag}]`).should("exist");
      cy.get(`[data-cy=show_tag__delete_button_${tag}]`).click();
      cy.get('button.button.is-danger').click();

      cy.wait(500)
      cy.get(`[data-cy=show_tag__delete_button_${tag}]`).should("not.exist");
    });
  });
});
