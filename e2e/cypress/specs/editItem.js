
describe("Edit item", () => {
  const now = Date.now()
  const key1 = `key1${now}`;
  const value1 = `value1${now}`;
  const key2 = `key2${now}`;
  const value2 = `value2${now}`;
  const key1updated = `${key1}-updated`;
  const value1updated = `value1${now}-updated`;


  describe("When new data is valid", () => {
    beforeEach(() => {
      cy.login()
      cy.createItem(key1, value1)
    });

    afterEach(() => {
      cy.deleteItemByKey(key1updated)
    })

    it("should be updated when click on save button", () => {
      cy.get(`[data-cy=show_item__edit_button_${key1}]`).click();

      cy.get('[data-cy=item_modal__key_input]').clear().type(key1updated);
      cy.get('[data-cy=item_modal__value_input]').clear().type(value1updated);
      cy.wait(500)
      cy.get('[data-cy=item_modal__confirm_button]').click();
      cy.contains(`${key1updated}: ${value1updated}`);
    });
  });

  describe("When key is empty", () => {
    beforeEach(() => {
      cy.login()
      cy.createItem(key2, value2)
    });

    afterEach(() => {
      cy.deleteItemByKey(key2)
    })

    it("should be updated when click on save button", () => {
      cy.get(`[data-cy=show_item__edit_button_${key2}]`).click();

      cy.get('[data-cy=item_modal__key_input]').clear();
      cy.get('[data-cy=item_modal__confirm_button]').click();
      cy.wait(500)
      cy.contains("Validation failed: Key can't be blank");
    });
  });
});
