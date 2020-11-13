
describe("Edit tag", () => {
  const now = Date.now()
  const name = `name${now}`;
  const name2 = `name2${now}`;
  const nameupdated = `${name}-updated`;
  const value1updated = `value1${now}-updated`;


  describe("When new data is valid", () => {
    beforeEach(() => {
      cy.login()
      cy.createTag(name)
    });

    afterEach(() => {
      cy.deleteTagByName(nameupdated)
    })

    it("should be updated when click on save button", () => {
      cy.get(`[data-cy=show_tag__edit_button_${name}]`).click();

      cy.get('[data-cy=tag_modal__name_input]').clear().type(nameupdated);
      cy.wait(500)
      cy.get('[data-cy=tag_modal__confirm_button]').click();
      cy.contains(nameupdated);
    });
  });

  describe("When name is empty", () => {
    beforeEach(() => {
      cy.login()
      cy.createTag(name2)
    });

    afterEach(() => {
      cy.deleteTagByName(name2)
    })

    it("should be updated when click on save button", () => {
      cy.get(`[data-cy=show_tag__edit_button_${name2}]`).click();

      cy.get('[data-cy=tag_modal__name_input]').clear();
      cy.get('[data-cy=tag_modal__confirm_button]').click();
      cy.wait(500)
      cy.contains("Validation failed: Name can't be blank");
    });
  });
});
