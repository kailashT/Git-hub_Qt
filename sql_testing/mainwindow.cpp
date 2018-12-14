#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QtSql>
#include <my_headers.h>
#include <QCompleter>
#include <QMessageLogger>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    if (!QSqlDatabase::drivers().contains("QSQLITE"))
        QMessageBox::critical(this, "Unable to load database", "This demo needs the SQLITE driver");

    //db_edit = new sqlitedb();
    QStringList wordList;
    wordList << "alpha" << "omega" << "omicron" << "zeta";
    QCompleter *completer = new QCompleter(wordList, this);
    completer->setCaseSensitivity(Qt::CaseInsensitive);
    //ui->lineEditex->setCompleter(completer);
    //test_db();
    //db_edit->~sqlitedb();

}

MainWindow::~MainWindow()
{
    delete ui;
}

int MainWindow::test_db()
{
    db_edit->Add_User();
    db_edit->Delete_User();
    db_edit->Update_user();
    db_edit->Get_user();
    QStringList tables = db_edit->Get_Table_Names();
    qDebug() << "Database: table names : " << tables;
    db_edit->If_Table_Exists("customers");
    tables = db_edit->Get_Table_Names();
    qDebug() << "Database: table names : " << tables;

  //  db_edit->If_Table_Exists("authors");
    //db_edit->Create_table("hello query");

    return 0;
}

void MainWindow::resizeEvent(QResizeEvent *event)
{
    ui->stackedWidget->setSizePolicy(QSizePolicy::Preferred, QSizePolicy::Preferred);
    //ui->stackedWidget->adjustSize();
}

void MainWindow::on_get_Action_clicked()
{



}
