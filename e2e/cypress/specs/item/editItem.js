
describe("Edit item", () => {
  const now = Date.now()
  const key1 = `key1${now}`;
  const value1 = `value1${now}`;
  const key2 = `key2${now}`;
  const value2 = `value2${now}`;
  const key1updated = `${key1}-updated`;
  const value1updated = `value1${now}-updated`;
  const tagName1 = 'tagName1'

  before(() => {
    cy.deleteTestData()
  });

  describe("When new data is valid", () => {
    beforeEach(() => {
      cy.login()
      cy.createItem(key1, value1)
    });

    it("should be updated when click on save button", () => {
      cy.get(`[data-cy=show_item__edit_button_${key1}]`).click();

      cy.get('[data-cy=item_modal__key_input]').clear().type(key1updated);
      cy.get('[data-cy=item_modal__value_input]').clear().type(value1updated);
      cy.wait(500)
      cy.get('[data-cy=item_modal__confirm_button]').click();
      cy.contains(key1updated);
      cy.contains(value1updated);
    });
  });

  describe("When key is empty", () => {
    beforeEach(() => {
      cy.login()
      cy.createItem(key2, value2)
    });

    it("should be updated when click on save button", () => {
      cy.get(`[data-cy=show_item__edit_button_${key2}]`).click();

      cy.get('[data-cy=item_modal__key_input]').clear();
      cy.get('[data-cy=item_modal__confirm_button]').click();
      cy.wait(500)
      cy.contains("Validation failed: Key can't be blank");
    });
  });

  describe('When use tags', () => {
    beforeEach(() => {
      cy.deleteTestData()
      cy.login()
      cy.createItem(key2, value2)
      cy.createTag(tagName1)
      cy.visit('/')
    });

    it("Should contains edited tags", () => {
      cy.get(`[data-cy=show_item__edit_button_${key2}]`).click();

      cy.get('[data-cy=item_modal__tag_autocomplete]').type(tagName1);
      cy.get('.dropdown-item').first().click();
      cy.get(`[data-cy=item_modal__tag_spam_${tagName1}]`).should('exist')
      cy.get('[data-cy=item_modal__confirm_button]').click();
      cy.get(`[data-cy=show_item__tag_${tagName1}]`).should('be.visible');
    });

    it("Should be able to remove tags", () => {
      cy.get(`[data-cy=show_item__edit_button_${key2}]`).click();

      cy.get('[data-cy=item_modal__tag_autocomplete]').type(tagName1);
      cy.get('.dropdown-item').first().click();
      cy.get(`[data-cy=item_modal__tag_spam_${tagName1}]`).should('exist')
      cy.get('[data-cy=item_modal__confirm_button]').click();
      cy.get(`[data-cy=show_item__tag_${tagName1}]`).should('be.visible');

      cy.get(`[data-cy=show_item__edit_button_${key2}]`).click();
      cy.get('.is-small.delete').click();
      cy.get('[data-cy=item_modal__confirm_button]').click();
      cy.get(`[data-cy=show_item__tag_${tagName1}]`).should('not.be.visible');

    });
  });
});
