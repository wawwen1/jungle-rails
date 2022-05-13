describe ('Product Detail', () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("visits product page after clicking product", () => {
    cy.get(".products article").first().click();
    cy.url().should("include", "/products/");
  });
})