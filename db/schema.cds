using { Currency, managed, sap } from '@sap/cds/common';
// namespace com.sap.bookshop;

context com.sap.bookshop {

    entity Books : managed {
    key ID : Integer;
    title  : localized String(111);
    descr  : localized String(1111);
    author : Association to Authors;
    genre  : Association to Genres;
    stock  : Integer;
    price  : Decimal;
    currency : Currency;
    image : LargeBinary @Core.MediaType : 'image/png';
    }

    entity Authors : managed {
    key ID : Integer;
    name   : String(111);
    dateOfBirth  : Date;
    dateOfDeath  : Date;
    placeOfBirth : String;
    placeOfDeath : String;
    books  : Association to many Books on books.author = $self;
    }

    entity AuthorCustom {
    key ID : Integer;
    NAME   : String(111);    
    }

    /** Hierarchically organized Code List for Genres */
    entity Genres : sap.common.CodeList {
    key ID   : Integer;
    parent   : Association to Genres;
    children : Composition of many Genres on children.parent = $self;
    }

}

@cds.persistence.exists
@cds.persistence.calcview
Entity ![V_AUTHORS] {
key     ![CREATEDAT]: Timestamp  @title: 'CREATEDAT: CREATEDAT' ; 
key     ![CREATEDBY]: String(255)  @title: 'CREATEDBY: CREATEDBY' ; 
key     ![MODIFIEDAT]: Timestamp  @title: 'MODIFIEDAT: MODIFIEDAT' ; 
key     ![MODIFIEDBY]: String(255)  @title: 'MODIFIEDBY: MODIFIEDBY' ; 
key     ![ID]: Integer  @title: 'ID: ID' ; 
key     ![NAME]: String(111)  @title: 'NAME: NAME' ; 
key     ![DATEOFBIRTH]: Date  @title: 'DATEOFBIRTH: DATEOFBIRTH' ; 
key     ![DATEOFDEATH]: Date  @title: 'DATEOFDEATH: DATEOFDEATH' ; 
key     ![PLACEOFBIRTH]: String(5000)  @title: 'PLACEOFBIRTH: PLACEOFBIRTH' ; 
key     ![PLACEOFDEATH]: String(5000)  @title: 'PLACEOFDEATH: PLACEOFDEATH' ; 
}