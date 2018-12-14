#ifndef SQLITEDB_H
#define SQLITEDB_H

#include <QtSql>
#include <QByteArray>


#define BOOKTABLE "create table books(id integer primary key, title varchar, author integer, genre integer, year integer, rating integer)"
#define AUTHORTABLE "create table authors(id integer primary key, name varchar, birthdate date)"
#define CUSTOMER "CREATE TABLE IF NOT EXISTS Customers (ID integer PRIMARY KEY autoincrement, Name text NOT NULL UNIQUE, Address text NOT NULL, MoNumber text NOT NULL UNIQUE, MoNumber2 text NULL, CONSTRAINT uiocount UNIQUE (Name,MoNumber));"



class sqlitedb
{
public:
    sqlitedb();
    ~sqlitedb();
    QSqlError Add_User();
    QSqlError Delete_User();
    QSqlError Update_user();
    QSqlError Get_user();
    QStringList Get_Table_Names();
    QSqlError If_Table_Exists(QByteArray);
    QSqlError Execute_qury(QByteArray);


private:
    QSqlDatabase m_db;
};

#endif // SQLITEDB_H
