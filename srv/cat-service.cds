using { com.sap.bookshop as my, V_AUTHORS} from '../db/schema';
service CatalogService @(path:'/browse') {

  /** For displaying lists of Books */
  @readonly entity ListOfBooks as projection on Books
  excluding { descr };

  /** For display in details pages */
  @readonly entity Books as projection on my.Books { *,
    author.name as author
  } excluding { createdBy, modifiedBy };

  

    /* Expreriment */

  ///View
  @readonly entity V_Authors as projection on V_AUTHORS;

  //Procedure
  function sleep() returns Boolean;

  entity authorCustom as projection on my.AuthorCustom;

  function getAuthors(ID: Integer ) returns array of authorCustom;

  entity Authors as projection on my.AuthorCustom;

  /* Expreriment */

  @requires: 'authenticated-user'
  action submitOrder ( book: Books:ID, quantity: Integer ) returns { stock: Integer };
  event OrderedBook : { book: Books:ID; quantity: Integer; buyer: String };
}
